
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class UPDATE_SPAREPART_CODE
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UPDATE_SPAREPART_CODE));
            this.txtCodeOld = new Wisol.XTextEdit();
            this.txtCodeNew = new Wisol.XTextEdit();
            this.btnUpdate = new Wisol.XSimpleButton(this.components);
            this.btnCancel = new Wisol.XSimpleButton(this.components);
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.txtCodeOld.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtCodeNew.Properties)).BeginInit();
            this.SuspendLayout();
            // 
            // txtCodeOld
            // 
            this.txtCodeOld.IsRequire = false;
            this.txtCodeOld.Location = new System.Drawing.Point(131, 37);
            this.txtCodeOld.Name = "txtCodeOld";
            this.txtCodeOld.NullBackColor = System.Drawing.Color.Lime;
            this.txtCodeOld.NullValidation = false;
            this.txtCodeOld.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtCodeOld.Properties.Appearance.Options.UseBackColor = true;
            this.txtCodeOld.Size = new System.Drawing.Size(252, 20);
            this.txtCodeOld.TabIndex = 1;
            // 
            // txtCodeNew
            // 
            this.txtCodeNew.IsRequire = false;
            this.txtCodeNew.Location = new System.Drawing.Point(131, 72);
            this.txtCodeNew.Name = "txtCodeNew";
            this.txtCodeNew.NullBackColor = System.Drawing.Color.Lime;
            this.txtCodeNew.NullValidation = false;
            this.txtCodeNew.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));
            this.txtCodeNew.Properties.Appearance.Options.UseBackColor = true;
            this.txtCodeNew.Size = new System.Drawing.Size(252, 20);
            this.txtCodeNew.TabIndex = 2;
            // 
            // btnUpdate
            // 
            this.btnUpdate.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnUpdate.ImageOptions.Image")));
            this.btnUpdate.Location = new System.Drawing.Point(206, 114);
            this.btnUpdate.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnUpdate.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnUpdate.Name = "btnUpdate";
            this.btnUpdate.Size = new System.Drawing.Size(129, 30);
            this.btnUpdate.TabIndex = 3;
            this.btnUpdate.Text = "Update";
            this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCancel.ImageOptions.Image")));
            this.btnCancel.Location = new System.Drawing.Point(341, 114);
            this.btnCancel.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCancel.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(129, 30);
            this.btnCancel.TabIndex = 4;
            this.btnCancel.Text = "Close";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(29, 40);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(76, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "Mã thiết bị(cũ)";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(29, 75);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(81, 13);
            this.label2.TabIndex = 9;
            this.label2.Text = "Mã thiết bị(mới)";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold);
            this.label3.Location = new System.Drawing.Point(173, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(176, 19);
            this.label3.TabIndex = 10;
            this.label3.Text = "Cập nhật mã thiết bị";
            // 
            // UPDATE_SPAREPART_CODE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(517, 170);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnUpdate);
            this.Controls.Add(this.txtCodeNew);
            this.Controls.Add(this.txtCodeOld);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("UPDATE_SPAREPART_CODE.IconOptions.Icon")));
            this.Name = "UPDATE_SPAREPART_CODE";
            this.Text = "UPDATE_SPAREPART_CODE";
            this.Load += new System.EventHandler(this.UPDATE_SPAREPART_CODE_Load);
            this.Controls.SetChildIndex(this.txtCodeOld, 0);
            this.Controls.SetChildIndex(this.txtCodeNew, 0);
            this.Controls.SetChildIndex(this.btnUpdate, 0);
            this.Controls.SetChildIndex(this.btnCancel, 0);
            this.Controls.SetChildIndex(this.label1, 0);
            this.Controls.SetChildIndex(this.label2, 0);
            this.Controls.SetChildIndex(this.label3, 0);
            ((System.ComponentModel.ISupportInitialize)(this.txtCodeOld.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtCodeNew.Properties)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private XTextEdit txtCodeOld;
        private XTextEdit txtCodeNew;
        private XSimpleButton btnUpdate;
        private XSimpleButton btnCancel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
    }
}