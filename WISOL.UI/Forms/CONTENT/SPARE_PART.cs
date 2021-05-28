using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class SPARE_PART : PageType
    {
        public string code = string.Empty;
        public string department = string.Empty;
        public string image = string.Empty;
        private string b64 = string.Empty;
        private bool onRemove = false;
        private bool brower = false;
        public SPARE_PART()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
        }
        public override void InitializePage()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                base.m_BindData.BindGridView (gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                

                gvList.Columns["IMAGE"].Visible = false;
                gvList.Columns["ID"].Visible = false;
                gvList.Columns["CREATED_AT"].Visible = false;
                gvList.Columns["UPDATED_AT"].Visible = false;
                gvList.Columns["DELETED_AT"].Visible = false;
                gvList.Columns["TOTAL"].Visible = false;
                gvList.Columns["ID"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                gvList.Columns["ID"].DisplayFormat.FormatString = "n0";
                gvList.Columns["MIN_STOCK"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                gvList.Columns["MIN_STOCK"].DisplayFormat.FormatString = "n0";
                gvList.Columns["QUANTITY_UNIT"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                gvList.Columns["QUANTITY_UNIT"].DisplayFormat.FormatString = "n0";

                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.INIT_PUT", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[0], "DEPARTMENT", "DEPARTMENT");
                    base.m_BindData.BindGridLookEdit(sltMaker, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(sltUnit, base.m_ResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");

                    base.m_BindData.BindGridLookEdit(sltGlaccount, base.m_ResultDB.ReturnDataSet.Tables[5], "GL_ACCOUNT", "GL_ACCOUNT");
                    base.m_BindData.BindGridLookEdit(sltCostCtr, base.m_ResultDB.ReturnDataSet.Tables[4], "COST_CTR", "COST_CTR");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                sltCostCtr.EditValue = string.Empty;
                txtCode.EditValue = string.Empty;
                txtDesc.EditValue = string.Empty;
                sltGlaccount.EditValue = string.Empty;
                sltDepartment.EditValue = Consts.DEPARTMENT;
                txtNameKr.EditValue = string.Empty;
                txtNameVi.EditValue = string.Empty;
                sltUnit.EditValue = string.Empty;
                picImage.Image = null;
                department = Consts.DEPARTMENT;
                sltMaker.EditValue = string.Empty;
                txtMinStock.EditValue = string.Empty;
                txtCodeOfMaker.EditValue = string.Empty;
                txtQtyUnit.EditValue = 0;
                brower = false;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        public override void SearchPage()
        {
            base.SearchPage();
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvList.Columns["IMAGE"].Visible = false;
                    gvList.Columns["LOCATION"].Visible = false;
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["CREATED_AT"].Visible = false;
                    gvList.Columns["UPDATED_AT"].Visible = false;
                    gvList.Columns["DELETED_AT"].Visible = false;
                    gvList.Columns["TOTAL"].Visible = false;
                    gvList.Columns["ID"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["ID"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["MIN_STOCK"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["MIN_STOCK"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["QUANTITY_UNIT"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["QUANTITY_UNIT"].DisplayFormat.FormatString = "n0";
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
                else
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.SHOW", new string[] { "A_DEPARTMENT", "A_ROLE", "A_CODE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, gvList.GetDataRow(e.RowHandle)["CODE"].NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        sltCostCtr.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["COST_CTR"].NullString();
                        txtCode.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].NullString();
                        txtDesc.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["DESC"].NullString();
                        sltGlaccount.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["GL_ACCOUNT"].NullString();
                        sltDepartment.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["DEPARTMENT"].NullString();
                        txtNameKr.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["NAME_KR"].NullString();
                        txtNameVi.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["NAME_VI"].NullString();
                        sltUnit.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["UNIT"].NullString();
                        picImage.Image = null;
                        sltMaker.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["MAKER"].NullString();
                        txtMinStock.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["MIN_STOCK"].NullString();
                        txtCodeOfMaker.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE_MAKER"].NullString();
                        txtQtyUnit.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["QUANTITY_UNIT"].NullString();

                        image = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString();

                        picImage.Image = null;
                        if (!string.IsNullOrWhiteSpace(base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString()))
                        {
                            byte[] imagebytes = Convert.FromBase64String(base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString());
                            using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                            {
                                picImage.Image = Image.FromStream(ms, true);
                            }
                            picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                            picImage.Size = picImage.Image.Size;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void gvList_CustomUnboundColumnData(object sender, DevExpress.XtraGrid.Views.Base.CustomColumnDataEventArgs e)
        {
            if ((e.IsGetData) && (e.Column.FieldName == "ProductImage"))
            {
                string fileName = gvList.GetListSourceRowCellValue(e.ListSourceRowIndex, "IMAGE").ToString();
                e.Value = Bitmap.FromFile(fileName);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (txtCode.Text.Trim() == string.Empty)
            {
                return;
            }

            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.DELETE"
                        , new string[] { "A_CODE",  "A_TRANS_USER", "A_DEPARTMENT"
                        }
                        , new string[] { txtCode.Text.Trim(), Consts.USER_INFO.Id, Consts.DEPARTMENT
                        }
                        );
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        SearchPage();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
                SearchPage();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCode.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(txtNameVi.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(sltUnit.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(sltMaker.EditValue.NullString()) == true
                    )
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                if (onRemove || image == string.Empty)
                {
                    b64 = string.Empty;
                }
                else b64 = image;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.PUT",
                    new string[] { "A_CODE", "@A_CODE_MAKER", "A_NAME_VI", "A_NAME_KR", "A_UNIT", "A_GL_ACCOUNT", "A_COST_CTR",
                        "A_DESC", "A_DEPARTMENT", "A_IMAGE","A_TRANS_USER", "A_MAKER", "A_MIN_STOCK", "A_QUANTITY_UNIT" },
                    new string[] { txtCode.EditValue.NullString(), txtCodeOfMaker.EditValue.NullString(), txtNameVi.EditValue.NullString(), txtNameKr.EditValue.NullString(),
                    sltUnit.EditValue.NullString(), sltGlaccount.EditValue.NullString(), sltCostCtr.EditValue.NullString(),
                    txtDesc.EditValue.NullString(), sltDepartment.EditValue.NullString(), b64 ,Consts.USER_INFO.Id, sltMaker.EditValue.NullString(), txtMinStock.EditValue.NullString(), txtQtyUnit.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    SearchPage();
                    Init_Control(true);
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Init_Control(true);
        }

        private void picImage_EditValueChanged(object sender, EventArgs e)
        {
            if(brower == false)
            {
                System.Drawing.Image returnImage = null;
                if (System.Windows.Clipboard.ContainsImage())
                {
                    onRemove = false;
                    returnImage = System.Windows.Forms.Clipboard.GetImage();
                    byte[] bytes = (byte[])(new ImageConverter()).ConvertTo(returnImage, typeof(byte[]));
                    image = Convert.ToBase64String(bytes);
                }
            }
            
        }

        private void picImage_LoadCompleted(object sender, EventArgs e)
        {
            SaveFileDialog openFileDialog = new SaveFileDialog();
            openFileDialog.Filter = "Images (*.jpg,*.jpeg, *.png)|*.jpg;*.jpeg; *.png";
            openFileDialog.Title = "Save an Image File";
            openFileDialog.ShowDialog();
            b64 = Convert.ToBase64String(File.ReadAllBytes(openFileDialog.FileName));
            image = b64;
            picImage.Image = Image.FromFile(openFileDialog.FileName);
        }

        private void btnBrower_Click(object sender, EventArgs e)
        {
            onRemove = false;
            brower = true;
            SaveFileDialog openFileDialog = new SaveFileDialog();
            openFileDialog.Filter = "Images (*.jpg,*.jpeg, *.png)|*.jpg;*.jpeg; *.png";
            openFileDialog.Title = "Save an Image File";
            openFileDialog.ShowDialog();
            b64 = Convert.ToBase64String(File.ReadAllBytes(openFileDialog.FileName));
            image = b64;
            picImage.Image = Image.FromFile(openFileDialog.FileName);
        }

        private void btnClearImg_Click(object sender, EventArgs e)
        {
            b64 = string.Empty;
            picImage.Image = null;
            onRemove = true;
            image = string.Empty;
            brower = false;
        }

        private void btnPaste_Click(object sender, EventArgs e)
        {
            System.Drawing.Image returnImage = null;
            if (System.Windows.Clipboard.ContainsImage())
            {
                onRemove = false;
                returnImage = System.Windows.Forms.Clipboard.GetImage();
                byte[] bytes = (byte[])(new ImageConverter()).ConvertTo(returnImage, typeof(byte[]));
                image = Convert.ToBase64String(bytes);
                picImage.Image = System.Windows.Forms.Clipboard.GetImage();
            }
        }
    }
}
