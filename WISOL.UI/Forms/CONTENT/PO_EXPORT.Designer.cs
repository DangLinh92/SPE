﻿
namespace Wisol.MES.Forms.CONTENT
{
    partial class PO_EXPORT
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PO_EXPORT));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.txtTitle = new Wisol.XTextEdit();
            this.btnLoadFile = new Wisol.XSimpleButton(this.components);
            this.stackPanel1 = new DevExpress.Utils.Layout.StackPanel();
            this.cboCurrentce = new DevExpress.XtraEditors.CheckedComboBoxEdit();
            this.label1 = new System.Windows.Forms.Label();
            this.txtPO_Example = new Wisol.XTextEdit();
            this.txtPO_ID = new Wisol.XTextEdit();
            this.lblPO = new System.Windows.Forms.Label();
            this.btnAddSapPO = new DevExpress.XtraEditors.SimpleButton();
            this.btnMerge = new DevExpress.XtraEditors.SimpleButton();
            this.btnSave = new DevExpress.XtraEditors.SimpleButton();
            this.btnCreateExcel = new Wisol.XSimpleButton(this.components);
            this.spreadsheet_PO = new DevExpress.XtraSpreadsheet.SpreadsheetControl();
            this.splitterControl1 = new DevExpress.XtraEditors.SplitterControl();
            this.splitterControl2 = new DevExpress.XtraEditors.SplitterControl();
            this.spreadsheetFormulaBar1 = new DevExpress.XtraSpreadsheet.SpreadsheetFormulaBar();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtTitle.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.stackPanel1)).BeginInit();
            this.stackPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cboCurrentce.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPO_Example.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPO_ID.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1722, 862);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "PO FILE";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.txtTitle);
            this.xLayoutControl1.Controls.Add(this.btnLoadFile);
            this.xLayoutControl1.Controls.Add(this.stackPanel1);
            this.xLayoutControl1.Controls.Add(this.btnCreateExcel);
            this.xLayoutControl1.Controls.Add(this.spreadsheet_PO);
            this.xLayoutControl1.Controls.Add(this.splitterControl1);
            this.xLayoutControl1.Controls.Add(this.splitterControl2);
            this.xLayoutControl1.Controls.Add(this.spreadsheetFormulaBar1);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1718, 837);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // txtTitle
            // 
            this.txtTitle.IsRequire = false;
            this.txtTitle.Location = new System.Drawing.Point(51, 46);
            this.txtTitle.Name = "txtTitle";
            this.txtTitle.NullBackColor = System.Drawing.Color.Lime;
            this.txtTitle.NullValidation = false;
            this.txtTitle.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtTitle.Properties.Appearance.Options.UseBackColor = true;
            this.txtTitle.Size = new System.Drawing.Size(1655, 20);
            this.txtTitle.StyleController = this.xLayoutControl1;
            this.txtTitle.TabIndex = 15;
            // 
            // btnLoadFile
            // 
            this.btnLoadFile.FormId = null;
            this.btnLoadFile.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnLoadFile.ImageOptions.Image")));
            this.btnLoadFile.isFormType = false;
            this.btnLoadFile.Location = new System.Drawing.Point(1444, 12);
            this.btnLoadFile.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnLoadFile.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnLoadFile.Name = "btnLoadFile";
            this.btnLoadFile.Size = new System.Drawing.Size(129, 30);
            this.btnLoadFile.StyleController = this.xLayoutControl1;
            this.btnLoadFile.TabIndex = 11;
            this.btnLoadFile.Text = "Hiển thị dữ liệu";
            this.btnLoadFile.Click += new System.EventHandler(this.btnLoadFile_Click);
            // 
            // stackPanel1
            // 
            this.stackPanel1.Controls.Add(this.cboCurrentce);
            this.stackPanel1.Controls.Add(this.label1);
            this.stackPanel1.Controls.Add(this.txtPO_Example);
            this.stackPanel1.Controls.Add(this.txtPO_ID);
            this.stackPanel1.Controls.Add(this.lblPO);
            this.stackPanel1.Controls.Add(this.btnAddSapPO);
            this.stackPanel1.Controls.Add(this.btnMerge);
            this.stackPanel1.Controls.Add(this.btnSave);
            this.stackPanel1.LayoutDirection = DevExpress.Utils.Layout.StackPanelLayoutDirection.RightToLeft;
            this.stackPanel1.Location = new System.Drawing.Point(12, 12);
            this.stackPanel1.Name = "stackPanel1";
            this.stackPanel1.Size = new System.Drawing.Size(1428, 30);
            this.stackPanel1.TabIndex = 10;
            // 
            // cboCurrentce
            // 
            this.cboCurrentce.EditValue = "";
            this.cboCurrentce.Location = new System.Drawing.Point(1325, 5);
            this.cboCurrentce.Name = "cboCurrentce";
            this.cboCurrentce.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.cboCurrentce.Properties.Items.AddRange(new DevExpress.XtraEditors.Controls.CheckedListBoxItem[] {
            new DevExpress.XtraEditors.Controls.CheckedListBoxItem("USD"),
            new DevExpress.XtraEditors.Controls.CheckedListBoxItem("VND")});
            this.cboCurrentce.Size = new System.Drawing.Size(100, 20);
            this.cboCurrentce.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(1146, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(173, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "Đơn vị tiền tệ hiển thị trong file PO";
            // 
            // txtPO_Example
            // 
            this.txtPO_Example.Enabled = false;
            this.txtPO_Example.IsRequire = false;
            this.txtPO_Example.Location = new System.Drawing.Point(925, 5);
            this.txtPO_Example.Name = "txtPO_Example";
            this.txtPO_Example.NullBackColor = System.Drawing.Color.Lime;
            this.txtPO_Example.NullValidation = false;
            this.txtPO_Example.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtPO_Example.Properties.Appearance.Options.UseBackColor = true;
            this.txtPO_Example.Size = new System.Drawing.Size(215, 20);
            this.txtPO_Example.TabIndex = 5;
            this.txtPO_Example.Visible = false;
            // 
            // txtPO_ID
            // 
            this.txtPO_ID.Enabled = false;
            this.txtPO_ID.IsRequire = false;
            this.txtPO_ID.Location = new System.Drawing.Point(713, 5);
            this.txtPO_ID.Name = "txtPO_ID";
            this.txtPO_ID.NullBackColor = System.Drawing.Color.Lime;
            this.txtPO_ID.NullValidation = false;
            this.txtPO_ID.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtPO_ID.Properties.Appearance.Options.UseBackColor = true;
            this.txtPO_ID.Size = new System.Drawing.Size(206, 20);
            this.txtPO_ID.TabIndex = 0;
            // 
            // lblPO
            // 
            this.lblPO.AutoSize = true;
            this.lblPO.Location = new System.Drawing.Point(646, 8);
            this.lblPO.Name = "lblPO";
            this.lblPO.Size = new System.Drawing.Size(61, 13);
            this.lblPO.TabIndex = 1;
            this.lblPO.Text = "PO Number";
            // 
            // btnAddSapPO
            // 
            this.btnAddSapPO.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnAddSapPO.ImageOptions.Image")));
            this.btnAddSapPO.Location = new System.Drawing.Point(543, 3);
            this.btnAddSapPO.Name = "btnAddSapPO";
            this.btnAddSapPO.Size = new System.Drawing.Size(97, 23);
            this.btnAddSapPO.TabIndex = 10;
            this.btnAddSapPO.Text = "Lưu SAP PO";
            this.btnAddSapPO.Click += new System.EventHandler(this.btnAddSapPO_Click);
            // 
            // btnMerge
            // 
            this.btnMerge.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnMerge.ImageOptions.Image")));
            this.btnMerge.Location = new System.Drawing.Point(452, 3);
            this.btnMerge.Name = "btnMerge";
            this.btnMerge.Size = new System.Drawing.Size(85, 23);
            this.btnMerge.TabIndex = 9;
            this.btnMerge.Text = "Merge code";
            this.btnMerge.Click += new System.EventHandler(this.btnMerge_Click);
            // 
            // btnSave
            // 
            this.btnSave.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.ImageOptions.Image")));
            this.btnSave.Location = new System.Drawing.Point(307, 3);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(139, 23);
            this.btnSave.TabIndex = 8;
            this.btnSave.Text = "Xác nhận hoàn thành";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnCreateExcel
            // 
            this.btnCreateExcel.FormId = null;
            this.btnCreateExcel.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCreateExcel.ImageOptions.Image")));
            this.btnCreateExcel.isFormType = false;
            this.btnCreateExcel.Location = new System.Drawing.Point(1577, 12);
            this.btnCreateExcel.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCreateExcel.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCreateExcel.Name = "btnCreateExcel";
            this.btnCreateExcel.Size = new System.Drawing.Size(129, 30);
            this.btnCreateExcel.StyleController = this.xLayoutControl1;
            this.btnCreateExcel.TabIndex = 7;
            this.btnCreateExcel.Text = "Tạo File PO";
            this.btnCreateExcel.Click += new System.EventHandler(this.btnCreateExcel_Click);
            // 
            // spreadsheet_PO
            // 
            this.spreadsheet_PO.Location = new System.Drawing.Point(12, 98);
            this.spreadsheet_PO.Name = "spreadsheet_PO";
            this.spreadsheet_PO.Options.Culture = new System.Globalization.CultureInfo("en-US");
            this.spreadsheet_PO.Size = new System.Drawing.Size(1694, 727);
            this.spreadsheet_PO.TabIndex = 5;
            this.spreadsheet_PO.Text = "spreadsheetControl1";
            // 
            // splitterControl1
            // 
            this.splitterControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.splitterControl1.Location = new System.Drawing.Point(0, 0);
            this.splitterControl1.MinSize = 20;
            this.splitterControl1.Name = "splitterControl1";
            this.splitterControl1.Size = new System.Drawing.Size(10, 10);
            this.splitterControl1.TabIndex = 12;
            this.splitterControl1.TabStop = false;
            // 
            // splitterControl2
            // 
            this.splitterControl2.Dock = System.Windows.Forms.DockStyle.Top;
            this.splitterControl2.Location = new System.Drawing.Point(0, 0);
            this.splitterControl2.MinSize = 20;
            this.splitterControl2.Name = "splitterControl2";
            this.splitterControl2.Size = new System.Drawing.Size(10, 10);
            this.splitterControl2.TabIndex = 13;
            this.splitterControl2.TabStop = false;
            // 
            // spreadsheetFormulaBar1
            // 
            this.spreadsheetFormulaBar1.Location = new System.Drawing.Point(12, 70);
            this.spreadsheetFormulaBar1.MinimumSize = new System.Drawing.Size(0, 24);
            this.spreadsheetFormulaBar1.Name = "spreadsheetFormulaBar1";
            this.spreadsheetFormulaBar1.Size = new System.Drawing.Size(1694, 24);
            this.spreadsheetFormulaBar1.SpreadsheetControl = this.spreadsheet_PO;
            this.spreadsheetFormulaBar1.TabIndex = 14;
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem2,
            this.layoutControlItem1,
            this.layoutControlItem4,
            this.layoutControlItem6,
            this.layoutControlItem3,
            this.layoutControlItem5});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1718, 837);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.spreadsheet_PO;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 86);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(1698, 731);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.btnCreateExcel;
            this.layoutControlItem1.Location = new System.Drawing.Point(1565, 0);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.stackPanel1;
            this.layoutControlItem4.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(1432, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.btnLoadFile;
            this.layoutControlItem6.Location = new System.Drawing.Point(1432, 0);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem6.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem6.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.spreadsheetFormulaBar1;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 58);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(1698, 28);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.txtTitle;
            this.layoutControlItem5.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(1698, 24);
            this.layoutControlItem5.Text = "TITLE";
            this.layoutControlItem5.TextSize = new System.Drawing.Size(27, 13);
            // 
            // PO_EXPORT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupControl1);
            this.Name = "PO_EXPORT";
            this.Size = new System.Drawing.Size(1722, 862);
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.txtTitle.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.stackPanel1)).EndInit();
            this.stackPanel1.ResumeLayout(false);
            this.stackPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cboCurrentce.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPO_Example.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPO_ID.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraSpreadsheet.SpreadsheetControl spreadsheet_PO;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private XSimpleButton btnCreateExcel;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.Utils.Layout.StackPanel stackPanel1;
        private XTextEdit txtPO_ID;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private System.Windows.Forms.Label lblPO;
        private XSimpleButton btnLoadFile;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
        private DevExpress.XtraEditors.CheckedComboBoxEdit cboCurrentce;
        private DevExpress.XtraEditors.SplitterControl splitterControl1;
        private DevExpress.XtraEditors.SplitterControl splitterControl2;
        private DevExpress.XtraSpreadsheet.SpreadsheetFormulaBar spreadsheetFormulaBar1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private System.Windows.Forms.Label label1;
        private XTextEdit txtPO_Example;
        private DevExpress.XtraEditors.SimpleButton btnSave;
        private XTextEdit txtTitle;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
        private DevExpress.XtraEditors.SimpleButton btnMerge;
        private DevExpress.XtraEditors.SimpleButton btnAddSapPO;
    }
}