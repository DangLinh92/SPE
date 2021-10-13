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
    public partial class SAP_PO_PR_INFO : PageType
    {
        private string PO_ID { get; set; }
        public SAP_PO_PR_INFO()
        {
            InitializeComponent();
            this.Load += SAP_PO_PR_INFO_Load;
        }

        private void SAP_PO_PR_INFO_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "SAP_PO_PR_INFO");
            PO_ID = (string)MainID;
            txtPO_ID_SYS.EditValue = PO_ID;

            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SAP_PO_PR.GET",
                   new string[] { "A_DEPARTMENT", "A_PO_ID_SYS" },
                   new string[] { Consts.DEPARTMENT, PO_ID });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
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
            if(e.Column.FieldName == "SAP_PO_ID")
            {
                e.Appearance.BackColor = Color.FromArgb(169, 204, 227);
            }
        }
    }
}
