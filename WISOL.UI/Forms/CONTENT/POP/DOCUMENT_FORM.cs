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

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class DOCUMENT_FORM : FormType
    {
        public string SparepartCode { get; set; }

        public DOCUMENT_FORM()
        {
            InitializeComponent();
            this.Load += DOCUMENT_FORM_Load;
        }

        private void DOCUMENT_FORM_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "DOCUMENT_FORM", this);
            Init();
        }

        private void Init()
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_DOCUMENT_BY_ID", new string[] { "A_CODE", "A_DEPARTMENT" }, new string[] { SparepartCode, Consts.DEPARTMENT });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    gcList.DataSource = data;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
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


                            base.mResultDB = base.mDBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                              new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                              new string[] { SparepartCode, Path.GetFileName(fileNames), contentType, Consts.USER_INFO.Id, Consts.DEPARTMENT, "FALSE", "0" }, bytes);
                        }

                        gcList.DataSource = base.mResultDB.ReturnDataSet.Tables[0];
                        MsgBox.Show("Upload Success!!!", MsgType.Information);
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
                {
                    return;
                }
               
                if (e.Column.FieldName == "DOWNLOAD")
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_DOCUMENT.DOWNLOAD",
                        new string[] { "A_CODE", "A_DEPARTMENT", "A_FILE_NAME", "A_CONTENT_TYPE", "A_IS_EQUIPMENT" },
                        new string[] { SparepartCode, Consts.DEPARTMENT, gvList.GetRowCellValue(e.RowHandle, "NAME").NullString(),
                                       gvList.GetRowCellValue(e.RowHandle, "CONTENT_TYPE").NullString(), "0" });

                    if (mResultDB.ReturnInt == 0)
                    {
                        DataTable data = mResultDB.ReturnDataSet.Tables[0];
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
                        base.mResultDB = base.mDBaccess.ExcuteProcWithBytes("PKG_BUSINESS_SP_DOCUMENT.UPLOAD",
                           new string[] { "A_CODE", "A_NAME_FILE", "A_CONTENT_TYPE", "A_USER", "A_DEPARTMENT", "A_IS_DELETE", "A_IS_EQUIPMENT" }, "A_DATA",
                           new string[] { SparepartCode, gvList.GetRowCellValue(e.RowHandle, "NAME").NullString(),
                                         gvList.GetRowCellValue(e.RowHandle, "CONTENT_TYPE").NullString(), Consts.USER_INFO.Id, Consts.DEPARTMENT, "TRUE", "0" }, new byte[] { });

                        if (mResultDB.ReturnInt != 0)
                        {
                            MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                        else
                        {
                            MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
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
    }
}
