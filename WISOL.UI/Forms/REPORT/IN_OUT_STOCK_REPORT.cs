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
                dateMonthCompare.EditValue = DateTime.Now;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.INIT_SPAREPART", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    m_BindData.BindGridLookEdit(stlName, datas[0], "CODE", "NAME");
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
                    m_BindData.BindGridLookEdit(stlName, datas[0], "CODE", "NAME");
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
                string unitType = valueType == "M" ? "VND" : "PACK";

                string unitLine = "";
                if (Consts.DEPARTMENT == Consts.SMT_DEPT)
                {
                    unitLine = "Point";
                }

                Series series_Prd = new Series("Product " + unitLine, ViewType.Line);
                Series series_Plant = new Series("Plant " + unitLine, ViewType.Line);
                if (datas.Count >= 2)
                {
                    series_Prd.DataSource = datas[1];
                    series_Prd.ArgumentDataMember = "TIME_VALUE";
                    series_Prd.ValueDataMembers.AddRange("PRODUCT");

                    // Enable series markers.
                    LineSeriesView viewPrd = (LineSeriesView)series_Prd.View;
                    viewPrd.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

                    series_Prd.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_Prd.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_Prd.Label.TextPattern = "{V:n2}";

                    chartMain.Series.Add(series_Prd);

                    if (datas.Count > 2)
                    {
                        series_Plant.DataSource = datas[2];
                        series_Plant.ArgumentDataMember = "TIME_VALUE";
                        series_Plant.ValueDataMembers.AddRange("PLANT");

                        // Enable series markers.
                        LineSeriesView viewplan = (LineSeriesView)series_Plant.View;
                        viewplan.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

                        series_Plant.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_Plant.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_Plant.Label.TextPattern = "{V:n2}";

                        chartMain.Series.Add(series_Plant);
                    }
                }

                if (cheReceive.Checked)
                {
                    Series series_in = new Series("Receive " + unitType, ViewType.Bar);
                    series_in.DataSource = datas[0];
                    series_in.ArgumentDataMember = "TIME_VALUE";
                    series_in.ValueDataMembers.AddRange("IN_VALUE");

                    series_in.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_in.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_in.Label.TextPattern = "{V:n2}";

                    chartMain.Series.Add(series_in);

                }

                if (cheDelivery.Checked)
                {
                    Series series_out = new Series("Delivery " + unitType, ViewType.Bar);
                    series_out.DataSource = datas[0];
                    series_out.ArgumentDataMember = "TIME_VALUE";
                    series_out.ValueDataMembers.AddRange("OUT_VALUE");

                    series_out.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_out.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_out.Label.TextPattern = "{V:n2}";

                    chartMain.Series.Add(series_out);
                }

                if (cheStock.Checked)
                {
                    Series series_iv = new Series("Stock " + unitType, ViewType.Bar);
                    series_iv.DataSource = datas[0];
                    series_iv.ArgumentDataMember = "TIME_VALUE";
                    series_iv.ValueDataMembers.AddRange("INVENTORY");

                    series_iv.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_iv.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_iv.Label.TextPattern = "{V:n2}";

                    chartMain.Series.Add(series_iv);

                    //// Create and customize a trendline, 
                    //TrendLine trendline1 = new TrendLine("Stock Trending");
                    //trendline1.Point1.Argument = datas[0].Rows[0]["TIME_VALUE"].NullString();
                    //trendline1.Point1.ValueLevel = ValueLevel.High;
                    //trendline1.Point2.Argument = datas[0].Rows[datas[0].Rows.Count - 1]["TIME_VALUE"].NullString();
                    //trendline1.Point2.ValueLevel = ValueLevel.High;
                    //trendline1.ExtrapolateToInfinity = true;
                    //trendline1.Color = Color.Red;
                    //trendline1.LineStyle.DashStyle = DashStyle.Dash;

                    //BarSeriesView barSeriesView = (BarSeriesView)series_iv.View;

                    //// Define the Y-axis range.
                    //barSeriesView.AxisY.WholeRange.AlwaysShowZeroLevel = false;

                    //// Add the trendline to the series collection of indicators.
                    //barSeriesView.Indicators.Add(trendline1);
                }

                // Create a chart title.
                ChartTitle chartTitle = new ChartTitle();
                chartTitle.Text = "TỔNG HỢP XUẤT NHẬP TỒN -재고 보고서";
                chartMain.Titles.Add(chartTitle);

                XYDiagram diagram = chartMain.Diagram as XYDiagram;
                diagram.AxisY.Label.TextPattern = "{V:n2}";
                diagram.AxisY.Title.Text = unitType;
                diagram.AxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
                diagram.AxisY.Title.TextColor = Color.FromArgb(243, 156, 18);

                diagram.SecondaryAxesY.Clear();
                SecondaryAxisY myAxisY = new SecondaryAxisY("Plan-Product");
                myAxisY.Label.TextPattern = "{V:n2}";
                myAxisY.Title.Text = "GOC plan and product " + (unitLine != "" ? "(" + unitLine + ")" : "");
                myAxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
                myAxisY.Title.TextColor = Color.FromArgb(243, 156, 18);

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
                    chartControlPieSingle.Titles.Add(new ChartTitle() { Text = "월에 Spare part 재고 금액",Font = font });
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
                    seriesPieSingle.Label.TextPattern = "{VP:p2} ({V:n2} VND)";

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
                    seriesPieIntergrate.Label.TextPattern = "{VP:p2} ({V:n2} VND)";//"{V:n2}";

                    // Format the series legend items.
                    seriesPieIntergrate.LegendTextPattern = "{A}";

                    // Adjust the position of series labels. 
                    ((PieSeriesLabel)seriesPieIntergrate.Label).Position = PieSeriesLabelPosition.TwoColumns;

                    //
                    chartControlSparepartPart.Titles.Add(new ChartTitle() { Text = "Spare Part 종류별로 금액", Font = font });
                    chartControlSparepartPart.Titles.Add(new ChartTitle() { Text = "Giá trị theo từng loại thiết bị", Font = font });
                    Series seriesSparepartPart = new Series("Value by month", ViewType.Pie);

                    // Bind the series to data.
                    seriesSparepartPart.DataSource = datas[5];
                    seriesSparepartPart.ArgumentDataMember = "NAME";
                    seriesSparepartPart.ValueDataMembers.AddRange(new string[] { "INVENTORY_VALUE" });

                    // Add the series to the chart.
                    chartControlSparepartPart.Series.Add(seriesSparepartPart);
                    seriesSparepartPart.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    seriesSparepartPart.Label.ResolveOverlappingMode = ResolveOverlappingMode.Default;
                    seriesSparepartPart.Label.TextPattern = "{VP:p2} ({V:n2} VND)";//"{V:n2}";

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
                if (cboQty_Money.EditValue.NullString() == "" || rdoChoose.EditValue.NullString() == "" || stlDeptCode.EditValue.NullString() == "" || stlName.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
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

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_IN_OUT_STOCK.GETDATA",
                    new string[] { "A_TYPE_VALUE", "A_TYPE_VIEW", "A_DEPARTMENT", "A_SPARE_PART_CODE", "A_FROM", "A_TO", "A_MONTH_COMPARE" },
                    new string[] { typeValue, typeView, stlDeptCode.EditValue.NullString(), stlName.EditValue.NullString(), from, to, dateMonthCompare.EditValue.NullString() });

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
    }
}
