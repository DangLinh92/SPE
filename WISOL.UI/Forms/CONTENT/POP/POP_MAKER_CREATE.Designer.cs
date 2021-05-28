﻿
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class POP_MAKER_CREATE
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(POP_MAKER_CREATE));
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.btnCancel = new Wisol.XSimpleButton(this.components);
            this.btnSave = new Wisol.XSimpleButton(this.components);
            this.sltDepartment = new Wisol.AceGridLookUpEdit(this.components);
            this.aceGridLookUpEdit1View = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.txtPhone = new Wisol.XTextEdit();
            this.txtAddress = new Wisol.XTextEdit();
            this.txtName = new Wisol.XTextEdit();
            this.txtCode = new Wisol.XTextEdit();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.emptySpaceItem1 = new DevExpress.XtraLayout.EmptySpaceItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.lctDepartment = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem7 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.sltDepartment.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPhone.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAddress.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtName.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtCode.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.emptySpaceItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.lctDepartment)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            this.SuspendLayout();
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnCancel);
            this.xLayoutControl1.Controls.Add(this.btnSave);
            this.xLayoutControl1.Controls.Add(this.sltDepartment);
            this.xLayoutControl1.Controls.Add(this.txtPhone);
            this.xLayoutControl1.Controls.Add(this.txtAddress);
            this.xLayoutControl1.Controls.Add(this.txtName);
            this.xLayoutControl1.Controls.Add(this.txtCode);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(0, 0);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.OptionsCustomizationForm.DesignTimeCustomizationFormPositionAndSize = new System.Drawing.Rectangle(908, 51, 650, 400);
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(453, 179);
            this.xLayoutControl1.TabIndex = 4;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // btnCancel
            // 
            this.btnCancel.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCancel.ImageOptions.Image")));
            this.btnCancel.Location = new System.Drawing.Point(312, 132);
            this.btnCancel.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCancel.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(129, 30);
            this.btnCancel.StyleController = this.xLayoutControl1;
            this.btnCancel.TabIndex = 10;
            this.btnCancel.Text = "CANCEL";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnSave.ImageOptions.Image")));
            this.btnSave.Location = new System.Drawing.Point(179, 132);
            this.btnSave.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnSave.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(129, 30);
            this.btnSave.StyleController = this.xLayoutControl1;
            this.btnSave.TabIndex = 9;
            this.btnSave.Text = "SAVE";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // sltDepartment
            // 
            this.sltDepartment.EditValue = "";
            this.sltDepartment.Location = new System.Drawing.Point(81, 108);
            this.sltDepartment.Name = "sltDepartment";
            this.sltDepartment.Properties.Appearance.Options.UseTextOptions = true;
            this.sltDepartment.Properties.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.sltDepartment.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.sltDepartment.Properties.ImmediatePopup = true;
            this.sltDepartment.Properties.NullText = "";
            this.sltDepartment.Properties.PopupView = this.aceGridLookUpEdit1View;
            this.sltDepartment.Size = new System.Drawing.Size(360, 20);
            this.sltDepartment.StyleController = this.xLayoutControl1;
            this.sltDepartment.TabIndex = 8;
            // 
            // aceGridLookUpEdit1View
            // 
            this.aceGridLookUpEdit1View.FocusRectStyle = DevExpress.XtraGrid.Views.Grid.DrawFocusRectStyle.RowFocus;
            this.aceGridLookUpEdit1View.Name = "aceGridLookUpEdit1View";
            this.aceGridLookUpEdit1View.OptionsSelection.EnableAppearanceFocusedCell = false;
            this.aceGridLookUpEdit1View.OptionsView.ShowAutoFilterRow = true;
            this.aceGridLookUpEdit1View.OptionsView.ShowGroupPanel = false;
            // 
            // txtPhone
            // 
            this.txtPhone.Location = new System.Drawing.Point(81, 84);
            this.txtPhone.Name = "txtPhone";
            this.txtPhone.NullBackColor = System.Drawing.Color.Lime;
            this.txtPhone.NullValidation = false;
            this.txtPhone.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtPhone.Properties.Appearance.Options.UseBackColor = true;
            this.txtPhone.Size = new System.Drawing.Size(360, 20);
            this.txtPhone.StyleController = this.xLayoutControl1;
            this.txtPhone.TabIndex = 7;
            // 
            // txtAddress
            // 
            this.txtAddress.Location = new System.Drawing.Point(81, 60);
            this.txtAddress.Name = "txtAddress";
            this.txtAddress.NullBackColor = System.Drawing.Color.Lime;
            this.txtAddress.NullValidation = false;
            this.txtAddress.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtAddress.Properties.Appearance.Options.UseBackColor = true;
            this.txtAddress.Size = new System.Drawing.Size(360, 20);
            this.txtAddress.StyleController = this.xLayoutControl1;
            this.txtAddress.TabIndex = 6;
            // 
            // txtName
            // 
            this.txtName.Location = new System.Drawing.Point(81, 36);
            this.txtName.Name = "txtName";
            this.txtName.NullBackColor = System.Drawing.Color.Lime;
            this.txtName.NullValidation = false;
            this.txtName.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtName.Properties.Appearance.Options.UseBackColor = true;
            this.txtName.Size = new System.Drawing.Size(360, 20);
            this.txtName.StyleController = this.xLayoutControl1;
            this.txtName.TabIndex = 5;
            // 
            // txtCode
            // 
            this.txtCode.Location = new System.Drawing.Point(81, 12);
            this.txtCode.Name = "txtCode";
            this.txtCode.NullBackColor = System.Drawing.Color.Lime;
            this.txtCode.NullValidation = false;
            this.txtCode.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtCode.Properties.Appearance.Options.UseBackColor = true;
            this.txtCode.Size = new System.Drawing.Size(360, 20);
            this.txtCode.StyleController = this.xLayoutControl1;
            this.txtCode.TabIndex = 4;
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
            this.layoutControlItem4,
            this.lctDepartment,
            this.layoutControlItem7,
            this.layoutControlItem6});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(453, 179);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.txtCode;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(433, 24);
            this.layoutControlItem1.Text = "CODE";
            this.layoutControlItem1.TextSize = new System.Drawing.Size(66, 13);
            // 
            // emptySpaceItem1
            // 
            this.emptySpaceItem1.AllowHotTrack = false;
            this.emptySpaceItem1.Location = new System.Drawing.Point(0, 120);
            this.emptySpaceItem1.Name = "emptySpaceItem1";
            this.emptySpaceItem1.Size = new System.Drawing.Size(167, 39);
            this.emptySpaceItem1.TextSize = new System.Drawing.Size(0, 0);
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.txtName;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 24);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(433, 24);
            this.layoutControlItem2.Text = "NAME";
            this.layoutControlItem2.TextSize = new System.Drawing.Size(66, 13);
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.txtAddress;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 48);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(433, 24);
            this.layoutControlItem3.Text = "ADDRESS";
            this.layoutControlItem3.TextSize = new System.Drawing.Size(66, 13);
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.txtPhone;
            this.layoutControlItem4.Location = new System.Drawing.Point(0, 72);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(433, 24);
            this.layoutControlItem4.Text = "PHONE";
            this.layoutControlItem4.TextSize = new System.Drawing.Size(66, 13);
            // 
            // lctDepartment
            // 
            this.lctDepartment.Control = this.sltDepartment;
            this.lctDepartment.Location = new System.Drawing.Point(0, 96);
            this.lctDepartment.Name = "lctDepartment";
            this.lctDepartment.Size = new System.Drawing.Size(433, 24);
            this.lctDepartment.Text = "DEPARTMENT";
            this.lctDepartment.TextSize = new System.Drawing.Size(66, 13);
            // 
            // layoutControlItem7
            // 
            this.layoutControlItem7.Control = this.btnCancel;
            this.layoutControlItem7.Location = new System.Drawing.Point(300, 120);
            this.layoutControlItem7.Name = "layoutControlItem7";
            this.layoutControlItem7.Size = new System.Drawing.Size(133, 39);
            this.layoutControlItem7.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem7.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.btnSave;
            this.layoutControlItem6.Location = new System.Drawing.Point(167, 120);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(133, 39);
            this.layoutControlItem6.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem6.TextVisible = false;
            // 
            // POP_MAKER_CREATE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(453, 179);
            this.Controls.Add(this.xLayoutControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("POP_MAKER_CREATE.IconOptions.Icon")));
            this.Name = "POP_MAKER_CREATE";
            this.Text = "POP_MAKER_CREATE";
            this.Controls.SetChildIndex(this.xLayoutControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.sltDepartment.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtPhone.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAddress.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtName.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtCode.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.emptySpaceItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.lctDepartment)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private XLayoutControl xLayoutControl1;
        private XSimpleButton btnCancel;
        private XSimpleButton btnSave;
        private AceGridLookUpEdit sltDepartment;
        private DevExpress.XtraGrid.Views.Grid.GridView aceGridLookUpEdit1View;
        private XTextEdit txtPhone;
        private XTextEdit txtAddress;
        private XTextEdit txtName;
        private XTextEdit txtCode;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.EmptySpaceItem emptySpaceItem1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private DevExpress.XtraLayout.LayoutControlItem lctDepartment;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem7;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
    }
}