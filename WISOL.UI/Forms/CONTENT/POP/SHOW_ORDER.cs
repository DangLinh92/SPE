using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class SHOW_ORDER : FormType
    {
        public string DateSearch { get; set; }
        public SHOW_ORDER()
        {
            InitializeComponent();
            this.Load += SHOW_ORDER_Load;
        }

        private void SHOW_ORDER_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "SHOW_ORDER", this);
            try
            {
                var firstDayOfMonth = new DateTime(DateTime.Parse(DateSearch).Year, DateTime.Parse(DateSearch).Month, 1);
                var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd");

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PR@SEARCH_PR_BY_TIME",
                      new string[] { "A_DEPARTMENT", "A_FROM_TIME", "A_TO_TIME" },
                      new string[] { Consts.DEPARTMENT, firstDayOfMonth.ToString("yyyy-MM-dd"), lastDayOfMonth });

                if (mResultDB.ReturnInt == 0)
                {
                    mBindData.BindGridView(gcList, mResultDB.ReturnDataSet.Tables[0]);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
