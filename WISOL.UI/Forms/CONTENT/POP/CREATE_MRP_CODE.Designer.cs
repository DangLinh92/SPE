
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class CREATE_MRP_CODE
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CREATE_MRP_CODE));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnGencode = new DevExpress.XtraEditors.SimpleButton();
            this.txtTitle = new Wisol.XTextEdit();
            this.txtMrpCode = new Wisol.XTextEdit();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.emptySpaceItem1 = new DevExpress.XtraLayout.EmptySpaceItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.btnSave = new Wisol.XSimpleButton(this.components);
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtTitle.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMrpCode.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.emptySpaceItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(434, 158);
            this.groupControl1.TabIndex = 4;
            this.groupControl1.Text = "Tạo mã MRP";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnSave);
            this.xLayoutControl1.Controls.Add(this.btnGencode);
            this.xLayoutControl1.Controls.Add(this.txtTitle);
            this.xLayoutControl1.Controls.Add(this.txtMrpCode);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(430, 133);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnGencode
            // 
            this.btnGencode.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnGencode.ImageOptions.Image")));
            this.btnGencode.Location = new System.Drawing.Point(273, 12);
            this.btnGencode.Name = "btnGencode";
            this.btnGencode.Size = new System.Drawing.Size(145, 22);
            this.btnGencode.StyleController = this.xLayoutControl1;
            this.btnGencode.TabIndex = 6;
            this.btnGencode.Text = "Tạo mã MRP";
            this.btnGencode.Click += new System.EventHandler(this.btnGencode_Click);
            // 
            // txtTitle
            // 
            this.txtTitle.IsRequire = false;
            this.txtTitle.Location = new System.Drawing.Point(53, 38);
            this.txtTitle.Name = "txtTitle";
            this.txtTitle.NullBackColor = System.Drawing.Color.Lime;
            this.txtTitle.NullValidation = false;
            this.txtTitle.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtTitle.Properties.Appearance.Options.UseBackColor = true;
            this.txtTitle.Size = new System.Drawing.Size(365, 20);
            this.txtTitle.StyleController = this.xLayoutControl1;
            this.txtTitle.TabIndex = 5;
            // 
            // txtMrpCode
            // 
            this.txtMrpCode.Enabled = false;
            this.txtMrpCode.IsRequire = false;
            this.txtMrpCode.Location = new System.Drawing.Point(53, 12);
            this.txtMrpCode.Name = "txtMrpCode";
            this.txtMrpCode.NullBackColor = System.Drawing.Color.Lime;
            this.txtMrpCode.NullValidation = false;
            this.txtMrpCode.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtMrpCode.Properties.Appearance.Options.UseBackColor = true;
            this.txtMrpCode.Size = new System.Drawing.Size(216, 20);
            this.txtMrpCode.StyleController = this.xLayoutControl1;
            this.txtMrpCode.TabIndex = 4;
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.emptySpaceItem1,
            this.layoutControlItem2,
            this.layoutControlItem3,
            this.layoutControlItem4});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(430, 133);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.txtMrpCode;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(261, 26);
            this.layoutControlItem1.Text = "Mã MRP";
            this.layoutControlItem1.TextSize = new System.Drawing.Size(38, 13);
            // 
            // emptySpaceItem1
            // 
            this.emptySpaceItem1.AllowHotTrack = false;
            this.emptySpaceItem1.Location = new System.Drawing.Point(0, 84);
            this.emptySpaceItem1.Name = "emptySpaceItem1";
            this.emptySpaceItem1.Size = new System.Drawing.Size(410, 29);
            this.emptySpaceItem1.TextSize = new System.Drawing.Size(0, 0);
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.txtTitle;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 26);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(410, 24);
            this.layoutControlItem2.Text = "TITLE";
            this.layoutControlItem2.TextSize = new System.Drawing.Size(38, 13);
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.btnGencode;
            this.layoutControlItem3.Location = new System.Drawing.Point(261, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(149, 26);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // btnSave
            // 
            this.btnSave.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.ImageOptions.Image")));
            this.btnSave.Location = new System.Drawing.Point(289, 62);
            this.btnSave.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnSave.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnSave.Name = "btnSave";
            this.btnSave.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnSave.Size = new System.Drawing.Size(129, 30);
            this.btnSave.StyleController = this.xLayoutControl1;
            this.btnSave.TabIndex = 7;
            this.btnSave.Text = "SAVE";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.ContentHorzAlignment = DevExpress.Utils.HorzAlignment.Far;
            this.layoutControlItem4.Control = this.btnSave;
            this.layoutControlItem4.Location = new System.Drawing.Point(0, 50);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(410, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // CREATE_MRP_CODE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(434, 158);
            this.Controls.Add(this.groupControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("CREATE_MRP_CODE.IconOptions.Icon")));
            this.Name = "CREATE_MRP_CODE";
            this.Text = "CREATE_MRP_CODE";
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.txtTitle.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtMrpCode.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.emptySpaceItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private XTextEdit txtMrpCode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.EmptySpaceItem emptySpaceItem1;
        private XTextEdit txtTitle;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraEditors.SimpleButton btnGencode;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private XSimpleButton btnSave;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
    }
}