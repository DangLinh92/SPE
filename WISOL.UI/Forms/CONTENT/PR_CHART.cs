using DevExpress.Spreadsheet;
using DevExpress.Spreadsheet.Charts;
using DevExpress.XtraCharts;
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
    public partial class PR_CHART : PageType
    {
        public PR_CHART()
        {
            InitializeComponent();
            this.Load += PR_CHART_Load;
        }

        private void PR_CHART_Load(object sender, EventArgs e)
        {
            lblPR_Code.Text = "Mã yêu cầu mua hàng :" + MainID.NullString().Split('^')[0];
            LoadItemsCheck();
            LoadTemplate();
        }

        private void LoadItemsCheck()
        {
            try
            {
                string prCode = MainID.NullString().Split('^')[0];
                string mrpCode = MainID.NullString().Split('^')[1];

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_PR_DETAIL_BY_CODE",
               new string[] { "A_DEPARTMENT", "A_PR_CODE", "A_MRP_CODE" },
               new string[] { Consts.DEPARTMENT, prCode, mrpCode });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];
                    foreach (DataRow row in data.Rows)
                    {
                        cheCbSparepartCollection.Properties.Items.Add(row["CODE"].NullString(), row["NAME"].NullString());
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void LoadTemplate()
        {
            IWorkbook workbook = spreadsheetPR.Document;
            workbook.BeginUpdate();

            workbook.LoadDocument("Worksheet_PR.xlsx");
            Worksheet sheet1 = workbook.Worksheets[0];
            GetDataForPRRequest(sheet1);
            workbook.EndUpdate();
        }

        private void GetDataForPRRequest(Worksheet sheet)
        {
            try
            {
                string prCode = MainID.NullString().Split('^')[0];
                string mrpCode = MainID.NullString().Split('^')[1];
                string createDate = MainID.NullString().Split('^')[2];
                string totalValue = MainID.NullString().Split('^')[3];
                string totalValueUS = MainID.NullString().Split('^')[4];

                if (string.IsNullOrEmpty(createDate))
                {
                    createDate = DateTime.Now.ToString();
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_DATA_REPORT_NO_CHART",
                  new string[] { "A_DEPARTMENT", "A_PR_CODE", "A_MRP_CODE", "A_DATE" },
                  new string[] { Consts.DEPARTMENT, prCode, mrpCode, DateTime.Parse(createDate).ToString("yyyy-MM-dd") });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];

                    for (int i = 0; i < data.Rows.Count; i++)
                    {
                        if (i > 0)
                        {
                            sheet.Rows[i + 12].CopyFrom(sheet.Rows[12], PasteSpecial.Formats);
                        }
                        sheet.Pictures.AddPicture(Classes.Common.GetImage(data.Rows[i]["IMAGE"].NullString()), sheet["F" + (13 + i)]);
                        data.Rows[i]["IMAGE"] = "";
                    }

                    sheet.DataBindings.BindToDataSource(data, 12, 0);
                    sheet.Cells["A3"].Value = "BỘ PHẬN: " + Consts.DEPARTMENT;
                    sheet.Cells["A4"].Value = "Ngày " + DateTime.Parse(createDate).Day + " Tháng " + DateTime.Parse(createDate).Month + " Năm " + DateTime.Parse(createDate).Year;
                    sheet.Cells["A8"].Value = "3. 구입 금액 (Giá trị đơn hàng) :" + (double.Parse(totalValue)).ToString("c") + " VND /" + (double.Parse(totalValueUS)).ToString("c") + "USD";
                    sheet.Cells["A9"].Value = "4.구매 요청(PR.NO) :" + prCode;
                    sheet.Cells["H11"].Value = "Tồn kho tháng " + (DateTime.Parse(createDate).AddMonths(-1).Month);
                    sheet.Cells["J11"].Value = "SL dùng tháng " + (DateTime.Parse(createDate).Month);
                    sheet.Cells["K11"].Value = "SL dùng tháng " + (DateTime.Parse(createDate).AddMonths(1).Month);
                    sheet.Cells["L11"].Value = "SL dùng tháng " + (DateTime.Parse(createDate).AddMonths(2).Month);

                    sheet.Cells["H12"].Value = (DateTime.Parse(createDate).AddMonths(-1).Month) + "월재고 ";
                    sheet.Cells["J12"].Value = (DateTime.Parse(createDate).Month) + "월 필요";
                    sheet.Cells["K12"].Value = (DateTime.Parse(createDate).AddMonths(1).Month) + "월 필요";
                    sheet.Cells["L12"].Value = (DateTime.Parse(createDate).AddMonths(2).Month) + "월 필요";
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString, MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDrawChart_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(cheCbSparepartCollection.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                var lstCode = cheCbSparepartCollection.EditValue.NullString().Replace(",", "$");
                string createDate = MainID.NullString().Split('^')[2];

                base.m_ResultDB =
                    base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_DATA_REPORT_CHART",
                                    new string[] { "A_DEPARTMENT", "A_DATE", "A_LIST_SPARE_PART" },
                                    new string[] { Consts.DEPARTMENT, createDate, lstCode });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable DataDraw = new DataTable();
                    DataTableCollection tableCollection = base.m_ResultDB.ReturnDataSet.Tables;

                    DataColumn col0 = new DataColumn("");
                    col0.DataType = System.Type.GetType("System.String");
                    DataDraw.Columns.Add(col0);

                    foreach (DataColumn column in tableCollection[3].Columns)
                    {
                        if (column.Caption != "CODE")
                        {
                            string columnName = column.Caption + "년 평균";
                            DataColumn col = new DataColumn(columnName);
                            col.DataType = System.Type.GetType("System.Decimal");
                            DataDraw.Columns.Add(col);
                        }
                    }

                    foreach (DataColumn column in tableCollection[0].Columns)
                    {
                        if (column.Caption != "SPARE_PART_CODE")
                        {
                            string columnName = int.Parse(column.Caption.Substring(4, 2)) + "월";
                            DataColumn col = new DataColumn(columnName);
                            col.DataType = System.Type.GetType("System.Decimal");
                            DataDraw.Columns.Add(col);
                        }
                    }

                    DataTable tableHeader = new DataTable();
                    foreach (DataColumn col in DataDraw.Columns)
                    {
                        tableHeader.Columns.Add(col.Caption);
                    }

                    DataRow rowHeader = tableHeader.NewRow();
                    int i = 0;
                    foreach (DataColumn col in DataDraw.Columns)
                    {
                        if (i == 0)

                        {
                            rowHeader[0] = "";
                        }
                        else
                        {
                            rowHeader[col.Caption] = col.Caption;
                        }
                        i++;
                    }
                    tableHeader.Rows.Add(rowHeader);

                    foreach (var code in lstCode.Split('$'))
                    {
                        DataRow row = DataDraw.NewRow();
                        row[0] = code + "-PO(PACK)";
                        DataDraw.Rows.Add(row);

                        DataRow row1 = DataDraw.NewRow();
                        row1[0] = code + "-사용수(PACK)";
                        DataDraw.Rows.Add(row1);
                    }
                    DataRow row2 = DataDraw.NewRow();
                    row2[0] = "생산계획(K point)";
                    DataDraw.Rows.Add(row2);

                    // AVG mua hang
                    foreach (DataRow item in tableCollection[2].Rows)
                    {
                        foreach (DataRow row in DataDraw.Rows)
                        {
                            if (row[0].NullString().StartsWith(item[0].NullString()) && row[0].NullString().Contains("-PO(PACK)"))
                            {
                                row[1] = float.Parse(item[1].IfNullIsZero());
                                row[2] = float.Parse(item[2].IfNullIsZero());
                                break;
                            }
                        }
                    }

                    // AVG su dung
                    foreach (DataRow item in tableCollection[3].Rows)
                    {
                        foreach (DataRow row in DataDraw.Rows)
                        {
                            if (row[0].NullString().StartsWith(item[0].NullString()) && row[0].NullString().Contains("-사용수(PACK)"))
                            {
                                row[1] = float.Parse(item[1].IfNullIsZero());
                                row[2] = float.Parse(item[2].IfNullIsZero());
                                break;
                            }
                        }
                    }

                    // mua hang theo thang
                    foreach (DataRow item in tableCollection[0].Rows)
                    {
                        foreach (DataRow row in DataDraw.Rows)
                        {
                            if (row[0].NullString().StartsWith(item[0].NullString()) && row[0].NullString().Contains("-PO(PACK)"))
                            {
                                foreach (DataColumn col in tableCollection[0].Columns)
                                {
                                    if (col.Caption != "SPARE_PART_CODE")
                                    {
                                        string colName = int.Parse(col.Caption.Substring(4, 2)) + "월";
                                        row[colName] = float.Parse(item[col.Caption].IfNullIsZero());
                                    }
                                }
                                break;
                            }
                        }
                    }

                    // su dung theo thang
                    foreach (DataRow item in tableCollection[1].Rows)
                    {
                        foreach (DataRow row in DataDraw.Rows)
                        {
                            if (row[0].NullString().StartsWith(item[0].NullString()) && row[0].NullString().Contains("-PO(PACK)"))
                            {
                                foreach (DataColumn col in tableCollection[1].Columns)
                                {
                                    if (col.Caption != "SPARE_PART_CODE")
                                    {
                                        string colName = int.Parse(col.Caption.Substring(4, 2)) + "월";
                                        row[colName] = float.Parse(item[col.Caption].IfNullIsZero());
                                    }
                                }
                                break;
                            }
                        }
                    }

                    foreach (DataRow row in DataDraw.Rows)
                    {
                        for (int k = 1; k < DataDraw.Columns.Count; k++)
                        {
                            row[k] = float.Parse(row[k].IfNullIsZero());
                        }
                    }

                    IWorkbook workbook = spreadsheetPR.Document;
                    workbook.BeginUpdate();

                    Worksheet chartsheet = workbook.Worksheets["Char"];
                    chartsheet.Clear(chartsheet["B29:R200"]);

                    Chart chart;
                    if (chartsheet.Charts.Count == 0)
                    {
                        chart = chartsheet.Charts.Add(ChartType.ColumnClustered);
                        chart.TopLeftCell = chartsheet.Cells["B3"];
                        chart.BottomRightCell = chartsheet.Cells["R28"];
                    }
                    else
                    {
                        chart = chartsheet.Charts[0];
                    }

                    chartsheet.DataBindings.Clear();
                    chart.Series.Clear();
                    chartsheet.DataBindings.BindToDataSource(tableHeader, 28, 1);
                    chartsheet.DataBindings.BindToDataSource(DataDraw, 29, 1);

                    for (int h = 30; h < 30 + DataDraw.Rows.Count; h++)
                    {
                        string headerColumnStart = chartsheet.Columns[4].Heading;
                        string headerColumnEnd = chartsheet.Columns[DataDraw.Columns.Count].Heading;
                        string rangeAgv = (headerColumnStart + h) + ":" + (headerColumnEnd + h);
                        chartsheet.Cells["D" + h].Formula = @"IFERROR(AVERAGE(" + rangeAgv + @"),"""")";
                    }

                    #region
                    //DataTable headerData = new DataTable();
                    //headerData.Columns.Add("ITEMS");
                    //headerData.Columns.Add("AGV1");
                    //headerData.Columns.Add("AGV2");

                    //foreach (DataColumn column in tableCollection[0].Columns)
                    //{
                    //    headerData.Columns.Add(column.Caption);
                    //}

                    //DataRow rowHeader = headerData.NewRow();
                    //rowHeader["ITEMS"] = "";
                    //rowHeader["AGV1"] = (DateTime.Parse(createDate).Year - 1) + "년 평균";
                    //rowHeader["AGV2"] = (DateTime.Parse(createDate).Year) + "년 평균";
                    //foreach (DataColumn column in tableCollection[0].Columns)
                    //{
                    //    rowHeader[column.Caption] = int.Parse(column.Caption.Substring(4,2)) + "월";
                    //}
                    //headerData.Rows.Add(rowHeader);
                    //chartsheet.DataBindings.BindToDataSource(headerData, 28, 1);

                    //if (tableCollection[0].Rows.Count > 0)
                    //{
                    //    // Luong mua hang
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[0], 29, 4);
                    //}
                    //else
                    //{
                    //    DataRow row = tableCollection[0].NewRow();
                    //    for (int i = 0; i < DateTime.Parse(createDate).Month; i++)
                    //    {
                    //        row[i] = 0;
                    //    }
                    //    tableCollection[0].Rows.Add(row);
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[0], 29, 4);
                    //}

                    //// Luong su dung
                    //int tb1Count = tableCollection[0].Rows.Count;

                    //int positionStart = (tb1Count > 0 ? tb1Count : 1) + 29;

                    //if(tableCollection[1].Rows.Count > 0)
                    //{
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[1], positionStart, 4);
                    //}
                    //else
                    //{
                    //    DataRow row = tableCollection[1].NewRow();
                    //    for (int i = 0; i < DateTime.Parse(createDate).Month; i++)
                    //    {
                    //        row[i] = 0;
                    //    }
                    //    tableCollection[1].Rows.Add(row);
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[1], positionStart, 4);
                    //}

                    //if(tableCollection[2].Rows.Count > 0)
                    //{
                    //    // avg luong mua hang
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[2], 29, 1);
                    //}
                    //else
                    //{
                    //    DataRow row = tableCollection[2].NewRow();
                    //    for (int i = 0; i < 3; i++)
                    //    {
                    //        row[i] = 0;
                    //    }
                    //    tableCollection[2].Rows.Add(row);
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[2], 29,1);
                    //}

                    //int tb2Count = tableCollection[2].Rows.Count;
                    //int positionStartAgv = (tb2Count > 0 ? tb2Count : 1) + 29;

                    //if(tableCollection[3].Rows.Count > 0)
                    //{
                    //    // avg luong su dung
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[3], positionStartAgv, 1);
                    //}
                    //else
                    //{
                    //    DataRow row = tableCollection[3].NewRow();
                    //    for (int i = 0; i < 3; i++)
                    //    {
                    //        row[i] = 0;
                    //    }
                    //    tableCollection[3].Rows.Add(row);
                    //    chartsheet.DataBindings.BindToDataSource(tableCollection[3], positionStartAgv, 1);
                    //}
                    #endregion

                    int totalRow = DataDraw.Rows.Count;
                    int columnIndex = DataDraw.Columns.Count;

                    string columnEnd = chartsheet.Columns[columnIndex].Heading;
                    string range = "B29:" + columnEnd + "" + (29 + totalRow);

                    chart.SelectData(chartsheet[range], ChartDataDirection.Row);

                    chart.Series[totalRow - 1].ChangeType(ChartType.Line);
                    chart.Series[totalRow - 1].AxisGroup = AxisGroup.Secondary;

                    CellRange range2 = chartsheet.Range[range];
                    range2.SetInsideBorders(Color.Black, BorderLineStyle.Thin);
                    range2.Borders.SetOutsideBorders(Color.Black, BorderLineStyle.Medium);

                    Formatting rangeFormatting = chartsheet[range].BeginUpdateFormatting();
                    rangeFormatting.Alignment.Vertical = SpreadsheetVerticalAlignment.Center;
                    rangeFormatting.Alignment.Horizontal = SpreadsheetHorizontalAlignment.Center;
                    chartsheet[range].EndUpdateFormatting(rangeFormatting);

                    Formatting rangeFormatting1 = chartsheet["B29:B"+ (29 + totalRow)].BeginUpdateFormatting();
                    rangeFormatting1.Alignment.Vertical = SpreadsheetVerticalAlignment.Center;
                    rangeFormatting1.Alignment.Horizontal = SpreadsheetHorizontalAlignment.Left;
                    chartsheet[range].EndUpdateFormatting(rangeFormatting1);

                    workbook.EndUpdate();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnExportExecel_Click(object sender, EventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog1 = new SaveFileDialog();

                saveFileDialog1.Filter = "excel files (*.xlsx)|*.xlsx";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;

                if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    string fileName = saveFileDialog1.FileName;

                    // Save the modified document to a file.
                    IWorkbook workbook = spreadsheetPR.Document;
                    workbook.SaveDocument(fileName, DocumentFormat.Xlsx);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
