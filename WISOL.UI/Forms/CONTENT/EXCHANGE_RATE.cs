using DevExpress.XtraEditors;
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

namespace Wisol.MES.Forms.CONTENT
{
    public partial class EXCHANGE_RATE : PageType
    {
        public EXCHANGE_RATE()
        {
            InitializeComponent();
        }

        public override void Form_Show()
        {
            base.Form_Show();

            this.InitializePage();

            Classes.Common.SetFormIdToButton(this, "EXCHANGE_RATE");
        }

        public override void InitializePage()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EXRATE.INIT_LIST", new string[] { }, new string[] { });
                if(base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvList.Columns["RATE"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["RATE"].DisplayFormat.FormatString = "n2";
                    gvList.Columns["CREATED_AT"].Visible = false;
                    gvList.Columns["UPDATED_AT"].Visible = false;
                    gvList.Columns["DELETED_AT"].Visible = false;
                    gvList.Columns["ID"].Visible = false;
                    Init_Control(true);
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
                DateTime dateTime = DateTime.Today;
                txtFrom.EditValue = "USD";
                txtTo.EditValue = "VND";
                dtMonth.EditValue = dateTime.ToString("Y");
                txtRate.EditValue = string.Empty;
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EXRATE.GET_LIST", new string[] { }, new string[] { });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);

                    gvList.Columns["RATE"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["RATE"].DisplayFormat.FormatString = "n2";
                    gvList.Columns["CREATED_AT"].Visible = false;
                    gvList.Columns["UPDATED_AT"].Visible = false;
                    gvList.Columns["DELETED_AT"].Visible = false;
                    gvList.Columns["ID"].Visible = false;

                    Init_Control(true);
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
                if(string.IsNullOrEmpty(dtMonth.EditValue.NullString()) || string.IsNullOrEmpty(txtRate.EditValue.NullString())){
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EXRATE.PUT_ITEM",
                    new string[] { "A_MONTH", "A_FROM", "A_TO", "A_RATE", "A_USER_ID" },
                    new string[] { dtMonth.DateTime.ToString("yyyyMM"), txtFrom.EditValue.NullString(), txtTo.EditValue.NullString(),
                    txtRate.EditValue.NullString(), Consts.USER_INFO.Id});
                if(base.m_ResultDB.ReturnInt == 0)
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
                    txtRate.EditValue = gvList.GetDataRow(e.RowHandle)["RATE"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
