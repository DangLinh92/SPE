using System;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.REPORT
{
    public partial class REPORT_STOCK : PageType
    {
        public REPORT_STOCK()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();

            this.InitializePage();

            Classes.Common.SetFormIdToButton(this, "REPORT_STOCK");
        }
        public override void InitializePage()
        {
            try
            {
                DateTime date = DateTime.Now;
                var firstDayOfMonth = new DateTime(date.Year, date.Month, 1);
                var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

                dtOpenDate.EditValue = firstDayOfMonth.ToString("yyyy-MM-dd");
                dtCloseDate.EditValue = lastDayOfMonth.ToString("yyyy-MM-dd");

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_REPORT_STOCKIN.GET"
                    , new string[] { "A_ROLE", "A_DEPARTMENT", "A_OPEN_DATE", "A_CLOSE_DATE" }
                    , new string[] { Consts.USER_INFO.UserRole, Consts.DEPARTMENT, dtOpenDate.DateTime.ToString("yyyyMMdd"), dtCloseDate.DateTime.ToString("yyyyMMdd") }
                    );
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList,
                        base.m_ResultDB.ReturnDataSet.Tables[0]
                        );
                    Init_Control(true);
                    gvList.Columns["CODE"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvList.Columns["NAME_VI"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvList.Columns["NAME_KR"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvList.Columns["UNIT"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvList.Columns["COST_ID"].Visible = false;

                    gvList.Columns["COST"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["COST"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["OPENING_STOCK"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["OPENING_STOCK"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["STOCK_IN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["STOCK_IN"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["STOCK_OUT"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["STOCK_OUT"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["CLOSING_STOCK"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["CLOSING_STOCK"].DisplayFormat.FormatString = "n0";
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
                
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
