using System;
using System.Data;
using System.Linq;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class HISTORY_MOVE_LOCATION : FormType
    {
        public string StockCode { get; set; }

        public HISTORY_MOVE_LOCATION()
        {
            InitializeComponent();
            this.Load += HISTORY_MOVE_LOCATION_Load;
        }

        private void HISTORY_MOVE_LOCATION_Load(object sender, EventArgs e)
        {
            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_MOVE_HISTORY.GET", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, StockCode });
            if (mResultDB.ReturnInt == 0)
            {
                DataTable data = mResultDB.ReturnDataSet.Tables[0];
                mBindData.BindGridView(gcList, data);
                this.gvList.OptionsView.ColumnAutoWidth = true;
            }

            Classes.Common.SetFormIdToButton(null, "HISTORY_MOVE_LOCATION", this);
        }
    }
}
