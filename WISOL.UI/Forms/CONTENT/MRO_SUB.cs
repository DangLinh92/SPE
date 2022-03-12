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
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;
using DevExpress.XtraSpreadsheet;
using DevExpress.Spreadsheet;
using System.Diagnostics;
using System.Globalization;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class MRO_SUB : PageType
    {
        public MRO_SUB()
        {
            InitializeComponent();
            this.Load += MRO_SUB_Load;
        }

        private void MRO_SUB_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "MRO_SUB");
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    gcList.DataSource = data;
                    gvList.Columns["Id"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;

                    FormatData();
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

        private void FormatData()
        {
            gvList.Columns["PLAN_MRO"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["PLAN_MRO"].DisplayFormat.FormatString = "c3";
            gvList.Columns["ACTUAL_PLAN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["ACTUAL_PLAN"].DisplayFormat.FormatString = "c3";

            gvList.Columns["OLD_COMPLETE"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["OLD_COMPLETE"].DisplayFormat.FormatString = "c3";

            gvList.Columns["ADD_ORDER"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["ADD_ORDER"].DisplayFormat.FormatString = "c3";

            gvList.Columns["TOTAL_ORDER"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["TOTAL_ORDER"].DisplayFormat.FormatString = "c3";

            gvList.Columns["REMAIN_PLAN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["REMAIN_PLAN"].DisplayFormat.FormatString = "c3";
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                if (e.Column.FieldName != "DETAIL")
                {
                    txtId.EditValue = gvList.GetRowCellValue(e.RowHandle, "Id").NullString();
                    dateMonthYear.EditValue = gvList.GetRowCellValue(e.RowHandle, "MONTH_YEAR").NullString();
                    txtPlan.EditValue = gvList.GetRowCellValue(e.RowHandle, "PLAN_MRO").NullString();
                    txtActualPlan.EditValue = gvList.GetRowCellValue(e.RowHandle, "ACTUAL_PLAN").NullString();
                    txtOldComplete.EditValue = gvList.GetRowCellValue(e.RowHandle, "OLD_COMPLETE").NullString();
                    txtAddOrder.EditValue = gvList.GetRowCellValue(e.RowHandle, "ADD_ORDER").NullString();
                    txtTotalOrder.EditValue = gvList.GetRowCellValue(e.RowHandle, "TOTAL_ORDER").NullString();
                    txtPlanOder.EditValue = gvList.GetRowCellValue(e.RowHandle, "REMAIN_PLAN").NullString();
                    cboUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
                }
                else
                {
                    POP.SHOW_ORDER popup = new POP.SHOW_ORDER();
                    popup.DateSearch = gvList.GetRowCellValue(e.RowHandle, "MONTH_YEAR").NullString();
                    popup.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearData();
        }

        private void ClearData()
        {
            txtId.EditValue = "";
            dateMonthYear.EditValue = "";
            txtPlan.EditValue = "";
            txtActualPlan.EditValue = "";
            txtOldComplete.EditValue = "";
            txtAddOrder.EditValue = "";
            txtTotalOrder.EditValue = "";
            txtPlanOder.EditValue = "";
            cboUnit.EditValue = "VND";
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtId.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@INIT", new string[] { "A_ID" }, new string[] { txtId.EditValue.NullString() });
                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@PUT",
                    new string[] { "A_ID", "A_DEPT_CODE", "A_PLAN_MRO", "A_ACTUAL", "A_OLD", "A_ADD", "A_TOLTAL", "A_REMAIN", "A_TIME", "A_UNIT" },
                    new string[] {
                        txtId.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        txtPlan.EditValue.NullString(),
                        txtActualPlan.EditValue.NullString(),
                        txtOldComplete.EditValue.NullString(),
                        txtAddOrder.EditValue.NullString(),
                        txtTotalOrder.EditValue.NullString(),
                        txtPlanOder.EditValue.NullString(),
                        dateMonthYear.EditValue.NullString(),
                        cboUnit.EditValue.NullString()
                    });
                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
                    ClearData();
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

        private void btnReloadData_Click(object sender, EventArgs e)
        {
            InitData();
        }

        private void btnExportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                if (dateMonthYear.EditValue.NullString() == "" || !DateTime.TryParse(dateMonthYear.EditValue.NullString(), out _))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                SpreadsheetControl spreadsheetMRO = new SpreadsheetControl();
                IWorkbook workbook = spreadsheetMRO.Document;
                workbook.BeginUpdate();
                workbook.LoadDocument("Form_MRO bugget.xlsx");

                Worksheet sheet1 = workbook.Worksheets[0];
                var firstDayOfMonth = new DateTime(DateTime.Parse(dateMonthYear.EditValue.NullString()).Year, DateTime.Parse(dateMonthYear.EditValue.NullString()).Month, 1);
                var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd");

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@INIT_DATA_EXCEL",
                      new string[] { "A_DEPARTMENT", "A_FROM_TIME", "A_TO_TIME" },
                      new string[] { Consts.DEPARTMENT, firstDayOfMonth.ToString("yyyy-MM-dd"), lastDayOfMonth });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];

                    sheet1.Cells["C1"].Value = DateTime.Parse(dateMonthYear.EditValue.NullString()).Month;

                    int i = 0;
                    foreach (DataRow row in data.Rows)
                    {
                        if (i == 0)
                        {
                            if (double.TryParse(row["PLANT"].NullString(), out double plantV))
                            {
                                sheet1.Cells["C6"].Value = plantV.ToString("N", CultureInfo.InvariantCulture); //PLAN 계획
                            }
                            else
                            {
                                sheet1.Cells["C6"].Value = row["PLANT"].NullString();
                            }

                            if (double.TryParse(row["ACTUAL_PLAN"].NullString(), out double actualPlantV))
                            {
                                sheet1.Cells["D6"].Value = actualPlantV.ToString("N", CultureInfo.InvariantCulture);
                            }
                            else
                            {
                                sheet1.Cells["D6"].Value = row["ACTUAL_PLAN"].NullString(); // ACTUAL PLANT
                            }

                            sheet1.Cells["C6"].NumberFormat = "#,#";
                            sheet1.Cells["D6"].NumberFormat = "#,#";
                        }

                        sheet1.Cells["B" + (i + 6)].Value = row["TIME_HEADER"].NullString(); // TIME

                        if (i > 0)
                        {
                            if (double.TryParse(row["ADD_ORDER"].NullString(), out double addOrderV))
                            {
                                sheet1.Cells["F" + (i + 6)].Value = addOrderV.ToString("N", CultureInfo.InvariantCulture); ;
                            }
                            else
                            {
                                sheet1.Cells["F" + (i + 6)].Value = row["ADD_ORDER"].NullString();
                            }

                            sheet1.Cells["F" + (i + 6)].NumberFormat = "#,#";
                        }
                        i++;
                    }
                    CellRange sourceRange = sheet1["C" + (i + 6) + ":C25"];
                    CellRange sourceRange1 = sheet1["D" + (i + 6) + ":D25"];
                    CellRange sourceRange2 = sheet1["Q" + (i + 6) + ":Q25"];
                    CellRange sourceRange3 = sheet1["E" + (i + 6) + ":E25"];

                    sourceRange.Value = 0;
                    sourceRange1.Value = 0;
                    sourceRange2.Value = "";
                    sourceRange3.Value = 0;

                    workbook.EndUpdate();

                    SaveFileDialog saveFileDialog1 = new SaveFileDialog();
                    saveFileDialog1.Filter = "excel files (*.xlsx)|*.xlsx";
                    saveFileDialog1.FileName = "Form_MRO bugget" + "-" + DateTime.Now.ToString("yyyy-MM-dd") + ".xlsx";
                    saveFileDialog1.FilterIndex = 2;
                    saveFileDialog1.RestoreDirectory = true;

                    if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                    {
                        string fileName = saveFileDialog1.FileName;

                        // Save the modified document to a file.
                        workbook.SaveDocument(fileName, DocumentFormat.Xlsx);

                        Process.Start(fileName);
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    }

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
