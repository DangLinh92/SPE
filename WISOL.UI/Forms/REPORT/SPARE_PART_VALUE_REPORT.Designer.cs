
using DevExpress.XtraEditors;

namespace Wisol.MES.Forms.REPORT
{
    partial class SPARE_PART_VALUE_REPORT
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SPARE_PART_VALUE_REPORT));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.xLayoutControl2 = new Wisol.XLayoutControl();
            this.spTopNValue = new DevExpress.XtraEditors.SpinEdit();
            this.cboVNDKWR = new DevExpress.XtraEditors.ComboBoxEdit();
            this.dateYear = new DevExpress.XtraEditors.DateEdit();
            this.rdoYear = new System.Windows.Forms.RadioButton();
            this.rdoQuarter = new System.Windows.Forms.RadioButton();
            this.rdoWeek = new System.Windows.Forms.RadioButton();
            this.rdoMonth = new System.Windows.Forms.RadioButton();
            this.btnDraw = new Wisol.XSimpleButton(this.components);
            this.dateMonth = new DevExpress.XtraEditors.DateEdit();
            this.spWeek = new DevExpress.XtraEditors.SpinEdit();
            this.stlDeptCode = new Wisol.AceGridLookUpEdit(this.components);
            this.aceGridLookUpEdit1View = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.spQuarter = new DevExpress.XtraEditors.SpinEdit();
            this.layoutControlGroup1 = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem8 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem9 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem10 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem11 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem12 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem7 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem13 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem14 = new DevExpress.XtraLayout.LayoutControlItem();
            this.chartMain = new DevExpress.XtraCharts.ChartControl();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl2)).BeginInit();
            this.xLayoutControl2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.spTopNValue.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboVNDKWR.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateYear.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateYear.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateMonth.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateMonth.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spWeek.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.stlDeptCode.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spQuarter.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlGroup1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem8)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem9)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem10)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem11)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem12)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem13)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem14)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartMain)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1824, 851);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "Biểu đồ phân tích giá trị vật tư/자재, 장비 금액 분석";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.panelControl1);
            this.xLayoutControl1.Controls.Add(this.chartMain);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1820, 826);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.xLayoutControl2);
            this.panelControl1.Location = new System.Drawing.Point(1483, 12);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(325, 802);
            this.panelControl1.TabIndex = 5;
            // 
            // xLayoutControl2
            // 
            this.xLayoutControl2.Controls.Add(this.spTopNValue);
            this.xLayoutControl2.Controls.Add(this.cboVNDKWR);
            this.xLayoutControl2.Controls.Add(this.dateYear);
            this.xLayoutControl2.Controls.Add(this.rdoYear);
            this.xLayoutControl2.Controls.Add(this.rdoQuarter);
            this.xLayoutControl2.Controls.Add(this.rdoWeek);
            this.xLayoutControl2.Controls.Add(this.rdoMonth);
            this.xLayoutControl2.Controls.Add(this.btnDraw);
            this.xLayoutControl2.Controls.Add(this.dateMonth);
            this.xLayoutControl2.Controls.Add(this.spWeek);
            this.xLayoutControl2.Controls.Add(this.stlDeptCode);
            this.xLayoutControl2.Controls.Add(this.spQuarter);
            this.xLayoutControl2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl2.Location = new System.Drawing.Point(2, 2);
            this.xLayoutControl2.Name = "xLayoutControl2";
            this.xLayoutControl2.Root = this.layoutControlGroup1;
            this.xLayoutControl2.Size = new System.Drawing.Size(321, 798);
            this.xLayoutControl2.TabIndex = 0;
            this.xLayoutControl2.Text = "xLayoutControl2";
            // 
            // spTopNValue
            // 
            this.spTopNValue.EditValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.spTopNValue.Location = new System.Drawing.Point(130, 185);
            this.spTopNValue.Name = "spTopNValue";
            this.spTopNValue.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.spTopNValue.Size = new System.Drawing.Size(179, 20);
            this.spTopNValue.StyleController = this.xLayoutControl2;
            this.spTopNValue.TabIndex = 18;
            // 
            // cboVNDKWR
            // 
            this.cboVNDKWR.Location = new System.Drawing.Point(130, 41);
            this.cboVNDKWR.Name = "cboVNDKWR";
            this.cboVNDKWR.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cboVNDKWR.Properties.Items.AddRange(new object[] {
            "VND",
            "KRW"});
            this.cboVNDKWR.Size = new System.Drawing.Size(179, 20);
            this.cboVNDKWR.StyleController = this.xLayoutControl2;
            this.cboVNDKWR.TabIndex = 17;
            // 
            // dateYear
            // 
            this.dateYear.EditValue = null;
            this.dateYear.Location = new System.Drawing.Point(130, 161);
            this.dateYear.Name = "dateYear";
            this.dateYear.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateYear.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateYear.Properties.VistaCalendarInitialViewStyle = DevExpress.XtraEditors.VistaCalendarInitialViewStyle.YearsGroupView;
            this.dateYear.Properties.VistaCalendarViewStyle = DevExpress.XtraEditors.VistaCalendarViewStyle.YearsGroupView;
            this.dateYear.Size = new System.Drawing.Size(179, 20);
            this.dateYear.StyleController = this.xLayoutControl2;
            this.dateYear.TabIndex = 16;
            // 
            // rdoYear
            // 
            this.rdoYear.Location = new System.Drawing.Point(243, 12);
            this.rdoYear.Name = "rdoYear";
            this.rdoYear.Size = new System.Drawing.Size(66, 25);
            this.rdoYear.TabIndex = 15;
            this.rdoYear.TabStop = true;
            this.rdoYear.Text = "YEAR";
            this.rdoYear.UseVisualStyleBackColor = true;
            this.rdoYear.CheckedChanged += new System.EventHandler(this.rdoYear_CheckedChanged);
            // 
            // rdoQuarter
            // 
            this.rdoQuarter.Location = new System.Drawing.Point(162, 12);
            this.rdoQuarter.Name = "rdoQuarter";
            this.rdoQuarter.Size = new System.Drawing.Size(77, 25);
            this.rdoQuarter.TabIndex = 14;
            this.rdoQuarter.TabStop = true;
            this.rdoQuarter.Text = "QUARTER";
            this.rdoQuarter.UseVisualStyleBackColor = true;
            this.rdoQuarter.CheckedChanged += new System.EventHandler(this.rdoQuarter_CheckedChanged);
            // 
            // rdoWeek
            // 
            this.rdoWeek.Location = new System.Drawing.Point(12, 12);
            this.rdoWeek.Name = "rdoWeek";
            this.rdoWeek.Size = new System.Drawing.Size(69, 25);
            this.rdoWeek.TabIndex = 13;
            this.rdoWeek.TabStop = true;
            this.rdoWeek.Text = "WEEK";
            this.rdoWeek.UseVisualStyleBackColor = true;
            this.rdoWeek.CheckedChanged += new System.EventHandler(this.rdoWeek_CheckedChanged);
            // 
            // rdoMonth
            // 
            this.rdoMonth.Location = new System.Drawing.Point(85, 12);
            this.rdoMonth.Name = "rdoMonth";
            this.rdoMonth.Size = new System.Drawing.Size(73, 25);
            this.rdoMonth.TabIndex = 12;
            this.rdoMonth.TabStop = true;
            this.rdoMonth.Text = "MONTH";
            this.rdoMonth.UseVisualStyleBackColor = true;
            this.rdoMonth.CheckedChanged += new System.EventHandler(this.rdoMonth_CheckedChanged);
            // 
            // btnDraw
            // 
            this.btnDraw.FormId = null;
            this.btnDraw.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnDraw.ImageOptions.Image")));
            this.btnDraw.isFormType = false;
            this.btnDraw.Location = new System.Drawing.Point(180, 209);
            this.btnDraw.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnDraw.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnDraw.Name = "btnDraw";
            this.btnDraw.Size = new System.Drawing.Size(129, 30);
            this.btnDraw.StyleController = this.xLayoutControl2;
            this.btnDraw.TabIndex = 11;
            this.btnDraw.Text = "VIEW";
            this.btnDraw.Click += new System.EventHandler(this.btnDraw_Click);
            // 
            // dateMonth
            // 
            this.dateMonth.EditValue = null;
            this.dateMonth.Location = new System.Drawing.Point(130, 113);
            this.dateMonth.Name = "dateMonth";
            this.dateMonth.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateMonth.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateMonth.Properties.VistaCalendarInitialViewStyle = DevExpress.XtraEditors.VistaCalendarInitialViewStyle.YearView;
            this.dateMonth.Properties.VistaCalendarViewStyle = DevExpress.XtraEditors.VistaCalendarViewStyle.YearView;
            this.dateMonth.Size = new System.Drawing.Size(179, 20);
            this.dateMonth.StyleController = this.xLayoutControl2;
            this.dateMonth.TabIndex = 9;
            // 
            // spWeek
            // 
            this.spWeek.EditValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.spWeek.Location = new System.Drawing.Point(130, 89);
            this.spWeek.Name = "spWeek";
            this.spWeek.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.spWeek.Properties.MaxValue = new decimal(new int[] {
            54,
            0,
            0,
            0});
            this.spWeek.Size = new System.Drawing.Size(179, 20);
            this.spWeek.StyleController = this.xLayoutControl2;
            this.spWeek.TabIndex = 6;
            // 
            // stlDeptCode
            // 
            this.stlDeptCode.EditValue = "";
            this.stlDeptCode.Location = new System.Drawing.Point(130, 65);
            this.stlDeptCode.Name = "stlDeptCode";
            this.stlDeptCode.Properties.Appearance.Options.UseTextOptions = true;
            this.stlDeptCode.Properties.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.stlDeptCode.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.stlDeptCode.Properties.ImmediatePopup = true;
            this.stlDeptCode.Properties.NullText = "";
            this.stlDeptCode.Properties.PopupView = this.aceGridLookUpEdit1View;
            this.stlDeptCode.Size = new System.Drawing.Size(179, 20);
            this.stlDeptCode.StyleController = this.xLayoutControl2;
            this.stlDeptCode.TabIndex = 5;
            // 
            // aceGridLookUpEdit1View
            // 
            this.aceGridLookUpEdit1View.FocusRectStyle = DevExpress.XtraGrid.Views.Grid.DrawFocusRectStyle.RowFocus;
            this.aceGridLookUpEdit1View.Name = "aceGridLookUpEdit1View";
            this.aceGridLookUpEdit1View.OptionsSelection.EnableAppearanceFocusedCell = false;
            this.aceGridLookUpEdit1View.OptionsView.ShowAutoFilterRow = true;
            this.aceGridLookUpEdit1View.OptionsView.ShowGroupPanel = false;
            // 
            // spQuarter
            // 
            this.spQuarter.EditValue = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.spQuarter.Location = new System.Drawing.Point(130, 137);
            this.spQuarter.Name = "spQuarter";
            this.spQuarter.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.spQuarter.Properties.MaxValue = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.spQuarter.Size = new System.Drawing.Size(179, 20);
            this.spQuarter.StyleController = this.xLayoutControl2;
            this.spQuarter.TabIndex = 6;
            // 
            // layoutControlGroup1
            // 
            this.layoutControlGroup1.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.layoutControlGroup1.GroupBordersVisible = false;
            this.layoutControlGroup1.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem4,
            this.layoutControlItem5,
            this.layoutControlItem8,
            this.layoutControlItem9,
            this.layoutControlItem10,
            this.layoutControlItem11,
            this.layoutControlItem12,
            this.layoutControlItem6,
            this.layoutControlItem3,
            this.layoutControlItem7,
            this.layoutControlItem13,
            this.layoutControlItem14});
            this.layoutControlGroup1.Name = "Root";
            this.layoutControlGroup1.Size = new System.Drawing.Size(321, 798);
            this.layoutControlGroup1.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.stlDeptCode;
            this.layoutControlItem4.Location = new System.Drawing.Point(0, 53);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem4.Text = "Bộ phận-학과";
            this.layoutControlItem4.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.dateMonth;
            this.layoutControlItem5.Location = new System.Drawing.Point(0, 101);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem5.Text = "MONTH";
            this.layoutControlItem5.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem8
            // 
            this.layoutControlItem8.ContentHorzAlignment = DevExpress.Utils.HorzAlignment.Far;
            this.layoutControlItem8.Control = this.btnDraw;
            this.layoutControlItem8.Location = new System.Drawing.Point(0, 197);
            this.layoutControlItem8.Name = "layoutControlItem8";
            this.layoutControlItem8.Size = new System.Drawing.Size(301, 581);
            this.layoutControlItem8.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem8.TextVisible = false;
            // 
            // layoutControlItem9
            // 
            this.layoutControlItem9.Control = this.rdoMonth;
            this.layoutControlItem9.Location = new System.Drawing.Point(73, 0);
            this.layoutControlItem9.Name = "layoutControlItem9";
            this.layoutControlItem9.Size = new System.Drawing.Size(77, 29);
            this.layoutControlItem9.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem9.TextVisible = false;
            // 
            // layoutControlItem10
            // 
            this.layoutControlItem10.Control = this.rdoWeek;
            this.layoutControlItem10.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem10.Name = "layoutControlItem10";
            this.layoutControlItem10.Size = new System.Drawing.Size(73, 29);
            this.layoutControlItem10.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem10.TextVisible = false;
            // 
            // layoutControlItem11
            // 
            this.layoutControlItem11.Control = this.rdoQuarter;
            this.layoutControlItem11.Location = new System.Drawing.Point(150, 0);
            this.layoutControlItem11.Name = "layoutControlItem11";
            this.layoutControlItem11.Size = new System.Drawing.Size(81, 29);
            this.layoutControlItem11.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem11.TextVisible = false;
            // 
            // layoutControlItem12
            // 
            this.layoutControlItem12.Control = this.rdoYear;
            this.layoutControlItem12.Location = new System.Drawing.Point(231, 0);
            this.layoutControlItem12.Name = "layoutControlItem12";
            this.layoutControlItem12.Size = new System.Drawing.Size(70, 29);
            this.layoutControlItem12.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem12.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.dateYear;
            this.layoutControlItem6.Location = new System.Drawing.Point(0, 149);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem6.Text = "YEAR";
            this.layoutControlItem6.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.spWeek;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 77);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem3.Text = "WEEK";
            this.layoutControlItem3.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem7
            // 
            this.layoutControlItem7.Control = this.spQuarter;
            this.layoutControlItem7.ControlAlignment = System.Drawing.ContentAlignment.TopLeft;
            this.layoutControlItem7.CustomizationFormText = "WEEK";
            this.layoutControlItem7.Location = new System.Drawing.Point(0, 125);
            this.layoutControlItem7.Name = "layoutControlItem7";
            this.layoutControlItem7.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem7.Text = "QUARTER";
            this.layoutControlItem7.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem13
            // 
            this.layoutControlItem13.Control = this.cboVNDKWR;
            this.layoutControlItem13.Location = new System.Drawing.Point(0, 29);
            this.layoutControlItem13.Name = "layoutControlItem13";
            this.layoutControlItem13.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem13.Text = "Giá trị hiển thị-표시 값";
            this.layoutControlItem13.TextSize = new System.Drawing.Size(106, 13);
            // 
            // layoutControlItem14
            // 
            this.layoutControlItem14.Control = this.spTopNValue;
            this.layoutControlItem14.Location = new System.Drawing.Point(0, 173);
            this.layoutControlItem14.Name = "layoutControlItem14";
            this.layoutControlItem14.Size = new System.Drawing.Size(301, 24);
            this.layoutControlItem14.Text = "TOP N Value";
            this.layoutControlItem14.TextSize = new System.Drawing.Size(106, 13);
            // 
            // chartMain
            // 
            this.chartMain.Location = new System.Drawing.Point(12, 12);
            this.chartMain.Name = "chartMain";
            this.chartMain.SeriesSerializable = new DevExpress.XtraCharts.Series[0];
            this.chartMain.Size = new System.Drawing.Size(1467, 802);
            this.chartMain.TabIndex = 4;
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.layoutControlItem2});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1820, 826);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.chartMain;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1471, 806);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.panelControl1;
            this.layoutControlItem2.Location = new System.Drawing.Point(1471, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(329, 806);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // SPARE_PART_VALUE_REPORT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupControl1);
            this.Name = "SPARE_PART_VALUE_REPORT";
            this.Size = new System.Drawing.Size(1824, 851);
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl2)).EndInit();
            this.xLayoutControl2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.spTopNValue.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cboVNDKWR.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateYear.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateYear.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateMonth.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateMonth.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spWeek.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.stlDeptCode.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spQuarter.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlGroup1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem8)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem9)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem10)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem11)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem12)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem13)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem14)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.chartMain)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraCharts.ChartControl chartMain;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private XLayoutControl xLayoutControl2;
        private DevExpress.XtraLayout.LayoutControlGroup layoutControlGroup1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private AceGridLookUpEdit stlDeptCode;
        private DevExpress.XtraGrid.Views.Grid.GridView aceGridLookUpEdit1View;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private DevExpress.XtraEditors.SpinEdit spWeek;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private DevExpress.XtraEditors.DateEdit dateMonth;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
        private XSimpleButton btnDraw;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem8;
        private System.Windows.Forms.RadioButton rdoYear;
        private System.Windows.Forms.RadioButton rdoQuarter;
        private System.Windows.Forms.RadioButton rdoWeek;
        private System.Windows.Forms.RadioButton rdoMonth;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem9;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem10;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem11;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem12;
        private DateEdit dateYear;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
        private SpinEdit spQuarter;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem7;
        private ComboBoxEdit cboVNDKWR;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem13;
        private SpinEdit spTopNValue;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem14;
    }
}