﻿using DevExpress.Export;
using DevExpress.XtraGrid.Columns;
using DevExpress.XtraPrinting;
using System;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
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
        public string Kho { get; set; }

        private void EXPORT_EXCEL_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "EXPORT_EXCEL", this);

            if (Consts.INVENTORY_REPORT.Equals(ReportType))
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, Kho });
            }
            else if (Consts.INVENTORY_IN_OUT_REPORT.Equals(ReportType))
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART_IN_OUT", new string[] { "A_DEPARTMENT", "A_TIME_FROM", "A_TIME_TO" }, new string[] { Consts.DEPARTMENT, TimeFrom, TimeTo });
            }
            else if (Consts.INVENTORY_IN_OUT_REPORT_BY_DAY.Equals(ReportType))
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_DAY_INVENTORY", new string[] { "A_DEPARTMENT", "A_TIME_FROM", "A_TIME_TO" }, new string[] { Consts.DEPARTMENT, TimeFrom, TimeTo });
            }
            else if (ReportType == Consts.ZERO) // Kiem ke
            {
                groupControl1.Text = ReportTitle;
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART_LOCATION", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, Kho });
                gvList.Columns["SPARE_PART_CODE"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                gvList.Columns["NAME_VI"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                gvList.OptionsView.AllowCellMerge = true;
                gvList.OptionsView.ColumnAutoWidth = true;
            }
        }

        private void GetData(string storeProcedureName, string[] param, string[] values)
        {
            try
            {
                splashScreenManager1.ShowWaitForm();
                base.mResultDB = base.mDBaccess.ExcuteProc(storeProcedureName, param, values);
                if (mResultDB.ReturnInt == 0)
                {
                    if (mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        DataTable data = mResultDB.ReturnDataSet.Tables[0];

                        base.mBindData.BindGridView(gcList, data);

                        if (ReportType == Consts.INVENTORY_REPORT || ReportType == Consts.INVENTORY_IN_OUT_REPORT)
                        {
                            gvList.Columns["STT"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                            gvList.Columns["STT"].DisplayFormat.FormatString = "n0";

                            if(ReportType == Consts.INVENTORY_IN_OUT_REPORT)
                            {
                                gvList.Columns["PRICE_VN"].Visible = false;
                                gvList.Columns["PRICE_US"].Visible = false;
                            }

                            if (ReportType == Consts.INVENTORY_IN_OUT_REPORT)
                            {
                                foreach (GridColumn item in gvList.Columns)
                                {
                                    if(!new string[] { "STT", "CODE", "NAME_VI", "DESCRIPTION", "PRICE_VN", "PRICE_US", "VENDER_NAME","UNIT", "SPARE_PART_TYPE", "STOCK_CODE", "MIN_STOCK" }.Contains(item.Caption))
                                    {

                                        string[] arr = item.Caption.Split('_');
                                        if(arr.Length > 2)
                                        {
                                            item.Caption = arr[0] + "_" + arr[1];
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
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
                advOptions.ShowTotalSummaries = DevExpress.Utils.DefaultBoolean.False;
                advOptions.SheetName = ReportType == Consts.ZERO ? "EWIP_SPAREPART_LOCATION" : "LIST";

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

        private void gvList_CellMerge(object sender, DevExpress.XtraGrid.Views.Grid.CellMergeEventArgs e)
        {
            try
            {
                if (ReportType == Consts.ZERO) // Kiem ke
                {
                    if (e.Column.FieldName == "SPARE_PART_CODE" || e.Column.FieldName == "NAME_VI")
                    {
                        string text1 = gvList.GetRowCellDisplayText(e.RowHandle1, "SPARE_PART_CODE");
                        string text2 = gvList.GetRowCellDisplayText(e.RowHandle2, "SPARE_PART_CODE");
                        e.Merge = (text1 == text2);
                        e.Handled = true;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
