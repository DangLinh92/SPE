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

namespace Wisol.MES.Forms.REPORT
{
    public partial class IN_OUT_STOCK_REPORT : PageType
    {
        public IN_OUT_STOCK_REPORT()
        {
            InitializeComponent();
            this.Load += IN_OUT_STOCK_REPORT_Load;
        }

        private void IN_OUT_STOCK_REPORT_Load(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.INIT_SPAREPART", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    m_BindData.BindGridLookEdit(stlName, datas[0],"CODE","NAME");
                    m_BindData.BindGridLookEdit(stlDeptCode, datas[1], "CODE", "DEPARTMENT");
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
