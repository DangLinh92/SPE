using DevExpress.Export;
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
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class INVENTORY_VALUES : PageType
    {
        public string StockCode { get; set; }
        public INVENTORY_VALUES()
        {
            InitializeComponent();
            this.Load += INVENTORY_VALUES_Load;
        }

        private void INVENTORY_VALUES_Load(object sender, EventArgs e)
        {
            try
            {
                splashScreenManager1.ShowWaitForm();
                StockCode = MainID as string;
                dateMonth.EditValue = DateTime.Now;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY.GET_VALUE_MONEY", new string[] { "A_DATE_GET", "A_DEPARTMENT", "A_STOCK" }, new string[] { dateMonth.EditValue.NullString(), Consts.DEPARTMENT, StockCode });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    FormatGrid();
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
            finally
            {
                splashScreenManager1.CloseWaitForm();
            }
        }

        private void FormatGrid()
        {
            gvList.Columns["IN_VALUES_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["IN_VALUES_VN"].DisplayFormat.FormatString = "n3";

            gvList.Columns["IN_VALUES_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["IN_VALUES_US"].DisplayFormat.FormatString = "n3";

            gvList.Columns["OUT_VALUES_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["OUT_VALUES_VN"].DisplayFormat.FormatString = "n3";

            gvList.Columns["OUT_VALUES_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["OUT_VALUES_US"].DisplayFormat.FormatString = "n3";

            gvList.Columns["INVENTORY_VALUES_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["INVENTORY_VALUES_VN"].DisplayFormat.FormatString = "n3";

            gvList.Columns["INVENTORY_VALUES_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["INVENTORY_VALUES_US"].DisplayFormat.FormatString = "n3";
            gvList.OptionsView.ColumnAutoWidth = true;
        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                SaveFileDialog fileDialog = new SaveFileDialog();
                fileDialog.Filter = "Excel Files (.xls*)|*.xls*|All Files (*.*)|*.*";
                fileDialog.FileName = "재고의 현금 가치(Gia tri ton kho)" + "-" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx";
                if (fileDialog.ShowDialog() == DialogResult.OK)
                {
                    string path = fileDialog.FileName;

                    //Customize export options
                    DevExpress.Export.ExportSettings.DefaultExportType = ExportType.DataAware;
                    gvList.OptionsPrint.UsePrintStyles = false;
                    gvList.OptionsPrint.PrintHeader = true;
                    gvList.AppearancePrint.HeaderPanel.BackColor = Color.Orange;

                    XlsxExportOptionsEx advOptions = new XlsxExportOptionsEx();
                    advOptions.ShowTotalSummaries = DevExpress.Utils.DefaultBoolean.False;

                    gvList.ExportToXlsx(path, advOptions);
                    // Open the created XLSX file with the default application.
                    Process.Start(path);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                splashScreenManager1.ShowWaitForm();
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY.GET_VALUE_MONEY", new string[] { "A_DATE_GET", "A_DEPARTMENT", "A_STOCK" }, new string[] { dateMonth.EditValue.NullString(),Consts.DEPARTMENT, StockCode });
                
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    FormatGrid();
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
            finally
            {
                splashScreenManager1.CloseWaitForm();
            }
        }
    }
}
