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
    public partial class ORDER_JOURNEY : PageType
    {
        public ORDER_JOURNEY()
        {
            InitializeComponent();
            this.Load += ORDER_JOURNEY_Load;
        }

        private void ORDER_JOURNEY_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "ORDER_JOURNEY");
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_ORDER_JOURNEY.GET",
                                new string[] { "A_PO_NO", "A_INVOICE_NO" },
                                new string[] { txtPoNo.Text.NullString(), txtInvoiceNo.Text.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    gvList.Columns["row_number"].Visible = false;
                    gvList.Columns["SPAREPART_CODE"].Visible = false;
                    gvList.Columns["PO_ID"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;
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

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "ETA_WISOL")
            {
                e.Appearance.BackColor = Color.FromArgb(251, 238, 230);
            }
            else if (e.Column.FieldName == "PO_NO")
            {
                e.Appearance.BackColor = Color.FromArgb(169, 223, 191);
            }
            else if (e.Column.FieldName == "INVOICE_NO")
            {
                e.Appearance.BackColor = Color.FromArgb(174, 214, 241);
            }
            if (e.Column.FieldName == "DEPT_DETAIL")
            {
                e.Appearance.BackColor = Color.FromArgb(249, 231, 159);
            }
        }
    }
}
