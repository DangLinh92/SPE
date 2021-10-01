using DevExpress.XtraCharts;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.REPORT
{
    public partial class IN_OUT_STOCK_REPORT : PageType
    {
        public IN_OUT_STOCK_REPORT()
        {
            InitializeComponent();
            this.Load += IN_OUT_STOCK_REPORT_Load;
        }

        private void IN_OUT_STOCK_REPORT_Load(object sender, EventArgs e)
        {
            try
            {
                cboQty_Money.SelectedIndex = 1;
                cboVNDKWR.SelectedIndex = 0;

                dateMonthCompare.EditValue = DateTime.Now;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.INIT_SPAREPART", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    m_BindData.BindGridLookEdit(stlDeptCode, datas[1], "CODE", "DEPARTMENT");
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
                stlDeptCode.EditValue = Consts.DEPARTMENT;

                Classes.Common.SetFormIdToButton(this, "IN_OUT_STOCK_REPORT");
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlDeptCode_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.INIT_SPAREPART", new string[] { "A_DEPARTMENT" }, new string[] { stlDeptCode.EditValue.NullString() });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    foreach (DataRow row in datas[0].Rows)
                    {
                        cheCboSparepart.Properties.Items.Add(row["CODE"].NullString(), row["NAME"].NullString());
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

        private void rdoChoose_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdoChoose.EditValue.NullString() == "1") // DAY
            {
                dateFrom.Enabled = true;
                dateTo.Enabled = true;
                spWeekFrom.Enabled = false;
                spWeekTo.Enabled = false;

                dateMonthFrom.Enabled = false;
                dateMonthTo.Enabled = false;

                QuaterFrom.Enabled = false;
                QuaterTo.Enabled = false;
            }
            else if (rdoChoose.EditValue.NullString() == "2")// WEEK
            {
                dateFrom.Enabled = false;
                dateTo.Enabled = false;
                spWeekFrom.Enabled = true;
                spWeekTo.Enabled = true;

                dateMonthFrom.Enabled = false;
                dateMonthTo.Enabled = false;

                QuaterFrom.Enabled = false;
                QuaterTo.Enabled = false;
            }
            else if (rdoChoose.EditValue.NullString() == "3") // month
            {
                dateFrom.Enabled = false;
                dateTo.Enabled = false;
                spWeekFrom.Enabled = false;
                spWeekTo.Enabled = false;

                dateMonthFrom.Enabled = true;
                dateMonthTo.Enabled = true;

                QuaterFrom.Enabled = false;
                QuaterTo.Enabled = false;
            }
            else if (rdoChoose.EditValue.NullString() == "4") // quarter
            {
                dateFrom.Enabled = false;
                dateTo.Enabled = false;
                spWeekFrom.Enabled = false;
                spWeekTo.Enabled = false;

                dateMonthFrom.Enabled = false;
                dateMonthTo.Enabled = false;

                QuaterFrom.Enabled = true;
                QuaterTo.Enabled = true;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="valueType">MONEY/QTY</param>
        public void DrawChart(string valueType, DataTableCollection datas)
        {
            try
            {
                chartMain.Series.Clear();
                chartMain.Titles.Clear();
                vnd_kwr = cboVNDKWR.EditValue.NullString();

                GetNamesSparepart();

                string unitType = valueType == "M" ? "K." + vnd_kwr : "PACK";

                if (valueType != "M")
                {
                    vnd_kwr = "PACK";
                }
                else
                {
                    vnd_kwr = "K." + vnd_kwr;
                }

                string unitLine = "";
                if (Consts.DEPARTMENT == Consts.SMT_DEPT)
                {
                    unitLine = "K.Point";
                }

                Series series_Prd = new Series("Product " + unitLine, ViewType.Line);
                Series series_Plant = new Series("Plant " + unitLine, ViewType.Line);
                if (datas.Count >= 2 && datas[1].Columns[0].ColumnName == "PRODUCT")
                {
                    series_Prd.DataSource = datas[1];
                    series_Prd.ArgumentDataMember = "TIME_VALUE";
                    series_Prd.ValueDataMembers.AddRange("PRODUCT");

                    // Enable series markers.
                    LineSeriesView viewPrd = (LineSeriesView)series_Prd.View;
                    viewPrd.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

                    series_Prd.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_Prd.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_Prd.Label.TextPattern = "{V:n0}";

                    chartMain.Series.Add(series_Prd);

                    if (datas.Count > 2 && datas[2].Columns[0].ColumnName == "PLANT")
                    {
                        series_Plant.DataSource = datas[2];
                        series_Plant.ArgumentDataMember = "TIME_VALUE";
                        series_Plant.ValueDataMembers.AddRange("PLANT");

                        // Enable series markers.
                        LineSeriesView viewplan = (LineSeriesView)series_Plant.View;
                        viewplan.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

                        series_Plant.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_Plant.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_Plant.Label.TextPattern = "{V:n0}";

                        chartMain.Series.Add(series_Plant);
                    }
                }

                List<string> spCodes = new List<string>();
                foreach (DataRow row in datas[0].Rows)
                {
                    if (!spCodes.Contains(row["SPARE_PART_CODE"].NullString()))
                    {
                        spCodes.Add(row["SPARE_PART_CODE"].NullString());
                    }
                }

                if (cheReceive.Checked)
                {
                    foreach (var code in spCodes)
                    {
                        var dt = datas[0].Select("SPARE_PART_CODE = '" + code + "'");
                        var tb = dt.CopyToDataTable();

                        Series series_in = new Series("Receive(" + DicNameSparepart[code] + ")", ViewType.Bar);
                        series_in.DataSource = tb;//datas[0];
                        series_in.ArgumentDataMember = "TIME_VALUE";
                        series_in.ValueDataMembers.AddRange("IN_VALUE");

                        series_in.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_in.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_in.Label.TextPattern = "{V:n0}";

                        chartMain.Series.Add(series_in);
                    }
                }

                if (cheDelivery.Checked)
                {
                    foreach (var code in spCodes)
                    {
                        var dt = datas[0].Select("SPARE_PART_CODE = '" + code + "'");
                        var tb = dt.CopyToDataTable();

                        Series series_out = new Series("Delivery(" + DicNameSparepart[code] + ")", ViewType.Bar);
                        series_out.DataSource = tb; //datas[0];
                        series_out.ArgumentDataMember = "TIME_VALUE";
                        series_out.ValueDataMembers.AddRange("OUT_VALUE");

                        series_out.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_out.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_out.Label.TextPattern = "{V:n0}";

                        chartMain.Series.Add(series_out);
                    }
                }

                if (cheStock.Checked)
                {
                    foreach (var code in spCodes)
                    {
                        var dt = datas[0].Select("SPARE_PART_CODE = '" + code + "'");
                        var tb = dt.CopyToDataTable();

                        Series series_iv = new Series("Stock(" + DicNameSparepart[code] + ")", ViewType.Bar);
                        series_iv.DataSource = tb;//datas[0];
                        series_iv.ArgumentDataMember = "TIME_VALUE";
                        series_iv.ValueDataMembers.AddRange("INVENTORY");

                        series_iv.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_iv.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_iv.Label.TextPattern = "{V:n0}";

                        chartMain.Series.Add(series_iv);
                    }
                }

                if (cheMinStock.Checked)
                {
                    foreach (var code in spCodes)
                    {
                        var dt = datas[0].Select("SPARE_PART_CODE = '" + code + "'");
                        var tb = dt.CopyToDataTable();

                        Series series_minSt = new Series("Min Stock " + unitType, ViewType.Bar);
                        series_minSt.DataSource = tb;//datas[0];
                        series_minSt.ArgumentDataMember = "TIME_VALUE";
                        series_minSt.ValueDataMembers.AddRange("MIN_STOCK");

                        series_minSt.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_minSt.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_minSt.Label.TextPattern = "{V:n0}";

                        chartMain.Series.Add(series_minSt);
                    }
                }

                // Create a chart title.
                ChartTitle chartTitle = new ChartTitle();
                chartTitle.Text = "TỔNG HỢP XUẤT NHẬP TỒN -재고 보고서" + (vnd_kwr != "" ? "(" + vnd_kwr + ")" : "");
                chartMain.Titles.Add(chartTitle);

                XYDiagram diagram = chartMain.Diagram as XYDiagram;
                diagram.AxisY.Label.TextPattern = "{V:n0}";
                diagram.AxisY.Title.Text = unitType;
                diagram.AxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
                diagram.AxisY.Title.TextColor = Color.FromArgb(36, 113, 163);

                diagram.SecondaryAxesY.Clear();
                SecondaryAxisY myAxisY = new SecondaryAxisY("Plan-Product");
                myAxisY.Label.TextPattern = "{V:n0}";
                myAxisY.Title.Text = "GOC plan and product " + (unitLine != "" ? "(" + unitLine + ")" : "");
                myAxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
                myAxisY.Title.TextColor = Color.FromArgb(36, 113, 163);

                diagram.SecondaryAxesY.Add(myAxisY);

                if (datas.Count >= 2)
                {
                    ((LineSeriesView)series_Prd.View).AxisY = myAxisY;

                    if (datas.Count > 2)
                    {
                        ((LineSeriesView)series_Plant.View).AxisY = myAxisY;
                    }
                }

                // ve bieu do quat
                chartControlPieSingle.Series.Clear();
                chartControlPieSingle.Titles.Clear();

                chartControlPieIntergrate.Series.Clear();
                chartControlPieIntergrate.Titles.Clear();

                chartControlSparepartPart.Series.Clear();
                chartControlSparepartPart.Titles.Clear();

                if (dateMonthCompare.EditValue.NullString() != "")
                {
                    Font font = new Font("Arial", 12.0F);
                    // 
                    chartControlPieSingle.Titles.Add(new ChartTitle() { Text = "월 Spare part 재고 금액", Font = font });
                    chartControlPieSingle.Titles.Add(new ChartTitle() { Text = "Giá trị hàng theo tháng ", Font = font });
                    Series seriesPieSingle = new Series("Value by month", ViewType.Pie);

                    // Bind the series to data.
                    seriesPieSingle.DataSource = datas[3];
                    seriesPieSingle.ArgumentDataMember = "SPARE_CODE";
                    seriesPieSingle.ValueDataMembers.AddRange(new string[] { "VALUE_SPAREPART" });

                    // Add the series to the chart.
                    chartControlPieSingle.Series.Add(seriesPieSingle);
                    seriesPieSingle.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    seriesPieSingle.Label.ResolveOverlappingMode = ResolveOverlappingMode.Default;
                    seriesPieSingle.Label.TextPattern = "{VP:p2} ({V:n0} " +"K."+ cboVNDKWR.EditValue.NullString() + ")";

                    // Format the series legend items.
                    seriesPieSingle.LegendTextPattern = "{A}";

                    // Adjust the position of series labels. 
                    ((PieSeriesLabel)seriesPieSingle.Label).Position = PieSeriesLabelPosition.Outside;

                    //
                    chartControlPieIntergrate.Titles.Add(new ChartTitle() { Text = "장비 구입시 같이 들어온 Spare Part 금액", Font = font });
                    chartControlPieIntergrate.Titles.Add(new ChartTitle() { Text = "Giá trị của thiết bị theo máy", Font = font });
                    Series seriesPieIntergrate = new Series("Value by month", ViewType.Pie);

                    // Bind the series to data.
                    seriesPieIntergrate.DataSource = datas[4];
                    seriesPieIntergrate.ArgumentDataMember = "NAME";
                    seriesPieIntergrate.ValueDataMembers.AddRange(new string[] { "VALUE_MACHINE" });

                    // Add the series to the chart.
                    chartControlPieIntergrate.Series.Add(seriesPieIntergrate);
                    seriesPieIntergrate.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    seriesPieIntergrate.Label.ResolveOverlappingMode = ResolveOverlappingMode.Default;
                    seriesPieIntergrate.Label.TextPattern = "{VP:p2} ({V:n0} " + "K." + cboVNDKWR.EditValue.NullString() + ")";

                    // Format the series legend items.
                    seriesPieIntergrate.LegendTextPattern = "{A}";

                    // Adjust the position of series labels. 
                    ((PieSeriesLabel)seriesPieIntergrate.Label).Position = PieSeriesLabelPosition.TwoColumns;

                    //
                    chartControlSparepartPart.Titles.Add(new ChartTitle() { Text = "Spare Part 종류별로 금액", Font = font });
                    chartControlSparepartPart.Titles.Add(new ChartTitle() { Text = "Giá trị theo từng loại thiết bị", Font = font });

                    float total = 0;
                    foreach (DataRow row in datas[5].Rows)
                    {
                        total += float.Parse(row["INVENTORY_VALUE"].NullString());
                    }

                    chartControlSparepartPart.Titles.Add(new ChartTitle() { Text = "Total: " + total.ToString("N", CultureInfo.InvariantCulture) + " K."+cboVNDKWR.EditValue.NullString(), Font = font });

                    Series seriesSparepartPart = new Series("Value by month", ViewType.Pie);

                    // Bind the series to data.
                    seriesSparepartPart.DataSource = datas[5];
                    seriesSparepartPart.ArgumentDataMember = "NAME";
                    seriesSparepartPart.ValueDataMembers.AddRange(new string[] { "INVENTORY_VALUE" });

                    // Add the series to the chart.
                    chartControlSparepartPart.Series.Add(seriesSparepartPart);
                    seriesSparepartPart.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    seriesSparepartPart.Label.ResolveOverlappingMode = ResolveOverlappingMode.Default;
                    seriesSparepartPart.Label.TextPattern = "{VP:p2} ({V:n0} " + "K." + cboVNDKWR.EditValue.NullString() + ")";

                    // Format the series legend items.
                    seriesSparepartPart.LegendTextPattern = "{A}";

                    // Adjust the position of series labels. 
                    ((PieSeriesLabel)seriesSparepartPart.Label).Position = PieSeriesLabelPosition.TwoColumns;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDraw_Click(object sender, EventArgs e)
        {
            try
            {
                string typeView = "";
                string from = "";
                string to = "";
                if (cboQty_Money.EditValue.NullString() == "" || rdoChoose.EditValue.NullString() == "" || stlDeptCode.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if(cheCboSparepart.EditValue.NullString() == "")
                {
                    if(!(cboQty_Money.EditValue.NullString() == "MONEY" && rdoChoose.EditValue.NullString() == "3"))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }
                }

                if (rdoChoose.EditValue.NullString() == "1") // DAY
                {
                    if (dateFrom.EditValue.NullString() == "" || dateTo.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    typeView = "DAY";
                    from = dateFrom.EditValue.NullString();
                    to = dateTo.EditValue.NullString();
                }
                else if (rdoChoose.EditValue.NullString() == "2")// WEEK
                {

                    if (spWeekFrom.EditValue.NullString() == "" || spWeekTo.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    typeView = "WEEK";
                    from = spWeekFrom.EditValue.NullString();
                    to = spWeekTo.EditValue.NullString();
                }
                else if (rdoChoose.EditValue.NullString() == "3") // month
                {
                    if (dateMonthFrom.EditValue.NullString() == "" || dateMonthTo.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    typeView = "MONTH";
                    from = dateMonthFrom.EditValue.NullString();
                    to = dateMonthTo.EditValue.NullString();
                }
                else if (rdoChoose.EditValue.NullString() == "4") // quarter
                {
                    if (QuaterFrom.EditValue.NullString() == "" || QuaterTo.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    typeView = "QUARTER";
                    from = QuaterFrom.EditValue.NullString();
                    to = QuaterTo.EditValue.NullString();
                }

                string typeValue = cboQty_Money.EditValue.NullString() == "MONEY" ? "M" : "QTY";
                var lstCode = cheCboSparepart.EditValue.NullString().Replace(",", "$");

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.GETDATA",
                    new string[] { "A_TYPE_VALUE", "A_TYPE_VIEW", "A_DEPARTMENT", "A_SPARE_PART_CODE", "A_FROM", "A_TO", "A_MONTH_COMPARE", "A_KRW_VND" },
                    new string[] { typeValue, typeView, stlDeptCode.EditValue.NullString(), lstCode, from, to, dateMonthCompare.EditValue.NullString(), cboVNDKWR.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    DrawChart(typeValue, datas);
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

        private string vnd_kwr = "";
        private void cboQty_Money_SelectedValueChanged(object sender, EventArgs e)
        {
            cheMinStock.Checked = cboQty_Money.EditValue.NullString() == "MONEY" ? false : true;

            if (cboQty_Money.EditValue.NullString() == "MONEY")
            {
                vnd_kwr = cboVNDKWR.EditValue.NullString();
                cboVNDKWR.Enabled = true;
            }
            else
            {
                vnd_kwr = "";
                cboVNDKWR.Enabled = false;
            }
        }

        private void stlName_EditValueChanged(object sender, EventArgs e)
        {

        }

        private Dictionary<string, string> DicNameSparepart = new Dictionary<string, string>();

        private void GetNamesSparepart()
        {
            try
            {
                if (cheCboSparepart.EditValue.NullString() == "")
                {
                    DicNameSparepart.Clear();
                    DicNameSparepart.Add("T", "");
                    return;
                }

                var lstCode = cheCboSparepart.EditValue.NullString().Replace(",", "$");
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_NAME_KR", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { stlDeptCode.EditValue.NullString(), lstCode });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];

                    foreach (DataRow row in data.Rows)
                    {
                        if (!DicNameSparepart.ContainsKey(row["CODE"].NullString()))
                        {
                            DicNameSparepart.Add(row["CODE"].NullString(), row["NAME_KR"].NullString());
                        }
                    }
                }
                else
                {
                    DicNameSparepart.Clear();
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                DicNameSparepart.Clear();
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
