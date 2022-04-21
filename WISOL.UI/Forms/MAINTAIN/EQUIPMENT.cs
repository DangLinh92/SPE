using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.MAINTAIN
{
    public partial class EQUIPMENT : PageType
    {
        private DataTable DATA_SPARE_PART;
        private DataTable DATA_DOCUMENT;
        private List<FileInfo> lstFiles;
        private List<FileInfo> lstFilesAll;

        public EQUIPMENT()
        {
            InitializeComponent();
            this.Load += EQUIPMENT_Load;
        }

        private void EQUIPMENT_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "EQUIPMENT");

            if (DATA_SPARE_PART == null)
            {
                DATA_SPARE_PART = new DataTable();
                DATA_SPARE_PART.Columns.Add("CODE");
                DATA_SPARE_PART.Columns.Add("NAME_VI");
            }

            if (DATA_DOCUMENT == null)
            {
                DATA_DOCUMENT = new DataTable();
                DATA_DOCUMENT.Columns.Add("CODE");
                DATA_DOCUMENT.Columns.Add("FILE_NAME");
            }

            if (lstFiles == null)
            {
                lstFiles = new List<FileInfo>();
            }

            if (lstFilesAll == null)
            {
                lstFilesAll = new List<FileInfo>();
            }

            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    m_BindData.BindGridLookEdit(stlEquipmentType, datas[0], "CODE", "NAME");
                    m_BindData.BindGridLookEdit(stlLocationEQ, datas[1], "CODE", "NAME");

                    m_BindData.BindGridView(gcList, datas[2]);
                    gvList.OptionsView.ColumnAutoWidth = true;
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnBomEq_Click(object sender, EventArgs e)
        {
            POP.SPARE_PARTS pop = new POP.SPARE_PARTS();
            pop.Model = txtEQ_Model.EditValue.NullString();
            pop.DATA = DATA_SPARE_PART;
            pop.ShowDialog();
            DATA_SPARE_PART = pop.DATA;

            if (DATA_SPARE_PART != null)
            {
                //m_BindData.BindGridView(gcListBomEq, DATA_SPARE_PART);
                gcListBomEq.DataSource = DATA_SPARE_PART;
            }
        }

        private void btnUploadFile_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtEquipmentId.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtEquipmentId.Focus();
                    return;
                }

                using (OpenFileDialog openFileDialog = new OpenFileDialog())
                {
                    openFileDialog.Multiselect = true;
                    if (openFileDialog.ShowDialog() == DialogResult.OK)
                    {
                        foreach (string fileNames in openFileDialog.FileNames)
                        {
                            string contentType = "";
                            switch (Path.GetExtension(fileNames).ToLower())
                            {
                                case ".jpg":
                                    contentType = "image/jpeg";
                                    break;
                                case ".png":
                                    contentType = "image/png";
                                    break;
                                case ".gif":
                                    contentType = "image/gif";
                                    break;
                                case ".bmp":
                                    contentType = "image/bmp";
                                    break;
                                case ".doc":
                                    contentType = "application/msword";
                                    break;
                                case ".docx":
                                    contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                                    break;
                                case ".xls":
                                    contentType = "application/vnd.ms-excel";
                                    break;
                                case ".xlsx":
                                    contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                    break;
                                case ".pdf":
                                    contentType = "application/pdf";
                                    break;
                                case ".ppt":
                                    contentType = "application/vnd.ms-powerpoint";
                                    break;
                                case ".pptx":
                                    contentType = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
                                    break;
                            }

                            byte[] bytes = File.ReadAllBytes(fileNames);

                            lstFiles.Add(new FileInfo()
                            {
                                FileName = Path.GetFileName(fileNames),
                                ContentType = contentType,
                                Bytes = bytes
                            });

                            lstFilesAll.Add(new FileInfo()
                            {
                                FileName = Path.GetFileName(fileNames),
                                ContentType = contentType,
                                Bytes = bytes
                            });

                            DataRow row = DATA_DOCUMENT.NewRow();
                            row["CODE"] = txtEquipmentId.EditValue.NullString();
                            row["FILE_NAME"] = Path.GetFileName(fileNames);
                            DATA_DOCUMENT.Rows.Add(row);
                        }

                        //m_BindData.BindGridView(gcListFiles, DATA_DOCUMENT);
                        gcListFiles.DataSource = DATA_DOCUMENT;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtEquipmentId.EditValue.NullString() == "" || txtEquipmentName.EditValue.NullString() == "" || stlEquipmentType.EditValue.NullString() == "" || stlLocationEQ.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                string img = Convert.ToBase64String(ImageToByte(imgEq.Image));

                string sparepartList = "";
                foreach (DataRow row in DATA_SPARE_PART.Rows)
                {
                    sparepartList += row["CODE"].NullString() + "^";
                }

                if (sparepartList.Trim() != "" && sparepartList.Trim().Length > 0)
                    sparepartList = sparepartList.Substring(0, sparepartList.Length - 1);

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_EQUIPMENT.PUT",
                    new string[] { "A_CODE", "A_EQ_NAME", "A_EQ_TYPE", "A_EQ_YEAR", "A_EQ_LOCATION", "A_EQ_SERIAL", "A_EQ_ORIGIN", "A_EQ_MODEL",
                                   "A_DETAIL_INFO", "A_IMAGE", "A_USER", "A_DEPARTMENT", "A_DATA_SPARE", "A_STATUS", "A_DATE_IN", "A_SUB_LOCATION", "A_MANUFACTURER" },
                    new string[]
                    {
                                   txtEquipmentId.EditValue.NullString(),txtEquipmentName.EditValue.NullString(),stlEquipmentType.EditValue.NullString(),
                                   dateEQ_Year.EditValue.NullString(),stlLocationEQ.EditValue.NullString(),txtEQ_Serial.EditValue.NullString(),txtEQ_Origin.EditValue.NullString(),
                                   txtEQ_Model.EditValue.NullString(),memoEq.EditValue.NullString(),img,Consts.USER_INFO.Id,Consts.DEPARTMENT,
                                   sparepartList,cboStatus.EditValue.NullString(),dateIn.EditValue.NullString(),
                                   txtSubLocation.EditValue.NullString(),txtManuFacturer.EditValue.NullString()
                    });

                if (m_ResultDB.ReturnInt == 0)
                {
                    bool isError = false;

                    if (lstFiles.Count == 0)
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                        new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                        new string[] { txtEquipmentId.EditValue.NullString(), "", "", Consts.USER_INFO.Id, Consts.DEPARTMENT, "", "1" }, new byte[] { });

                        if (m_ResultDB.ReturnInt != 0)
                        {
                            isError = true;
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                    }
                    else
                    {
                        bool checkExist = false;
                        string isDelete = "";
                        foreach (FileInfo item in lstFilesAll)
                        {
                            checkExist = false;

                            foreach (FileInfo file in lstFiles)
                            {
                                if (item.FileName == file.FileName && item.ContentType == file.ContentType)
                                {
                                    checkExist = true;
                                    break;
                                }
                            }

                            if (checkExist)
                            {
                                isDelete = "FALSE";
                            }
                            else
                            {
                                isDelete = "TRUE";
                            }

                            base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                              new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                              new string[] { txtEquipmentId.EditValue.NullString(), item.FileName, item.ContentType, Consts.USER_INFO.Id, Consts.DEPARTMENT, isDelete, "1" }, item.Bytes);

                            if (m_ResultDB.ReturnInt != 0)
                            {
                                isError = true;
                                MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                                break;
                            }
                        }
                    }

                    if (!isError)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                        btnClear.PerformClick();
                    }
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public byte[] ImageToByte(Image img)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(img, typeof(byte[]));
        }

        private void gvListFiles_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.Column.FieldName == "DELETE")
                {
                    DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        DataRow row = gvListFiles.GetDataRow(e.RowHandle);
                        lstFiles.RemoveAll(f => f.FileName == row["FILE_NAME"].NullString());
                        DATA_DOCUMENT.Rows.Remove(row);
                        gcListFiles.DataSource = DATA_DOCUMENT;
                        //gvListFiles.DeleteRow(e.RowHandle);
                    }
                }
                else if (e.Column.FieldName == "DOWNLOAD")
                {
                    string contentType = lstFiles.FindAll(f => f.FileName == gvListFiles.GetRowCellValue(e.RowHandle, "FILE_NAME").NullString()).FirstOrDefault().ContentType.NullString();

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_DOCUMENT.DOWNLOAD",
                        new string[] { "A_CODE", "A_DEPARTMENT", "A_FILE_NAME", "A_CONTENT_TYPE", "A_IS_EQUIPMENT" },
                        new string[] { gvListFiles.GetRowCellValue(e.RowHandle, "CODE").NullString(), Consts.DEPARTMENT, gvListFiles.GetRowCellValue(e.RowHandle, "FILE_NAME").NullString(), contentType, "1" });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                        byte[] bytes = (byte[])data.Rows[0]["DATA"];

                        Stream stream;
                        SaveFileDialog saveFileDialog = new SaveFileDialog();
                        saveFileDialog.Filter = "All files (*.*)|*.*";
                        saveFileDialog.FilterIndex = 1;
                        saveFileDialog.RestoreDirectory = true;
                        saveFileDialog.FileName = gvListFiles.GetRowCellValue(e.RowHandle, "FILE_NAME").NullString();
                        if (saveFileDialog.ShowDialog() == DialogResult.OK)
                        {
                            stream = saveFileDialog.OpenFile();
                            stream.Write(bytes, 0, bytes.Length);
                            stream.Close();
                            MsgBox.Show("Download File Success!", MsgType.Information);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_EQUIPMENT.GET", new string[] { "A_CODE", "A_DEPARTMENT", "A_MODEL" }, 
                    new string[] 
                    { 
                        gvList.GetRowCellValue(e.RowHandle, "EQUIPMENT_ID").NullString(),
                        Consts.DEPARTMENT,
                        gvList.GetRowCellValue(e.RowHandle, "EQ_MODEL").NullString() 
                    });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    txtEquipmentId.EditValue = gvList.GetRowCellValue(e.RowHandle, "EQUIPMENT_ID").NullString();
                    txtEquipmentName.EditValue = gvList.GetRowCellValue(e.RowHandle, "EQUIPMENT_NAME").NullString();

                    if (datas[0].Rows.Count > 0)
                    {
                        stlEquipmentType.EditValue = datas[0].Rows[0]["EQUIPMENT_TYPE"].NullString();
                        dateEQ_Year.EditValue = datas[0].Rows[0]["EQ_MANUFACTURING_YEAR"].NullString() == "" ? null : "01-01-" + datas[0].Rows[0]["EQ_MANUFACTURING_YEAR"].NullString();
                        txtEQ_Serial.EditValue = datas[0].Rows[0]["EQ_SERIAL"].NullString();
                        txtEQ_Origin.EditValue = datas[0].Rows[0]["EQ_ORIGIN"].NullString();
                        txtEQ_Model.EditValue = datas[0].Rows[0]["EQ_MODEL"].NullString();
                        memoEq.EditValue = datas[0].Rows[0]["DETAIL_INFO"].NullString();
                        cboStatus.EditValue = datas[0].Rows[0]["STATUS"].NullString();
                        dateIn.EditValue = datas[0].Rows[0]["DATE_IN"].NullString();
                        txtManuFacturer.EditValue = datas[0].Rows[0]["MANUFACTURER"].NullString();
                    }
                    else
                    {
                        stlEquipmentType.EditValue = "";
                        dateEQ_Year.EditValue = "";
                        txtEQ_Serial.EditValue = "";
                        txtEQ_Origin.EditValue = "";
                        txtEQ_Model.EditValue = "";
                        memoEq.EditValue = "";
                        cboStatus.EditValue = "";
                        dateIn.EditValue = "";
                        txtManuFacturer.EditValue = "";
                    }

                    if (datas[3].Rows.Count > 0)
                    {
                        stlLocationEQ.EditValue = datas[3].Rows[0]["EQ_LOCATION_ID"].NullString();
                        txtSubLocation.EditValue = datas[3].Rows[0]["SUB_LOCATION"].NullString();
                    }
                    else
                    {
                        stlLocationEQ.EditValue = "";
                        txtSubLocation.EditValue = "";
                    }

                    lstFiles.Clear();
                    DATA_DOCUMENT.Rows.Clear();
                    lstFilesAll.Clear();

                    foreach (DataRow item in datas[1].Rows)
                    {
                        lstFiles.Add(new FileInfo()
                        {
                            FileName = item["NAME"].NullString(),
                            ContentType = item["CONTENT_TYPE"].NullString(),
                            Bytes = (byte[])item["DATA"]
                        });

                        lstFilesAll.Add(new FileInfo()
                        {
                            FileName = item["NAME"].NullString(),
                            ContentType = item["CONTENT_TYPE"].NullString(),
                            Bytes = (byte[])item["DATA"]
                        });

                        DataRow row = DATA_DOCUMENT.NewRow();
                        row["CODE"] = item["CODE"].NullString();
                        row["FILE_NAME"] = item["NAME"].NullString();
                        DATA_DOCUMENT.Rows.Add(row);
                    }
                    gcListFiles.DataSource = DATA_DOCUMENT;

                    DATA_SPARE_PART.Rows.Clear();

                    foreach (DataRow item in datas[2].Rows)
                    {
                        DataRow doc = DATA_SPARE_PART.NewRow();
                        doc["CODE"] = item["SPARE_PART_CODE"].NullString();
                        doc["NAME_VI"] = item["NAME_VI"].NullString();
                        DATA_SPARE_PART.Rows.Add(doc);
                    }
                    //m_BindData.BindGridView(gcListBomEq, DATA_SPARE_PART);
                    gcListBomEq.DataSource = DATA_SPARE_PART;

                    string image = datas[0].Rows[0]["IMAGE"].NullString();

                    if (!string.IsNullOrWhiteSpace(image))
                    {
                        try
                        {
                            byte[] imagebytes = Convert.FromBase64String(image);
                            using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                            {
                                imgEq.Image = Image.FromStream(ms, true);
                            }
                            imgEq.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                            imgEq.Size = imgEq.Image.Size;
                        }
                        catch (Exception)
                        {
                            imgEq.Image = null;
                        }
                    }
                    else
                    {
                        imgEq.Image = null;
                    }
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtEquipmentId.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtEquipmentId.Focus();
                    return;
                }
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT.DELETE", new string[] { "A_CODE", "A_DEPARTMENT" }, new string[] { txtEquipmentId.EditValue.NullString(), Consts.DEPARTMENT });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                        btnClear.PerformClick();
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                txtEquipmentId.EditValue = "";
                txtEquipmentName.EditValue = "";
                stlEquipmentType.EditValue = "";
                dateEQ_Year.EditValue = "";
                stlLocationEQ.EditValue = "";
                txtEQ_Serial.EditValue = "";
                txtEQ_Origin.EditValue = "";
                txtEQ_Model.EditValue = "";
                memoEq.EditValue = "";

                DATA_DOCUMENT.Rows.Clear();
                DATA_SPARE_PART.Rows.Clear();
                lstFiles.Clear();
                lstFilesAll.Clear();

                gcListFiles.DataSource = DATA_DOCUMENT;
                //m_BindData.BindGridView(gcListBomEq, DATA_SPARE_PART);
                gcListBomEq.DataSource = DATA_SPARE_PART;

                imgEq.Image = null;
                txtSubLocation.EditValue = "";
                txtManuFacturer.EditValue = "";
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvListBomEq_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                if (e.Column.FieldName == "DELETE")
                {
                    DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        DataRow row = gvListBomEq.GetDataRow(e.RowHandle);
                        DATA_SPARE_PART.Rows.Remove(row);
                        gcListBomEq.DataSource = DATA_SPARE_PART;
                        //gvListFiles.DeleteRow(e.RowHandle);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnFindPart_Click(object sender, EventArgs e)
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_MODEL_BOM", new string[] { "A_DEPT_CODE", "A_MODEL" }, new string[] { Consts.DEPARTMENT,txtEQ_Model.EditValue.NullString() });

            if (m_ResultDB.ReturnInt == 0)
            {
                gcListBomEq.DataSource = m_ResultDB.ReturnDataSet.Tables[0];
            }
            else
            {
                MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
            }
        }
    }

    public class FileInfo
    {
        public string FileName { get; set; }
        public string ContentType { get; set; }
        public byte[] Bytes { get; set; }
    }
}
