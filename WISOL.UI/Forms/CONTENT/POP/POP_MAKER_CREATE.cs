using System;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class POP_MAKER_CREATE : FormType
    {
        public POP_MAKER_CREATE()
        {
            InitializeComponent();
            InitializePage();
        }
        private void InitializePage()
        {
            try
            {
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MAKER@GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (mResultDB.ReturnInt == 0)
                {
                    base.mBindData.BindGridLookEdit(sltDepartment, base.mResultDB.ReturnDataSet.Tables[1], "DEPARTMENT", "DEPARTMENT");
                }
                Init_Control(true);

                Classes.Common.SetFormIdToButton(null, "POP_MAKER_CREATE", this);
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
                txtCode.EditValue = string.Empty;
                txtName.EditValue = string.Empty;
                txtPhone.EditValue = string.Empty;
                txtAddress.EditValue = string.Empty;
                sltDepartment.EditValue = Consts.DEPARTMENT;
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

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}