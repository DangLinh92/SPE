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
    public partial class INVOICES : PageType
    {
        public INVOICES()
        {
            InitializeComponent();
            this.Load += INVOICES_Load;
        }

        private void INVOICES_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "INVOICES");
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVOICE.GET_ALL",
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

        private void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
                popup.stock_code = "";
                popup.ImpportType = Consts.IMPORT_TYPE_INVOICE;
                popup.ShowDialog();
                InitData();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnReload_Click(object sender, EventArgs e)
        {
            InitData();
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "COMMERCIAL_INVOICE_NO")
            {
                e.Appearance.BackColor = Color.FromArgb(251, 238, 230);
            }
            else if (e.Column.FieldName == "PO_NO")
            {
                e.Appearance.BackColor = Color.FromArgb(169, 223, 191);
            }
            else if (e.Column.FieldName == "MATERIAL_ID")
            {
                e.Appearance.BackColor = Color.FromArgb(174, 214, 241);
            }
        }
    }
}
