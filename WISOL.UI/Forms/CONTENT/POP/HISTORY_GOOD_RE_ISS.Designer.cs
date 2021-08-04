
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class HISTORY_GOOD_RE_ISS
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(HISTORY_GOOD_RE_ISS));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnSearch = new DevExpress.XtraEditors.SimpleButton();
            this.dateFrom = new DevExpress.XtraEditors.DateEdit();
            this.dateTo = new DevExpress.XtraEditors.DateEdit();
            this.stlSparepart = new Wisol.AceGridLookUpEdit(this.components);
            this.aceGridLookUpEdit1View = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dateFrom.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateFrom.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateTo.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateTo.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.stlSparepart.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1431, 816);
            this.groupControl1.TabIndex = 4;
            this.groupControl1.Text = "Lịch sử nhập xuất thiết bị";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnSearch);
            this.xLayoutControl1.Controls.Add(this.dateFrom);
            this.xLayoutControl1.Controls.Add(this.dateTo);
            this.xLayoutControl1.Controls.Add(this.stlSparepart);
            this.xLayoutControl1.Controls.Add(this.gcList);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1427, 791);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnSearch
            // 
            this.btnSearch.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnSearch.ImageOptions.Image")));
            this.btnSearch.Location = new System.Drawing.Point(1260, 12);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(155, 22);
            this.btnSearch.StyleController = this.xLayoutControl1;
            this.btnSearch.TabIndex = 8;
            this.btnSearch.Text = "SEARCH";
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // dateFrom
            // 
            this.dateFrom.EditValue = null;
            this.dateFrom.Location = new System.Drawing.Point(523, 12);
            this.dateFrom.Name = "dateFrom";
            this.dateFrom.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateFrom.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateFrom.Size = new System.Drawing.Size(324, 20);
            this.dateFrom.StyleController = this.xLayoutControl1;
            this.dateFrom.TabIndex = 7;
            // 
            // dateTo
            // 
            this.dateTo.EditValue = null;
            this.dateTo.Location = new System.Drawing.Point(952, 12);
            this.dateTo.Name = "dateTo";
            this.dateTo.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateTo.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateTo.Size = new System.Drawing.Size(304, 20);
            this.dateTo.StyleController = this.xLayoutControl1;
            this.dateTo.TabIndex = 6;
            // 
            // stlSparepart
            // 
            this.stlSparepart.EditValue = "";
            this.stlSparepart.Location = new System.Drawing.Point(113, 12);
            this.stlSparepart.Name = "stlSparepart";
            this.stlSparepart.Properties.Appearance.Options.UseTextOptions = true;
            this.stlSparepart.Properties.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.stlSparepart.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.stlSparepart.Properties.ImmediatePopup = true;
            this.stlSparepart.Properties.NullText = "";
            this.stlSparepart.Properties.PopupView = this.aceGridLookUpEdit1View;
            this.stlSparepart.Size = new System.Drawing.Size(305, 20);
            this.stlSparepart.StyleController = this.xLayoutControl1;
            this.stlSparepart.TabIndex = 5;
            // 
            // aceGridLookUpEdit1View
            // 
            this.aceGridLookUpEdit1View.FocusRectStyle = DevExpress.XtraGrid.Views.Grid.DrawFocusRectStyle.RowFocus;
            this.aceGridLookUpEdit1View.Name = "aceGridLookUpEdit1View";
            this.aceGridLookUpEdit1View.OptionsSelection.EnableAppearanceFocusedCell = false;
            this.aceGridLookUpEdit1View.OptionsView.ShowAutoFilterRow = true;
            this.aceGridLookUpEdit1View.OptionsView.ShowGroupPanel = false;
            // 
            // gcList
            // 
            this.gcList.Location = new System.Drawing.Point(12, 38);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.Size = new System.Drawing.Size(1403, 741);
            this.gcList.TabIndex = 4;
            this.gcList.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvList});
            // 
            // gvList
            // 
            this.gvList.GridControl = this.gcList;
            this.gvList.Name = "gvList";
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.layoutControlItem3,
            this.layoutControlItem2,
            this.layoutControlItem4,
            this.layoutControlItem5});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1427, 791);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcList;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 26);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1407, 745);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.dateTo;
            this.layoutControlItem3.Location = new System.Drawing.Point(839, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(409, 26);
            this.layoutControlItem3.Text = "TO_TIME";
            this.layoutControlItem3.TextSize = new System.Drawing.Size(98, 13);
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.stlSparepart;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(410, 26);
            this.layoutControlItem2.Text = "SPARE_PART_CODE";
            this.layoutControlItem2.TextSize = new System.Drawing.Size(98, 13);
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.dateFrom;
            this.layoutControlItem4.Location = new System.Drawing.Point(410, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(429, 26);
            this.layoutControlItem4.Text = "FROM_TIME";
            this.layoutControlItem4.TextSize = new System.Drawing.Size(98, 13);
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.btnSearch;
            this.layoutControlItem5.Location = new System.Drawing.Point(1248, 0);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(159, 26);
            this.layoutControlItem5.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem5.TextVisible = false;
            // 
            // HISTORY_GOOD_RE_ISS
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1431, 816);
            this.Controls.Add(this.groupControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("HISTORY_GOOD_RE_ISS.IconOptions.Icon")));
            this.Name = "HISTORY_GOOD_RE_ISS";
            this.Text = "HISTORY_GOOD_RE_ISS";
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dateFrom.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateFrom.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateTo.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateTo.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.stlSparepart.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private XGridControl gcList;
        private XGridView gvList;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private AceGridLookUpEdit stlSparepart;
        private DevExpress.XtraGrid.Views.Grid.GridView aceGridLookUpEdit1View;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraEditors.DateEdit dateFrom;
        private DevExpress.XtraEditors.DateEdit dateTo;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private DevExpress.XtraEditors.SimpleButton btnSearch;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
    }
}