using DevExpress.XtraTreeList.Columns;
using DevExpress.XtraTreeList.Nodes;
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
    public partial class EQUIPMENT_TREE : PageType
    {
        public EQUIPMENT_TREE()
        {
            InitializeComponent();
            this.Load += EQUIPMENT_TREE_Load;
        }

        private void EQUIPMENT_TREE_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "EQUIPMENT");
            CreateColumns();
            InitData(true);
        }

        private void InitData(bool isFirst = false)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT_BOM.INIT",
                    new string[] { "A_DEPARTMENT", "A_EQUIPMENT" },
                    new string[] { Consts.DEPARTMENT, stlEquipment.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;

                    if (isFirst)
                    {
                        m_BindData.BindGridLookEdit(stlEquipment, datas[0], "EQUIPMENT_ID", "EQUIPMENT_NAME");
                    }

                    if (datas[2].Rows.Count > 0)
                    {
                        treeListEquipment.ClearNodes();
                        treeListEquipment.BeginUnboundLoad();
                        TreeListNode parentForRootNodes = null;
                        TreeListNode rootNode = treeListEquipment.AppendNode(new object[] { datas[2].Rows[0]["EQUIPMENT_ID"].NullString(), datas[2].Rows[0]["EQUIPMENT_NAME"].NullString() }, parentForRootNodes);

                        foreach (DataRow row in datas[2].Rows)
                        {
                            treeListEquipment.AppendNode(new object[] { row["CODE"].NullString(), row["NAME_VI"].NullString() }, rootNode);
                        }

                        treeListEquipment.EndUnboundLoad();
                        treeListEquipment.ExpandAll();
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

        private void CreateColumns()
        {
            // Create three columns
            treeListEquipment.BeginUpdate();
            TreeListColumn col1 = treeListEquipment.Columns.Add();
            col1.FieldName = "CODE";
            col1.Caption = "CODE";
            col1.VisibleIndex = 0;
            TreeListColumn col2 = treeListEquipment.Columns.Add();
            col2.FieldName = "NAME";
            col2.Caption = "NAME";
            col2.VisibleIndex = 1;

            treeListEquipment.Columns["CODE"].OptionsColumn.AllowEdit = false;
            treeListEquipment.Columns["NAME"].OptionsColumn.AllowEdit = false;
            treeListEquipment.EndUpdate();
        }

        private void stlEquipment_EditValueChanged(object sender, EventArgs e)
        {
            InitData();
        }

        private void treeListEquipment_FocusedNodeChanged(object sender, DevExpress.XtraTreeList.FocusedNodeChangedEventArgs e)
        {
            try
            {
                if (e.Node == null)
                    return;

                string code = e.Node.GetValue(0).NullString();
                string isEquipment = "1";

                if (code != stlEquipment.EditValue.NullString())
                {
                    isEquipment = "0";
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_EQUIPMENT.GET_BY_ID",
                        new string[] { "A_CODE", "A_DEPARTMENT", "A_IS_EQUIPMENT" },
                        new string[] { code, Consts.DEPARTMENT, isEquipment });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;

                    string image = datas[0].Rows[0]["IMAGE"].NullString();

                    if (!string.IsNullOrWhiteSpace(image))
                    {
                        try
                        {
                            byte[] imagebytes = Convert.FromBase64String(image);
                            using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                            {
                                picImage.Image = Image.FromStream(ms, true);
                            }
                            picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                            picImage.Size = picImage.Image.Size;
                        }
                        catch (Exception)
                        {
                            picImage.Image = null;
                        }
                    }
                    else
                    {
                        picImage.Image = null;
                    }

                    txtCode.Text = datas[0].Rows[0]["CODE"].NullString();
                    txtName.Text = datas[0].Rows[0]["NAME"].NullString();
                    txtType.Text = datas[0].Rows[0]["TYPE"].NullString();
                    txtLocation.Text = datas[0].Rows[0]["EQ_LOCATION_NAME"].NullString();
                    txtYearManual.Text = datas[0].Rows[0]["EQ_MANUFACTURING_YEAR"].NullString();
                    txtSerial.Text = datas[0].Rows[0]["EQ_SERIAL"].NullString();
                    txtModel.Text = datas[0].Rows[0]["EQ_MODEL"].NullString();
                    txtMadeIn.Text = datas[0].Rows[0]["EQ_ORIGIN"].NullString();
                    txtStatus.Text = datas[0].Rows[0]["STATUS"].NullString();
                    txtMaterial.Text = datas[0].Rows[0]["MATERIAL"].NullString();
                    txtSize.Text = datas[0].Rows[0]["SIZE"].NullString();
                    txtWeight.Text = datas[0].Rows[0]["WEIGHT"].NullString();
                    memoDes.EditValue = datas[0].Rows[0]["DETAIL_INFO"].NullString();

                    gcList.DataSource = datas[1];

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
                {
                    return;
                }
                string isEquipment = "1";
                if (txtCode.EditValue.NullString() == stlEquipment.EditValue.NullString())
                {
                    isEquipment = "1";
                }
                else
                {
                    isEquipment = "0";
                }
                if (e.Column.FieldName == "DOWNLOAD")
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_DOCUMENT.DOWNLOAD",
                        new string[] { "A_CODE", "A_DEPARTMENT", "A_FILE_NAME", "A_CONTENT_TYPE", "A_IS_EQUIPMENT" },
                        new string[] { txtCode.EditValue.NullString(), Consts.DEPARTMENT, gvList.GetRowCellValue(e.RowHandle, "NAME").NullString(),
                                       gvList.GetRowCellValue(e.RowHandle, "CONTENT_TYPE").NullString(), isEquipment });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                        byte[] bytes = (byte[])data.Rows[0]["DATA"];

                        Stream stream;
                        SaveFileDialog saveFileDialog = new SaveFileDialog();
                        saveFileDialog.Filter = "All files (*.*)|*.*";
                        saveFileDialog.FilterIndex = 1;
                        saveFileDialog.RestoreDirectory = true;
                        saveFileDialog.FileName = gvList.GetRowCellValue(e.RowHandle, "NAME").NullString();
                        if (saveFileDialog.ShowDialog() == DialogResult.OK)
                        {
                            stream = saveFileDialog.OpenFile();
                            stream.Write(bytes, 0, bytes.Length);
                            stream.Close();
                            MsgBox.Show("Download File Success!", MsgType.Information);
                        }
                    }
                }
                else if (e.Column.FieldName == "DELETE")
                {
                    DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                           new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                           new string[] { txtCode.EditValue.NullString(), gvList.GetRowCellValue(e.RowHandle, "NAME").NullString(),
                                         gvList.GetRowCellValue(e.RowHandle, "CONTENT_TYPE").NullString(), Consts.USER_INFO.Id, Consts.DEPARTMENT, "TRUE", isEquipment }, new byte[] { });

                        if (m_ResultDB.ReturnInt != 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                        else
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                            gvList.DeleteRow(e.RowHandle);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnUpLoadFile_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtCode.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtCode.Focus();
                    return;
                }

                string isEquipment = "1";
                if (txtCode.EditValue.NullString() == stlEquipment.EditValue.NullString())
                {
                    isEquipment = "1";
                }
                else
                {
                    isEquipment = "0";
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


                            base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                              new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                              new string[] { txtCode.EditValue.NullString(), Path.GetFileName(fileNames), contentType, Consts.USER_INFO.Id, Consts.DEPARTMENT, "FALSE", isEquipment }, bytes);
                        }

                        //m_BindData.BindGridView(gcListFiles, DATA_DOCUMENT);
                        gcList.DataSource = base.m_ResultDB.ReturnDataSet.Tables[0];
                        MsgBox.Show("Upload Success!!!", MsgType.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnHistory_maintain_Click(object sender, EventArgs e)
        {
            try
            {
                Consts.mainForm.NewPageFromOtherPage("HISTORY_MAINTAIN", "Lịch sử bảo trì thiết bị", "W", "Y", stlEquipment.EditValue.NullString());
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
