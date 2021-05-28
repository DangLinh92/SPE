using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;
 
namespace Wisol.MES.Forms.CONTENT
{
    public partial class STOCK_OUT : PageType
    {
        DataTable dt = new DataTable();
        public STOCK_OUT()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            Init_Control(true);
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                txtSparePart.EditValue = string.Empty;
                txtSparePart.Focus();
                txtSparePart.Select();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void txtSparePart_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                string[] arr =txtSparePart.EditValue.ToString().Split('.');

                if(arr.Length == 3)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKOUT.GET", new string[] { "A_DEPARTMENT", "A_ROLE", "A_SP", "A_STOCKIN", "A_LOT" },
                        new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, arr[0], arr[1], txtSparePart.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        if (dt.Rows.Count == 0)
                        {
                            dt = base.m_ResultDB.ReturnDataSet.Tables[0];
                        }
                        else
                        {
                            dt.Merge(base.m_ResultDB.ReturnDataSet.Tables[0]);
                        }
                        base.m_BindData.BindGridView(gcList, dt);
                    }
                    else if (base.m_ResultDB.ReturnInt == -1)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                    Init_Control(true);
                }
                else
                {
                    MsgBox.Show("Vật tư không hợp lệ", MsgType.Error);
                }

            }
        }

        private void btnStockOut_Click(object sender, EventArgs e)
        {
            if(dt.Rows.Count == 0)
            {
                return;
            }
            DataSet ds = new DataSet();
            ds.Tables.Add(dt.Copy());
            string fileName = "C:\\TestData.xml";
            ds.WriteXml(fileName, XmlWriteMode.WriteSchema);
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKOUT.PUT", new string[] { "A_DEPARTMENT", "A_ROLE", "A_DATA"},
                new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, ds.ToString() });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                MsgBox.Show("Xuat kho thanh cong", MsgType.Information);
            }

        }
    }
}
