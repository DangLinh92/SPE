using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
                if (string.IsNullOrEmpty(""+txtCodeOld.EditValue) || string.IsNullOrEmpty("" + txtCodeNew.EditValue))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.UPDATE_CODE", 
                    new string[] { "A_DEPARTMENT", "A_CODE_OLD", "A_CODE_NEW" }, 
                    new string[] { Consts.DEPARTMENT,txtCodeOld.EditValue.NullString().ToUpper(),txtCodeNew.EditValue.NullString().ToUpper() });

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
                MsgBox.Show(ex.Message.Translation(), MsgType.Error);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void UPDATE_SPAREPART_CODE_Load(object sender, EventArgs e)
        {
            txtCodeOld.EditValue = SpareCode_Old;
            txtCodeNew.Focus();
        }
    }
}
