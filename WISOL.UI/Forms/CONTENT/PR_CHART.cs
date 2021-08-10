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
            lblPR_Code.Text = "Mã yêu cầu mua hàng :" + MainID.Split('^')[0];
            LoadItemsCheck();
            LoadTemplate();
        }

        private void LoadItemsCheck()
        {
            try
            {
                string prCode = MainID.Split('^')[0];
                string mrpCode = MainID.Split('^')[1];

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
                string prCode = MainID.Split('^')[0];
                string mrpCode = MainID.Split('^')[1];
                string createDate = MainID.Split('^')[2];
                string totalValue = MainID.Split('^')[3];
                string totalValueUS = MainID.Split('^')[4];

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
                string createDate = MainID.Split('^')[2];

                base.m_ResultDB =
                    base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_DATA_REPORT_CHART",
                                    new string[] { "A_DEPARTMENT", "A_DATE", "A_LIST_SPARE_PART" },
                                    new string[] { Consts.DEPARTMENT, createDate, lstCode });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection tableCollection = base.m_ResultDB.ReturnDataSet.Tables;
                    IWorkbook workbook = spreadsheetPR.Document;
                    workbook.BeginUpdate();

                    Worksheet chartsheet = workbook.Worksheets["Char"];
                    Chart chart = chartsheet.Charts.Add(ChartType.ColumnClustered);
                    chart.TopLeftCell = chartsheet.Cells["B3"];
                    chart.BottomRightCell = chartsheet.Cells["R28"];

                    DataTable headerData = new DataTable();
                    headerData.Columns.Add("ITEMS");
                    headerData.Columns.Add("AGV1");
                    headerData.Columns.Add("AGV2");

                    foreach (DataColumn column in tableCollection[0].Columns)
                    {
                        headerData.Columns.Add(column.Caption);
                    }

                    DataRow rowHeader = headerData.NewRow();
                    rowHeader["ITEMS"] = "";
                    rowHeader["AGV1"] = (DateTime.Parse(createDate).Year - 1) + "년 평균";
                    rowHeader["AGV2"] = (DateTime.Parse(createDate).Year) + "년 평균";
                    foreach (DataColumn column in tableCollection[0].Columns)
                    {
                        rowHeader[column.Caption] = int.Parse(column.Caption.Substring(4,2)) + "월";
                    }
                    headerData.Rows.Add(rowHeader);
                    chartsheet.DataBindings.BindToDataSource(headerData, 28, 1);

                    if (tableCollection[0].Rows.Count > 0)
                    {
                        // Luong mua hang
                        chartsheet.DataBindings.BindToDataSource(tableCollection[0], 29, 4);
                    }
                    else
                    {
                        DataRow row = tableCollection[0].NewRow();
                        for (int i = 0; i < DateTime.Parse(createDate).Month; i++)
                        {
                            row[i] = 0;
                        }
                        tableCollection[0].Rows.Add(row);
                        chartsheet.DataBindings.BindToDataSource(tableCollection[0], 29, 4);
                    }
                   
                    // Luong su dung
                    int tb1Count = tableCollection[0].Rows.Count;
                  
                    int positionStart = (tb1Count > 0 ? tb1Count : 1) + 29;

                    if(tableCollection[1].Rows.Count > 0)
                    {
                        chartsheet.DataBindings.BindToDataSource(tableCollection[1], positionStart, 4);
                    }
                    else
                    {
                        DataRow row = tableCollection[1].NewRow();
                        for (int i = 0; i < DateTime.Parse(createDate).Month; i++)
                        {
                            row[i] = 0;
                        }
                        tableCollection[1].Rows.Add(row);
                        chartsheet.DataBindings.BindToDataSource(tableCollection[1], positionStart, 4);
                    }

                    if(tableCollection[2].Rows.Count > 0)
                    {
                        // avg luong mua hang
                        chartsheet.DataBindings.BindToDataSource(tableCollection[2], 29, 1);
                    }
                    else
                    {
                        DataRow row = tableCollection[2].NewRow();
                        for (int i = 0; i < 3; i++)
                        {
                            row[i] = 0;
                        }
                        tableCollection[2].Rows.Add(row);
                        chartsheet.DataBindings.BindToDataSource(tableCollection[2], 29,1);
                    }

                    int tb2Count = tableCollection[2].Rows.Count;
                    int positionStartAgv = (tb2Count > 0 ? tb2Count : 1) + 29;

                    if(tableCollection[3].Rows.Count > 0)
                    {
                        // avg luong su dung
                        chartsheet.DataBindings.BindToDataSource(tableCollection[3], positionStartAgv, 1);
                    }
                    else
                    {
                        DataRow row = tableCollection[3].NewRow();
                        for (int i = 0; i < 3; i++)
                        {
                            row[i] = 0;
                        }
                        tableCollection[3].Rows.Add(row);
                        chartsheet.DataBindings.BindToDataSource(tableCollection[3], positionStartAgv, 1);
                    }
                   
                    int totalRow = (tb2Count > 0 ? tb2Count : 1) + (tableCollection[3].Rows.Count > 0 ? tableCollection[3].Rows.Count : 1);
                    int columnIndex = tableCollection[0].Columns.Count + 3;

                    string columnEnd = chartsheet.Columns[columnIndex].Heading;
                    string range = "B29:" + columnEnd + "" + (29 + totalRow + 1);

                    chart.SelectData(chartsheet[range], ChartDataDirection.Row);
                    chart.Series[totalRow].ChangeType(ChartType.Line);
                    chart.Series[totalRow].AxisGroup = AxisGroup.Secondary;

                    CellRange range2 = chartsheet.Range[range];
                    range2.SetInsideBorders(Color.Black, BorderLineStyle.Thin);
                    range2.Borders.SetOutsideBorders(Color.Black, BorderLineStyle.Medium);

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

                saveFileDialog1.Filter = "exel files (*.xlsx)|*.xlsx";
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
