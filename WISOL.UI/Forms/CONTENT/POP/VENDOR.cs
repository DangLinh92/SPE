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
    public partial class VENDOR : FormType
    {
        public VENDOR()
        {
            InitializeComponent();
            this.Load += VENDOR_Load;
        }

        private void VENDOR_Load(object sender, EventArgs e)
        {
            txtVendorId.Focus();
            Classes.Common.SetFormIdToButton(null, "VENDOR", this);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtVendorId.EditValue.NullString() == "" || txtVendorName.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtVendorId.Focus();
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_VENDOR.PUT",
                new string[] { "A_VENDOR_ID", "A_VENDOR_NAME" },
                new string[] { txtVendorId.EditValue.NullString(), txtVendorName.EditValue.NullString() });

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
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

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
