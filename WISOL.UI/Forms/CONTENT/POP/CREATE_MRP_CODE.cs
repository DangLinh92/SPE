using System;
using System.Linq;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class CREATE_MRP_CODE : FormType
    {
        public CREATE_MRP_CODE()
        {
            InitializeComponent();
            this.Load += CREATE_MRP_CODE_Load;
        }

        private void CREATE_MRP_CODE_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "CREATE_MRP_CODE", this);
        }

        private void btnGencode_Click(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP.CREATE_MRP_CODE",
                 new string[] { "A_DEPARTMENT" },
                 new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    txtMrpCode.EditValue = mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].NullString();
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
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
                if (txtMrpCode.EditValue.NullString() == string.Empty)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP_LIST.PUT",
                new string[] { "A_DEPARTMENT", "A_MRP_CODE", "A_TITLE", "A_STATUS", "A_DATE_NEED_FINISH", "A_USER" },
                new string[] { Consts.DEPARTMENT, txtMrpCode.EditValue.NullString(), txtTitle.EditValue.NullString(), "NEW", string.Empty, Consts.USER_INFO.Id });

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                    this.Close();
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
