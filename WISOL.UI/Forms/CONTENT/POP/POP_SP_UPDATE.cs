
using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class POP_SP_UPDATE : FormType
    {
        public string department = string.Empty;
        public string image = string.Empty;
        private string b64 = string.Empty;
        private bool onRemove = false;
        public POP_SP_UPDATE(string CODE)
        {
            InitializeComponent();
            InitializePage(CODE);
        }
        private void InitializePage(string CODE)
        {
            try
            {
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.INIT_PUT", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (base.mResultDB.ReturnInt == 0)
                {
                    base.mBindData.BindGridLookEdit(sltDepartment, base.mResultDB.ReturnDataSet.Tables[0], "DEPARTMENT", "DEPARTMENT");
                    base.mBindData.BindGridLookEdit(sltLocation, base.mResultDB.ReturnDataSet.Tables[1], "CODE", "LOCATION");
                    base.mBindData.BindGridLookEdit(sltMaker, base.mResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.mBindData.BindGridLookEdit(sltUnit, base.mResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.SHOW", new string[] { "A_DEPARTMENT", "A_ROLE", "A_CODE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, CODE });
                if (base.mResultDB.ReturnInt == 0)
                {
                    txtCostCtr.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["COST_CTR"].ToString();
                    txtCode.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].ToString();
                    txtMinStock.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["MIN_STOCK"].ToString();
                    txtDesc.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["DESC"].ToString();
                    txtGlaccount.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["GL_ACCOUNT"].ToString();
                    txtNameKr.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["NAME_KR"].ToString();
                    txtNameVi.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["NAME_VI"].ToString();
                    txtCodeOfMaker.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE_MAKER"].ToString();

                    sltDepartment.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["DEPARTMENT"].ToString();
                    sltLocation.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["LOCATION"].ToString();
                    sltUnit.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["UNIT"].ToString();
                    sltMaker.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["MAKER"].ToString();
                    image = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString();

                    picImage.Image = null;
                    if (!string.IsNullOrWhiteSpace(base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString()))
                    {
                        byte[] imagebytes = Convert.FromBase64String(base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString());
                        using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                        {
                            picImage.Image = Image.FromStream(ms, true);
                        }
                        picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                        picImage.Size = picImage.Image.Size;
                    }

                }
                //Init_Control(true);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                txtCostCtr.EditValue = string.Empty;
                txtCode.EditValue = string.Empty;
                txtDesc.EditValue = string.Empty;
                txtGlaccount.EditValue = string.Empty;
                sltDepartment.EditValue = Consts.DEPARTMENT;
                txtNameKr.EditValue = string.Empty;
                txtNameVi.EditValue = string.Empty;
                sltLocation.EditValue = string.Empty;
                sltUnit.EditValue = string.Empty;
                picImage.Image = null;
                department = Consts.DEPARTMENT;
                sltMaker.EditValue = string.Empty;
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
                if (String.IsNullOrEmpty(txtCode.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(txtNameVi.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(sltUnit.EditValue.NullString()) == true ||
                    string.IsNullOrEmpty(sltLocation.EditValue.NullString()) == true
                    )
                {
                    MsgBox.Show("MSG_ERR_102".Translation(), MsgType.Warning);
                    return;
                }
                if (onRemove || image == string.Empty)
                {
                    b64 = string.Empty;
                }
                else b64 = image;
                string importDate = string.Empty;
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.PUT",
                    new string[] { "A_CODE", "@A_CODE_MAKER", "A_NAME_VI", "A_NAME_KR", "A_UNIT", "A_GL_ACCOUNT", "A_COST_CTR",
                        "A_LOCATION", "A_DESC", "A_DEPARTMENT",
                        "A_IMAGE","A_TRANS_USER", "A_MAKER", "A_MIN_STOCK" },
                    new string[] { txtCode.EditValue.NullString(), txtCodeOfMaker.EditValue.NullString(), txtNameVi.EditValue.NullString(), txtNameKr.EditValue.NullString(),
                    sltUnit.EditValue.NullString(), txtGlaccount.EditValue.NullString(), txtCostCtr.EditValue.NullString(),
                    sltLocation.EditValue.NullString(), txtDesc.EditValue.NullString(), sltDepartment.EditValue.NullString(), image ,Consts.USER_INFO.Id, sltMaker.EditValue.NullString(), txtMinStock.EditValue.NullString() });
                if (base.mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                    this.Close();
                }
                else
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Warning);

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void picImage_EditValueChanged(object sender, EventArgs e)
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

        private void btnBrower_Click(object sender, EventArgs e)
        {
            onRemove = false;
            SaveFileDialog openFileDialog = new SaveFileDialog();
            openFileDialog.Filter = "Images (*.jpg,*.jpeg, *.png)|*.jpg;*.jpeg; *.png";
            openFileDialog.Title = "Save an Image File";
            openFileDialog.ShowDialog();
            b64 = Convert.ToBase64String(File.ReadAllBytes(openFileDialog.FileName));
            image = b64;
            picImage.Image = Image.FromFile(openFileDialog.FileName);
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            b64 = string.Empty;
            picImage.Image = null;
            onRemove = true;
            image = string.Empty;
        }
    }
}