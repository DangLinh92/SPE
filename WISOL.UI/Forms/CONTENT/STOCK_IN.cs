using DevExpress.XtraCharts;
using DevExpress.XtraReports.UI;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class STOCK_IN : PageType
    {
        DataTable dtChart = new DataTable();
        DataTable lot = new DataTable();
        string label = string.Empty;
        public STOCK_IN()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
        }
        public override void InitializePage()
        {
            try
            {
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKIN.INIT_PUT", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[0], "CODE", "DEPARTMENT");
                    base.m_BindData.BindGridLookEdit(sltSparePart, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(sltLocation, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "LOCATION");
                    base.m_BindData.BindGridLookEdit(sltCtg, base.m_ResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");
                }

                Init_Control(true);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                sltSparePart.EditValue = string.Empty;
                txtQuantity.EditValue = string.Empty;
                radioPrint.EditValue = "0";
                sltDepartment.EditValue = Consts.DEPARTMENT;
                sltLocation.EditValue = string.Empty;
                sltCtg.EditValue = "NEW";
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void sltSparePart_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                DateTime date = DateTime.Now;
                var firstDayOfMonth = date.AddDays(-20);
                var lastDayOfMonth = date.AddDays(1);

                var start = firstDayOfMonth.ToString("yyyyMMddHHmmss");
                var end = lastDayOfMonth.ToString("yyyyMMddHHmmss");

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_COST.GET", new string[] { "A_DEPARTMENT", "A_ROLE", "A_SP", "A_START", "A_END" },
                    new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, sltSparePart.EditValue.NullString(), start, end });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcListStockin, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvListStockin.Columns["NAME_VI"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["UNIT"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["NAME_VI"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["QUANTITY"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["MIN_STOCK"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["VALID_DATE"].OptionsColumn.AllowMerge = DevExpress.Utils.DefaultBoolean.True;
                    gvListStockin.Columns["QUANTITY"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvListStockin.Columns["QUANTITY"].DisplayFormat.FormatString = "n0";
                    gvListStockin.Columns["MIN_STOCK"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvListStockin.Columns["MIN_STOCK"].DisplayFormat.FormatString = "n0";
                    gvListStockin.Columns["ID"].Visible = false;

                    base.m_BindData.BindGridView(gcToday, base.m_ResultDB.ReturnDataSet.Tables[2]);

                    gvToday.Columns["COST"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvToday.Columns["COST"].DisplayFormat.FormatString = "n0";
                    gvToday.Columns["QUANTITY"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvToday.Columns["QUANTITY"].DisplayFormat.FormatString = "n0";

                    dtChart = base.m_ResultDB.ReturnDataSet.Tables[1];
                    DataTable dt = new DataTable();
                    dt.Columns.Add("VALUE_NAME", typeof(string));
                    dt.Columns.Add("VALID_DATE", typeof(string));
                    dt.Columns.Add("VALUE", typeof(double));
                    
                    for (int i = 0; i < dtChart.Rows.Count; i++)
                    {
                        dt.Rows.Add(new object[] { "STOCK".Translation(), dtChart.Rows[i]["NAME_VI"].ToString(), dtChart.Rows[i]["STOCK"].ToString() });
                        dt.Rows.Add(new object[] { "MIN_STOCK".Translation(), dtChart.Rows[i]["NAME_VI"].ToString(), dtChart.Rows[i]["MIN_STOCK"].ToString() });
                    }

                    chartControl1.DataSource = dt;

                    chartControl1.SeriesDataMember = "VALUE_NAME";
                    chartControl1.SeriesTemplate.ArgumentDataMember = "VALID_DATE";
                    chartControl1.SeriesTemplate.ValueDataMembers.AddRange(new string[] { "VALUE" });
                    chartControl1.SeriesTemplate.View = new SideBySideBarSeriesView();

                    for (int i = 0; i < chartControl1.Series.Count; i++)
                    {
                        if (i == 0)
                        {
                            chartControl1.Series[i].View.Color = Color.FromArgb(91, 155, 213);
                            chartControl1.Series[i].LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                            (chartControl1.Series[i].Label as SideBySideBarSeriesLabel).Position = BarSeriesLabelPosition.Top;
                        }
                        if (i == 1)
                        {
                            chartControl1.Series[i].View.Color = Color.FromArgb(255, 0, 0);
                            chartControl1.Series[i].LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;
                            (chartControl1.Series[i].Label as SideBySideBarSeriesLabel).Position = BarSeriesLabelPosition.Top;
                        }
                    }
                    chartControl1.Legend.AlignmentHorizontal = LegendAlignmentHorizontal.Center;
                    chartControl1.Legend.AlignmentVertical = LegendAlignmentVertical.BottomOutside;
                    chartControl1.Legend.Direction = LegendDirection.LeftToRight;

                    XYDiagram diagram = (XYDiagram)chartControl1.Diagram;
                    diagram.AxisY.WholeRange.Auto = true;
                    diagram.AxisY.WholeRange.AlwaysShowZeroLevel = true;
                    diagram.EnableAxisXZooming = true;
                    diagram.EnableAxisYZooming = true;
                    chartControl1.Dock = DockStyle.Fill;
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
                if (string.IsNullOrEmpty(sltDepartment.EditValue.NullString()) == true || string.IsNullOrEmpty(sltSparePart.EditValue.NullString()) == true || string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                DateTime date = DateTime.Now;

                var valid_date = date.ToString("yyyyMMdd");
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKIN.PUT",
                    new string[] { "A_QUANTITY", "A_SP", "A_DEPARTMENT", "A_USER", "A_ROLE","A_VALID_DATE", "A_CURRENCY", "A_LOCATION", "A_CTG" },
                    new string[] { txtQuantity.EditValue.NullString(), sltSparePart.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.Id, Consts.USER_INFO.UserRole, valid_date, "", sltLocation.EditValue.NullString(), sltCtg.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    lot = base.m_ResultDB.ReturnDataSet.Tables[1];
                    label = base.m_ResultDB.ReturnDataSet.Tables[2].Rows[0]["LABEL"].ToString();
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }

                if (radioPrint.EditValue.ToString() == "0")
                {
                    string designFile = string.Empty;
                    string xml_content_Original = label;
                    string xml_content = string.Empty;

                    try
                    {
                        designFile = "STOCKIN_LABEL.xml";

                        XtraReport reportPrint = new XtraReport();
                        for (int i = 0; i < lot.Rows.Count; i++)
                        {
                            string[] arrListStr = lot.Rows[i]["LOT_NO"].ToString().Split('.');

                            xml_content = xml_content_Original.Replace("$NAME$", (arrListStr[0] + '.'+ arrListStr[1] + arrListStr[2]).ToString().ToUpper());
                            xml_content = xml_content.Replace("$BARCODE$", lot.Rows[i]["LOT_NO"].ToString().ToUpper());
                            xml_content = xml_content.Replace("$LOCATION$", lot.Rows[i]["LOCATION"].ToString().ToUpper());

                            xml_content = xml_content.Replace("&", "&amp;");
                            File.WriteAllText((i + 1).NullString() + designFile, xml_content);

                            XtraReport report = new XtraReport();

                            report.PrintingSystem.ShowPrintStatusDialog = false;
                            report.PrintingSystem.ShowMarginsWarning = false;

                            report.LoadLayoutFromXml((i + 1).NullString() + designFile);
                            int leftMargine = report.Margins.Left + 2;
                            int rightMargine = report.Margins.Right;
                            int topMargine = report.Margins.Top + 0;
                            int bottomMargine = report.Margins.Bottom;
                            if (leftMargine < 0)
                            {
                                leftMargine = 0;
                            }
                            if (topMargine < 0)
                            {
                                topMargine = 0;
                            }
                            report.Margins = new System.Drawing.Printing.Margins(leftMargine, rightMargine, topMargine, bottomMargine);
                            report.CreateDocument();
                            reportPrint.Pages.AddRange(report.Pages);
                            File.Delete((i + 1).NullString() + designFile);
                        }
                        
                        reportPrint.PrintingSystem.ShowPrintStatusDialog = false;
                        reportPrint.PrintingSystem.ShowMarginsWarning = false;
                        //reportPrint.CreateDocument();
                        //reportPrint.ShowPreview();
                        reportPrint.Print();
                        reportPrint.PrintingSystem.ExecCommand(DevExpress.XtraPrinting.PrintingSystemCommand.Parameters, new object[] { true });
                    }
                    catch (Exception ex)
                    {
                        MsgBox.Show(ex.Message, MsgType.Error);
                    }
                }
                Init_Control(true);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvCost_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;
                else
                {

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
