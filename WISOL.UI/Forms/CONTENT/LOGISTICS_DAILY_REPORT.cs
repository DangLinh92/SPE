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

namespace Wisol.MES.Forms.CONTENT
{
    public partial class LOGISTICS_DAILY_REPORT : PageType
    {
        public LOGISTICS_DAILY_REPORT()
        {
            InitializeComponent();
            this.Load += LOGISTICS_DAILY_REPORT_Load;
        }

        private void LOGISTICS_DAILY_REPORT_Load(object sender, EventArgs e)
        {
            InitData();
        }

        private void btnReloadData_Click(object sender, EventArgs e)
        {
            InitData();
        }

        private void btnImportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
                popup.stock_code = "";
                popup.ImpportType = Consts.IMPORT_TYPE_LOGISTICS_DAILY;
                popup.ShowDialog();
                InitData();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOGISTICS_DAILY_REPORT.GETALL",
                                 new string[] { },
                                 new string[] { });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    gvList.Columns["ID"].Visible = false;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "INVOICE")
            {
                e.Appearance.BackColor = Color.FromArgb(174, 214, 241);
            }
            else  if (e.Column.FieldName == "ETA_WISOL")
            {
                e.Appearance.BackColor = Color.FromArgb(251, 238, 230);
            }
        }
    }
}
