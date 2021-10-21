
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class EXPORT_EXCEL
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(EXPORT_EXCEL));
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnReport = new Wisol.XSimpleButton(this.components);
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.splashScreenManager1 = new DevExpress.XtraSplashScreen.SplashScreenManager(this, typeof(global::Wisol.MES.FrmWaitForm), true, true);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            this.SuspendLayout();
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnReport);
            this.xLayoutControl1.Controls.Add(this.groupControl1);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(0, 0);
            this.xLayoutControl1.Margin = new System.Windows.Forms.Padding(2);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1048, 449);
            this.xLayoutControl1.TabIndex = 4;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnReport
            // 
            this.btnReport.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnReport.FormId = null;
            this.btnReport.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnReport.ImageOptions.Image")));
            this.btnReport.isFormType = false;
            this.btnReport.Location = new System.Drawing.Point(907, 12);
            this.btnReport.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnReport.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnReport.Name = "btnReport";
            this.btnReport.Size = new System.Drawing.Size(129, 30);
            this.btnReport.StyleController = this.xLayoutControl1;
            this.btnReport.TabIndex = 5;
            this.btnReport.Text = "Create Report";
            this.btnReport.Click += new System.EventHandler(this.btnReport_Click);
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.gcList);
            this.groupControl1.Location = new System.Drawing.Point(12, 46);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1024, 391);
            this.groupControl1.TabIndex = 4;
            this.groupControl1.Text = "BÁO CÁO";
            // 
            // gcList
            // 
            this.gcList.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gcList.Location = new System.Drawing.Point(2, 23);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.Size = new System.Drawing.Size(1020, 366);
            this.gcList.TabIndex = 0;
            this.gcList.UseEmbeddedNavigator = true;
            this.gcList.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvList});
            // 
            // gvList
            // 
            this.gvList.GridControl = this.gcList;
            this.gvList.Name = "gvList";
            this.gvList.CellMerge += new DevExpress.XtraGrid.Views.Grid.CellMergeEventHandler(this.gvList_CellMerge);
            this.gvList.CustomDrawColumnHeader += new DevExpress.XtraGrid.Views.Grid.ColumnHeaderCustomDrawEventHandler(this.gvList_CustomDrawColumnHeader);
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.layoutControlItem2});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1048, 449);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.groupControl1;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1028, 395);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.ContentHorzAlignment = DevExpress.Utils.HorzAlignment.Far;
            this.layoutControlItem2.Control = this.btnReport;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(1028, 34);
            this.layoutControlItem2.TextAlignMode = DevExpress.XtraLayout.TextAlignModeItem.AutoSize;
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextToControlDistance = 0;
            this.layoutControlItem2.TextVisible = false;
            // 
            // splashScreenManager1
            // 
            this.splashScreenManager1.ClosingDelay = 500;
            // 
            // EXPORT_EXCEL
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1048, 449);
            this.Controls.Add(this.xLayoutControl1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("EXPORT_EXCEL.IconOptions.Icon")));
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "EXPORT_EXCEL";
            this.Text = "EXPORT_EXCEL";
            this.Load += new System.EventHandler(this.EXPORT_EXCEL_Load);
            this.Controls.SetChildIndex(this.xLayoutControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraEditors.GroupControl groupControl1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private XGridControl gcList;
        private XGridView gvList;
        private XSimpleButton btnReport;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraSplashScreen.SplashScreenManager splashScreenManager1;
    }
}