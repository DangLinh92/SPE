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

                    series_Prd.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                    series_Prd.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                    series_Prd.Label.TextPattern = "{V:n2}";

                    chartMain.Series.Add(series_Prd);

                    if (datas.Count > 2)
                    {
                        series_Plant.DataSource = datas[2];
                        series_Plant.ArgumentDataMember = "TIME_VALUE";
                        series_Plant.ValueDataMembers.AddRange("PLANT");

                        series_Plant.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                        series_Plant.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                        series_Plant.Label.TextPattern = "{V:n2}";

                        chartMain.Series.Add(series_Plant);
                    }
                }

                Series series_in = new Series("Receive " + unitType, ViewType.Bar);
                series_in.DataSource = datas[0];
                series_in.ArgumentDataMember = "TIME_VALUE";
                series_in.ValueDataMembers.AddRange("IN_VALUE");

                series_in.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                series_in.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                series_in.Label.TextPattern = "{V:n2}";

                chartMain.Series.Add(series_in);

                Series series_out = new Series("Delivery " + unitType, ViewType.Bar);
                series_out.DataSource = datas[0];
                series_out.ArgumentDataMember = "TIME_VALUE";
                series_out.ValueDataMembers.AddRange("OUT_VALUE");

                series_out.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                series_out.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                series_out.Label.TextPattern = "{V:n2}";

                chartMain.Series.Add(series_out);

                Series series_iv = new Series("Stock " + unitType, ViewType.Bar);
                series_iv.DataSource = datas[0];
                series_iv.ArgumentDataMember = "TIME_VALUE";
                series_iv.ValueDataMembers.AddRange("INVENTORY");

                series_iv.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                series_iv.Label.ResolveOverlappingMode = ResolveOverlappingMode.HideOverlapped;
                series_iv.Label.TextPattern = "{V:n2}";

                chartMain.Series.Add(series_iv);

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
                    new string[] { "A_TYPE_VALUE", "A_TYPE_VIEW", "A_DEPARTMENT", "A_SPARE_PART_CODE", "A_FROM", "A_TO" },
                    new string[] { typeValue, typeView, stlDeptCode.EditValue.NullString(), stlName.EditValue.NullString(), from, to });

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
