using DevExpress.Export;
using DevExpress.Utils.Drawing;
using DevExpress.XtraPrinting;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class EXPORT_EXCEL : FormType
    {
        public EXPORT_EXCEL()
        {
            InitializeComponent();
        }

        public string ReportType { get; set; } // 1: inventory , 2 : inventory with in out stock
        public string TimeFrom { get; set; }
        public string TimeTo { get; set; }
        public string ConditionOther { get; set; }
        public string ReportTitle { get; set; }

        private void EXPORT_EXCEL_Load(object sender, EventArgs e)
        {
            if (Consts.INVENTORY_REPORT.Equals(ReportType))
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
            }
            else if (Consts.INVENTORY_IN_OUT_REPORT.Equals(ReportType))
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART_IN_OUT", new string[] { "A_DEPARTMENT", "A_TIME_FROM", "A_TIME_TO" }, new string[] { Consts.DEPARTMENT,TimeFrom,TimeTo });
            }
        }

        private void GetData(string storeProcedureName, string[] param, string[] values)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc(storeProcedureName, param, values);
                if (mResultDB.ReturnInt == 0)
                {
                    if (mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        base.mBindData.BindGridView(gcList, mResultDB.ReturnDataSet.Tables[0]);

                        gvList.Columns["STT"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                        gvList.Columns["STT"].DisplayFormat.FormatString = "n0";
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnReport_Click(object sender, EventArgs e)
        {
            SaveFileDialog fileDialog = new SaveFileDialog();
            fileDialog.Filter = "Excel Files (.xls*)|*.xls*|All Files (*.*)|*.*";
            fileDialog.FileName = ReportTitle + "-" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx";
            if (fileDialog.ShowDialog() == DialogResult.OK)
            {
                string path = fileDialog.FileName;

                //Customize export options
                DevExpress.Export.ExportSettings.DefaultExportType = ExportType.DataAware;
                gvList.OptionsPrint.UsePrintStyles = false;
                gvList.OptionsPrint.PrintHeader = true;
                gvList.AppearancePrint.HeaderPanel.BackColor = Color.Orange;

                XlsxExportOptionsEx advOptions = new XlsxExportOptionsEx();
                advOptions.ShowTotalSummaries = DevExpress.Utils.DefaultBoolean.True;
                advOptions.SheetName = "LIST";

                gvList.ExportToXlsx(path, advOptions);
                // Open the created XLSX file with the default application.
                Process.Start(path);

                this.Close();
            }
        }

        private void gvList_CustomDrawColumnHeader(object sender, DevExpress.XtraGrid.Views.Grid.ColumnHeaderCustomDrawEventArgs e)
        {
            if (e.Column == null) return;
            if (e.Column.AppearanceHeader.BackColor == Color.Empty)
            {
                e.Column.AppearanceHeader.BackColor = Color.Orange;
                e.Info.AllowColoring = true;
            }
        }
    }
}
