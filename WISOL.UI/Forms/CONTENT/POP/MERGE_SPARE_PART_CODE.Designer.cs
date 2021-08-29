
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class MERGE_SPARE_PART_CODE
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MERGE_SPARE_PART_CODE));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.txtNewCode = new Wisol.XTextEdit();
            this.btnCreateCode = new Wisol.XSimpleButton(this.components);
            this.btnClear = new DevExpress.XtraEditors.SimpleButton();
            this.btnMergeCode = new Wisol.XSimpleButton(this.components);
            this.btnCancelMerge = new Wisol.XSimpleButton(this.components);
            this.lstCode = new DevExpress.XtraEditors.ListBoxControl();
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem7 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtNewCode.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lstCode)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1018, 561);
            this.groupControl1.TabIndex = 4;
            this.groupControl1.Text = "Tạo code PO cho thiết bị";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.panelControl1);
            this.xLayoutControl1.Controls.Add(this.btnCreateCode);
            this.xLayoutControl1.Controls.Add(this.btnClear);
            this.xLayoutControl1.Controls.Add(this.btnMergeCode);
            this.xLayoutControl1.Controls.Add(this.btnCancelMerge);
            this.xLayoutControl1.Controls.Add(this.lstCode);
            this.xLayoutControl1.Controls.Add(this.gcList);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1014, 536);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.txtNewCode);
            this.panelControl1.Location = new System.Drawing.Point(411, 12);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(591, 30);
            this.panelControl1.TabIndex = 11;
            // 
            // txtNewCode
            // 
            this.txtNewCode.IsRequire = false;
            this.txtNewCode.Location = new System.Drawing.Point(5, 5);
            this.txtNewCode.Name = "txtNewCode";
            this.txtNewCode.NullBackColor = System.Drawing.Color.Lime;
            this.txtNewCode.NullValidation = false;
            this.txtNewCode.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtNewCode.Properties.Appearance.Options.UseBackColor = true;
            this.txtNewCode.Size = new System.Drawing.Size(190, 20);
            this.txtNewCode.TabIndex = 0;
            // 
            // btnCreateCode
            // 
            this.btnCreateCode.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCreateCode.ImageOptions.Image")));
            this.btnCreateCode.Location = new System.Drawing.Point(278, 12);
            this.btnCreateCode.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCreateCode.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCreateCode.Name = "btnCreateCode";
            this.btnCreateCode.Size = new System.Drawing.Size(129, 30);
            this.btnCreateCode.StyleController = this.xLayoutControl1;
            this.btnCreateCode.TabIndex = 10;
            this.btnCreateCode.Text = "Tạo code mới";
            this.btnCreateCode.Click += new System.EventHandler(this.btnCreateCode_Click);
            // 
            // btnClear
            // 
            this.btnClear.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnClear.ImageOptions.Image")));
            this.btnClear.Location = new System.Drawing.Point(806, 46);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(196, 22);
            this.btnClear.StyleController = this.xLayoutControl1;
            this.btnClear.TabIndex = 8;
            this.btnClear.Text = "CLEAR";
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnMergeCode
            // 
            this.btnMergeCode.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnMergeCode.ImageOptions.Image")));
            this.btnMergeCode.Location = new System.Drawing.Point(12, 12);
            this.btnMergeCode.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnMergeCode.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnMergeCode.Name = "btnMergeCode";
            this.btnMergeCode.Size = new System.Drawing.Size(129, 30);
            this.btnMergeCode.StyleController = this.xLayoutControl1;
            this.btnMergeCode.TabIndex = 7;
            this.btnMergeCode.Text = "MERGE CODE";
            this.btnMergeCode.Click += new System.EventHandler(this.btnMergeCode_Click);
            // 
            // btnCancelMerge
            // 
            this.btnCancelMerge.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCancelMerge.ImageOptions.Image")));
            this.btnCancelMerge.Location = new System.Drawing.Point(145, 12);
            this.btnCancelMerge.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCancelMerge.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCancelMerge.Name = "btnCancelMerge";
            this.btnCancelMerge.Size = new System.Drawing.Size(129, 30);
            this.btnCancelMerge.StyleController = this.xLayoutControl1;
            this.btnCancelMerge.TabIndex = 6;
            this.btnCancelMerge.Text = "CANCEL MERGE";
            this.btnCancelMerge.Click += new System.EventHandler(this.btnCancelMerge_Click);
            // 
            // lstCode
            // 
            this.lstCode.Location = new System.Drawing.Point(806, 72);
            this.lstCode.Name = "lstCode";
            this.lstCode.Size = new System.Drawing.Size(196, 452);
            this.lstCode.StyleController = this.xLayoutControl1;
            this.lstCode.TabIndex = 5;
            // 
            // gcList
            // 
            this.gcList.Location = new System.Drawing.Point(12, 46);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.Size = new System.Drawing.Size(790, 478);
            this.gcList.TabIndex = 4;
            this.gcList.UseEmbeddedNavigator = true;
            this.gcList.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvList});
            // 
            // gvList
            // 
            this.gvList.GridControl = this.gcList;
            this.gvList.Name = "gvList";
            this.gvList.OptionsSelection.MultiSelect = true;
            this.gvList.OptionsSelection.MultiSelectMode = DevExpress.XtraGrid.Views.Grid.GridMultiSelectMode.CheckBoxRowSelect;
            this.gvList.OptionsSelection.ResetSelectionClickOutsideCheckboxSelector = true;
            this.gvList.OptionsSelection.ShowCheckBoxSelectorInColumnHeader = DevExpress.Utils.DefaultBoolean.True;
            this.gvList.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvList_RowCellClick);
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
            this.layoutControlItem5,
            this.layoutControlItem7,
            this.layoutControlItem6});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1014, 536);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcList;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(794, 482);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.lstCode;
            this.layoutControlItem2.Location = new System.Drawing.Point(794, 60);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(200, 456);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.btnCancelMerge;
            this.layoutControlItem3.Location = new System.Drawing.Point(133, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.btnMergeCode;
            this.layoutControlItem4.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.btnClear;
            this.layoutControlItem5.Location = new System.Drawing.Point(794, 34);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(200, 26);
            this.layoutControlItem5.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem5.TextVisible = false;
            // 
            // layoutControlItem7
            // 
            this.layoutControlItem7.Control = this.btnCreateCode;
            this.layoutControlItem7.Location = new System.Drawing.Point(266, 0);
            this.layoutControlItem7.Name = "layoutControlItem7";
            this.layoutControlItem7.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem7.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem7.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.panelControl1;
            this.layoutControlItem6.Location = new System.Drawing.Point(399, 0);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(595, 34);
            this.layoutControlItem6.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem6.TextVisible = false;
            // 
            // MERGE_SPARE_PART_CODE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1018, 561);
            this.Controls.Add(this.groupControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("MERGE_SPARE_PART_CODE.IconOptions.Icon")));
            this.Name = "MERGE_SPARE_PART_CODE";
            this.Text = "MERGE_SPARE_PART_CODE";
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.txtNewCode.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lstCode)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
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
        private XSimpleButton btnCancelMerge;
        private DevExpress.XtraEditors.ListBoxControl lstCode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private XSimpleButton btnMergeCode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private DevExpress.XtraEditors.SimpleButton btnClear;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
        private XSimpleButton btnCreateCode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem7;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private XTextEdit txtNewCode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
    }
}