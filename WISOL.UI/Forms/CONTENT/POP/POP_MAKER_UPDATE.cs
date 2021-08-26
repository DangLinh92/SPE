using System;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class POP_MAKER_UPDATE : FormType
    {
        public POP_MAKER_UPDATE(string CODE)
        {
            InitializeComponent();
            try
            {
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MAKER.SHOW", new string[] { "A_CODE", "A_ROLE", "A_DEPARTMENT" }, new string[] { CODE, Consts.USER_INFO.UserRole, Consts.DEPARTMENT });
                if (base.mResultDB.ReturnInt == 0)
                {
                    txtCode.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].ToString();
                    txtName.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["NAME"].ToString();
                    txtAddress.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["ADDRESS"].ToString();
                    txtPhone.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["PHONE"].ToString();
                    base.mBindData.BindGridLookEdit(sltDepartment, base.mResultDB.ReturnDataSet.Tables[1], "DEPARTMENT", "DEPARTMENT");
                    sltDepartment.EditValue = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["DEPARTMENT"].ToString();

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnSave1_Click(object sender, EventArgs e)
        {
            try
            {
                if (String.IsNullOrEmpty(txtCode.EditValue.NullString()) == true || string.IsNullOrEmpty(txtName.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_102".Translation(), MsgType.Warning);
                    return;
                }
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MAKER.PUT",
                    new string[] { "A_CODE", "A_NAME", "A_ADDRESS", "A_DEPARTMENT", "A_TRANS_USER", "A_PHONE" },
                    new string[] { txtCode.EditValue.NullString(), txtName.EditValue.NullString(), txtAddress.EditValue.NullString(), sltDepartment.EditValue.NullString(), Consts.USER_INFO.Id, txtPhone.EditValue.NullString() });
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

        private void btnCancel1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}