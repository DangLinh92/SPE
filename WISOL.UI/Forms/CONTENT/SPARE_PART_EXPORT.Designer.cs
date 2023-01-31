
namespace Wisol.MES.Forms.CONTENT
{
    partial class SPARE_PART_EXPORT
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SPARE_PART_EXPORT));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnExport = new Wisol.XSimpleButton(this.components);
            this.spreadsheetFormulaBar1 = new DevExpress.XtraSpreadsheet.SpreadsheetFormulaBar();
            this.speadSheetsControl = new DevExpress.XtraSpreadsheet.SpreadsheetControl();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1819, 857);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "Sparepart Data";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnExport);
            this.xLayoutControl1.Controls.Add(this.spreadsheetFormulaBar1);
            this.xLayoutControl1.Controls.Add(this.speadSheetsControl);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1815, 832);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnExport
            // 
            this.btnExport.FormId = null;
            this.btnExport.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnExport.ImageOptions.Image")));
            this.btnExport.isFormType = false;
            this.btnExport.Location = new System.Drawing.Point(1674, 12);
            this.btnExport.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnExport.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnExport.Name = "btnExport";
            this.btnExport.Size = new System.Drawing.Size(129, 30);
            this.btnExport.StyleController = this.xLayoutControl1;
            this.btnExport.TabIndex = 6;
            this.btnExport.Text = "Download Excel File";
            this.btnExport.Click += new System.EventHandler(this.btnExport_Click);
            // 
            // spreadsheetFormulaBar1
            // 
            this.spreadsheetFormulaBar1.Location = new System.Drawing.Point(12, 46);
            this.spreadsheetFormulaBar1.MinimumSize = new System.Drawing.Size(0, 24);
            this.spreadsheetFormulaBar1.Name = "spreadsheetFormulaBar1";
            this.spreadsheetFormulaBar1.Size = new System.Drawing.Size(1791, 24);
            this.spreadsheetFormulaBar1.TabIndex = 5;
            // 
            // speadSheetsControl
            // 
            this.speadSheetsControl.Location = new System.Drawing.Point(12, 74);
            this.speadSheetsControl.Name = "speadSheetsControl";
            this.speadSheetsControl.Size = new System.Drawing.Size(1791, 746);
            this.speadSheetsControl.TabIndex = 4;
            this.speadSheetsControl.Text = "spreadsheetControl1";
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.layoutControlItem2,
            this.layoutControlItem3});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1815, 832);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.speadSheetsControl;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 62);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1795, 750);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.spreadsheetFormulaBar1;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(1795, 28);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.ContentHorzAlignment = DevExpress.Utils.HorzAlignment.Far;
            this.layoutControlItem3.Control = this.btnExport;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(1795, 34);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // SPARE_PART_EXPORT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupControl1);
            this.Name = "SPARE_PART_EXPORT";
            this.Size = new System.Drawing.Size(1819, 857);
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraSpreadsheet.SpreadsheetFormulaBar spreadsheetFormulaBar1;
        private DevExpress.XtraSpreadsheet.SpreadsheetControl speadSheetsControl;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private XSimpleButton btnExport;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
    }
}