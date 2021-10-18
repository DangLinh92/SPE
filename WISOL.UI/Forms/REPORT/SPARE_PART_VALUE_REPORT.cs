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
    public partial class SPARE_PART_VALUE_REPORT : PageType
    {
        public SPARE_PART_VALUE_REPORT()
        {
            InitializeComponent();
            this.Load += SPARE_PART_VALUE_REPORT_Load;
        }

        private void SPARE_PART_VALUE_REPORT_Load(object sender, EventArgs e)
        {
            try
            {
                loChartSecond.Visibility =DevExpress.XtraLayout.Utils.LayoutVisibility.Never ;
                cboVNDKWR.SelectedIndex = 0;
                Classes.Common.SetFormIdToButton(this, "SPARE_PART_VALUE_REPORT");
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
                string time = "";
                string text = "";
                if (rdoWeek.Checked)
                {
                    if (spWeek.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        spWeek.Focus();
                        return;
                    }

                    typeView = "WEEK";
                    time = spWeek.EditValue.NullString();
                    text = typeView + " " + time;
                }
                else if (rdoMonth.Checked)
                {
                    if (dateMonth.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    typeView = "MONTH";
                    time = dateMonth.EditValue.NullString();
                    text = typeView + " " + DateTime.Parse(time).Month;
                }
                else if (rdoQuarter.Checked)
                {
                    if (spQuarter.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        spQuarter.Focus();
                        return;
                    }

                    typeView = "QUARTER";
                    time = spQuarter.EditValue.NullString();
                    text = typeView + " " + time;
                }
                else if (rdoYear.Checked)
                {
                    if (dateYear.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        dateYear.Focus();
                        return;
                    }

                    typeView = "YEAR";
                    time = dateYear.EditValue.NullString();
                    text = typeView + " " + time;
                }

                if (spTopNValue.EditValue.NullString() == "" || spTopNValue.EditValue.NullString() == "0")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    spTopNValue.Focus();
                    return;
                }

                if (stlDeptCode.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    stlDeptCode.Focus();
                    return;
                }

                if (cboVNDKWR.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    cboVNDKWR.Focus();
                    return;
                }

                if (typeView == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_SPARE_PART_VALUES.GETDATA",
                 new string[] { "A_DEPARTMENT", "A_TYPE", "A_TIME", "A_KRW_VND", "A_TOP" },
                 new string[] { stlDeptCode.EditValue.NullString(), typeView, time, cboVNDKWR.EditValue.NullString(), spTopNValue.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    DrawChart(datas, chartMain, text);

                    if (dateMonth2.EditValue.NullString() != "")
                    {
                        loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                        base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CHART_SPARE_PART_VALUES.GETDATA",
                                        new string[] { "A_DEPARTMENT", "A_TYPE", "A_TIME", "A_KRW_VND", "A_TOP" },
                                        new string[] { stlDeptCode.EditValue.NullString(), typeView, dateMonth2.EditValue.NullString(), cboVNDKWR.EditValue.NullString(), spTopNValue.EditValue.NullString() });

                        if (m_ResultDB.ReturnInt == 0)
                        {
                            DataTableCollection datas1 = m_ResultDB.ReturnDataSet.Tables;

                            text = typeView + " " + DateTime.Parse(dateMonth2.EditValue.NullString()).Month;
                            DrawChart(datas1, chartSecond,text);
                        }
                        else
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
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

        private void DrawChart(DataTableCollection datas, ChartControl chartControl,string text)
        {
            chartControl.Series.Clear();
            chartControl.Titles.Clear();

            if (datas.Count == 0) return;

            //Series series_Percent = new Series("Percent(%)", ViewType.Line);
            Series series_Cumulative = new Series("Cumulative(%)", ViewType.Line);

            //series_Percent.DataSource = datas[0];
            //series_Percent.ArgumentDataMember = "SPARE_PART_CODE";
            //series_Percent.ValueDataMembers.AddRange("PERCENT_VALUE");

            //// Enable series markers.
            //LineSeriesView viewPrd = (LineSeriesView)series_Percent.View;
            //viewPrd.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

            //series_Percent.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
            //series_Percent.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
            //series_Percent.Label.TextPattern = "{V:n0}%";

            //chartMain.Series.Add(series_Percent);

            series_Cumulative.DataSource = datas[0];
            series_Cumulative.ArgumentDataMember = "SPARE_PART_CODE";
            series_Cumulative.ValueDataMembers.AddRange("CUMULATIVE");

            // Enable series markers.
            LineSeriesView viewplan = (LineSeriesView)series_Cumulative.View;
            viewplan.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

            series_Cumulative.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
            series_Cumulative.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
            series_Cumulative.Label.TextPattern = "{V:n0}%";

            chartControl.Series.Add(series_Cumulative);

            // draw column value
            Series series_iv = new Series("Value(" + "K." + cboVNDKWR.EditValue.NullString() + ")", ViewType.Bar);
            series_iv.DataSource = datas[1];
            series_iv.ArgumentDataMember = "SPARE_PART_CODE";
            series_iv.ValueDataMembers.AddRange("INVENTORY_VALUE");

            series_iv.TopNOptions.Enabled = true;
            series_iv.TopNOptions.Mode = TopNMode.Count;
            series_iv.TopNOptions.Count = int.Parse(spTopNValue.EditValue.NullString());
            series_iv.TopNOptions.ShowOthers = true;
            series_iv.TopNOptions.OthersArgument = "Others";

            series_iv.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
            series_iv.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
            series_iv.Label.TextPattern = "{V:n0}";

            chartControl.Series.Add(series_iv);

            // Create a chart title.
            ChartTitle chartTitle = new ChartTitle();
            chartTitle.Text = text;// "PHÂN TÍCH GIÁ TRỊ TỒN CỦA VẬT TƯ THIẾT BỊ - 자재, 장비 금액 분석";
            chartControl.Titles.Add(chartTitle);

            XYDiagram diagram = chartControl.Diagram as XYDiagram;
            diagram.AxisY.Label.TextPattern = "{V:n0}";
            diagram.AxisY.Title.Text = "K." + cboVNDKWR.EditValue.NullString();
            diagram.AxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
            diagram.AxisY.Title.TextColor = Color.FromArgb(36, 113, 163);

            diagram.SecondaryAxesY.Clear();
            SecondaryAxisY myAxisY = new SecondaryAxisY("Percent");
            myAxisY.Label.TextPattern = "{V:n0}";
            myAxisY.Title.Text = "Percent(%)";
            myAxisY.Title.Visibility = DevExpress.Utils.DefaultBoolean.True;
            myAxisY.Title.TextColor = Color.FromArgb(36, 113, 163);

            diagram.SecondaryAxesY.Add(myAxisY);

            //((LineSeriesView)series_Percent.View).AxisY = myAxisY;
            ((LineSeriesView)series_Cumulative.View).AxisY = myAxisY;
        }

        private void rdoWeek_CheckedChanged(object sender, EventArgs e)
        {
            if (rdoWeek.Checked)
            {
                spWeek.Enabled = true;
                dateMonth.Enabled = false;
                dateYear.Enabled = false;
                spQuarter.Enabled = false;
                dateMonth2.Enabled = false;
                dateMonth2.EditValue = null;
                loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                chartMain.Series.Clear();
                chartMain.Titles.Clear();

                chartSecond.Series.Clear();
                chartSecond.Titles.Clear();
            }
        }

        private void rdoMonth_CheckedChanged(object sender, EventArgs e)
        {
            if (rdoMonth.Checked)
            {
                spWeek.Enabled = false;
                dateMonth.Enabled = true;
                dateYear.Enabled = false;
                spQuarter.Enabled = false;
                dateMonth2.Enabled = true;
                loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                chartMain.Series.Clear();
                chartMain.Titles.Clear();

                chartSecond.Series.Clear();
                chartSecond.Titles.Clear();
            }
        }

        private void rdoQuarter_CheckedChanged(object sender, EventArgs e)
        {
            if (rdoQuarter.Checked)
            {
                spWeek.Enabled = false;
                dateMonth.Enabled = false;
                dateYear.Enabled = false;
                spQuarter.Enabled = true;
                dateMonth2.Enabled =false;
                dateMonth2.EditValue = null;
                loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                chartMain.Series.Clear();
                chartMain.Titles.Clear();

                chartSecond.Series.Clear();
                chartSecond.Titles.Clear();
            }
        }

        private void rdoYear_CheckedChanged(object sender, EventArgs e)
        {
            if (rdoYear.Checked)
            {
                spWeek.Enabled = false;
                dateMonth.Enabled = false;
                dateYear.Enabled = true;
                spQuarter.Enabled = false;
                dateMonth2.Enabled = false;
                dateMonth2.EditValue = null;
                loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                chartMain.Series.Clear();
                chartMain.Titles.Clear();

                chartSecond.Series.Clear();
                chartSecond.Titles.Clear();
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            rdoMonth.Checked = false;
            rdoWeek.Checked = false;
            rdoQuarter.Checked = false;
            rdoYear.Checked = false;

            spWeek.EditValue = 0;
            dateMonth.EditValue = null;
            dateMonth2.EditValue = null;
            spQuarter.EditValue = null;
            dateYear.EditValue = null;
            spTopNValue.EditValue = 0;

            spWeek.Enabled = true;
            dateMonth.Enabled = true;
            dateYear.Enabled = true;
            spQuarter.Enabled = true;
            dateMonth2.Enabled = true;

            chartMain.Series.Clear();
            chartMain.Titles.Clear();

            chartSecond.Series.Clear();
            chartSecond.Titles.Clear();
            loChartSecond.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
        }
    }
}
