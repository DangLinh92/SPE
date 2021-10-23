using System;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class UPDATE_SPAREPART_CODE : FormType
    {
        public UPDATE_SPAREPART_CODE()
        {
            InitializeComponent();
        }

        public string SpareCode_Old { get; set; }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(string.Empty + txtCodeOld.EditValue) || string.IsNullOrEmpty(string.Empty + txtCodeNew.EditValue))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("XÁC NHẬN THAY ĐỔI CODE!!!".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.UPDATE_CODE",
                    new string[] { "A_DEPARTMENT", "A_CODE_OLD", "A_CODE_NEW" },
                    new string[] { Consts.DEPARTMENT, txtCodeOld.EditValue.NullString().ToUpper(), txtCodeNew.EditValue.NullString().ToUpper() });

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
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message.Translation(), MsgType.Error);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void UPDATE_SPAREPART_CODE_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "UPDATE_SPAREPART_CODE", this);
            txtCodeOld.EditValue = SpareCode_Old;
            txtCodeNew.Focus();
        }
    }
}
