
namespace Wisol.MES.Forms.CONTENT
{
    partial class GOC_PLANT
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(GOC_PLANT));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnSearch = new Wisol.XSimpleButton(this.components);
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.labelControl2 = new DevExpress.XtraEditors.LabelControl();
            this.dateSearch = new DevExpress.XtraEditors.DateEdit();
            this.btnImport = new Wisol.XSimpleButton(this.components);
            this.btnGetFileTemp = new Wisol.XSimpleButton(this.components);
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dateSearch.Properties.CalendarTimeProperties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateSearch.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
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
            this.groupControl1.Size = new System.Drawing.Size(1480, 856);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "GOC PLANT";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnSearch);
            this.xLayoutControl1.Controls.Add(this.panelControl1);
            this.xLayoutControl1.Controls.Add(this.btnImport);
            this.xLayoutControl1.Controls.Add(this.btnGetFileTemp);
            this.xLayoutControl1.Controls.Add(this.gcList);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1476, 831);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnSearch
            // 
            this.btnSearch.FormId = null;
            this.btnSearch.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnSearch.ImageOptions.Image")));
            this.btnSearch.isFormType = false;
            this.btnSearch.Location = new System.Drawing.Point(278, 12);
            this.btnSearch.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnSearch.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(129, 30);
            this.btnSearch.StyleController = this.xLayoutControl1;
            this.btnSearch.TabIndex = 8;
            this.btnSearch.Text = "SEARCH";
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.labelControl2);
            this.panelControl1.Controls.Add(this.dateSearch);
            this.panelControl1.Location = new System.Drawing.Point(411, 12);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(1053, 30);
            this.panelControl1.TabIndex = 7;
            // 
            // labelControl2
            // 
            this.labelControl2.Location = new System.Drawing.Point(5, 8);
            this.labelControl2.Name = "labelControl2";
            this.labelControl2.Size = new System.Drawing.Size(72, 13);
            this.labelControl2.TabIndex = 3;
            this.labelControl2.Text = "Tìm theo tháng";
            // 
            // dateSearch
            // 
            this.dateSearch.EditValue = null;
            this.dateSearch.Location = new System.Drawing.Point(83, 5);
            this.dateSearch.Name = "dateSearch";
            this.dateSearch.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateSearch.Properties.CalendarTimeProperties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.dateSearch.Properties.VistaCalendarInitialViewStyle = DevExpress.XtraEditors.VistaCalendarInitialViewStyle.YearView;
            this.dateSearch.Size = new System.Drawing.Size(183, 20);
            this.dateSearch.TabIndex = 2;
            // 
            // btnImport
            // 
            this.btnImport.FormId = null;
            this.btnImport.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnImport.ImageOptions.Image")));
            this.btnImport.isFormType = false;
            this.btnImport.Location = new System.Drawing.Point(12, 12);
            this.btnImport.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnImport.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(129, 30);
            this.btnImport.StyleController = this.xLayoutControl1;
            this.btnImport.TabIndex = 6;
            this.btnImport.Text = "IMPORT DATA";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // btnGetFileTemp
            // 
            this.btnGetFileTemp.FormId = null;
            this.btnGetFileTemp.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnGetFileTemp.ImageOptions.Image")));
            this.btnGetFileTemp.isFormType = false;
            this.btnGetFileTemp.Location = new System.Drawing.Point(145, 12);
            this.btnGetFileTemp.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnGetFileTemp.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnGetFileTemp.Name = "btnGetFileTemp";
            this.btnGetFileTemp.Size = new System.Drawing.Size(129, 30);
            this.btnGetFileTemp.StyleController = this.xLayoutControl1;
            this.btnGetFileTemp.TabIndex = 5;
            this.btnGetFileTemp.Text = "Get file template";
            this.btnGetFileTemp.Click += new System.EventHandler(this.btnGetFileTemp_Click);
            // 
            // gcList
            // 
            this.gcList.Location = new System.Drawing.Point(12, 46);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.Size = new System.Drawing.Size(1452, 773);
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
            this.layoutControlItem2,
            this.layoutControlItem3,
            this.layoutControlItem4,
            this.layoutControlItem5});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1476, 831);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcList;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1456, 777);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.btnGetFileTemp;
            this.layoutControlItem2.Location = new System.Drawing.Point(133, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.btnImport;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.panelControl1;
            this.layoutControlItem4.Location = new System.Drawing.Point(399, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(1057, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.btnSearch;
            this.layoutControlItem5.Location = new System.Drawing.Point(266, 0);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem5.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem5.TextVisible = false;
            // 
            // GOC_PLANT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupControl1);
            this.Name = "GOC_PLANT";
            this.Size = new System.Drawing.Size(1480, 856);
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.panelControl1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dateSearch.Properties.CalendarTimeProperties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dateSearch.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private XSimpleButton btnImport;
        private XSimpleButton btnGetFileTemp;
        private XGridControl gcList;
        private XGridView gvList;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private DevExpress.XtraEditors.LabelControl labelControl2;
        private DevExpress.XtraEditors.DateEdit dateSearch;
        private XSimpleButton btnSearch;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
    }
}