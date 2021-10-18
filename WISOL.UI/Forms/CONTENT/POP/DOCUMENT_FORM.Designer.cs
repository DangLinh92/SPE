
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class DOCUMENT_FORM
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DOCUMENT_FORM));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.btnUpload = new Wisol.XSimpleButton(this.components);
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.col_FileName = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_FileType = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_Download = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_Delete = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.repositoryItemButtonEdit2 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(922, 522);
            this.groupControl1.TabIndex = 4;
            this.groupControl1.Text = "Danh sách tài liệu của thiết bị";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.btnUpload);
            this.xLayoutControl1.Controls.Add(this.gcList);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(918, 497);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // Root
            // 
            this.Root.EnableIndentsWithoutBorders = DevExpress.Utils.DefaultBoolean.True;
            this.Root.GroupBordersVisible = false;
            this.Root.Items.AddRange(new DevExpress.XtraLayout.BaseLayoutItem[] {
            this.layoutControlItem1,
            this.layoutControlItem2});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(918, 497);
            this.Root.TextVisible = false;
            // 
            // gcList
            // 
            this.gcList.Location = new System.Drawing.Point(12, 46);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.RepositoryItems.AddRange(new DevExpress.XtraEditors.Repository.RepositoryItem[] {
            this.repositoryItemButtonEdit1,
            this.repositoryItemButtonEdit2});
            this.gcList.Size = new System.Drawing.Size(894, 439);
            this.gcList.TabIndex = 4;
            this.gcList.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvList});
            // 
            // gvList
            // 
            this.gvList.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.col_FileName,
            this.col_FileType,
            this.col_Download,
            this.col_Delete});
            this.gvList.GridControl = this.gcList;
            this.gvList.Name = "gvList";
            this.gvList.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvList_RowCellClick);
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcList;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(898, 443);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // btnUpload
            // 
            this.btnUpload.FormId = null;
            this.btnUpload.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnUpload.ImageOptions.Image")));
            this.btnUpload.isFormType = false;
            this.btnUpload.Location = new System.Drawing.Point(12, 12);
            this.btnUpload.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnUpload.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnUpload.Name = "btnUpload";
            this.btnUpload.Size = new System.Drawing.Size(129, 30);
            this.btnUpload.StyleController = this.xLayoutControl1;
            this.btnUpload.TabIndex = 5;
            this.btnUpload.Text = "Upload Document";
            this.btnUpload.Click += new System.EventHandler(this.btnUpload_Click);
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.btnUpload;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(898, 34);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // col_FileName
            // 
            this.col_FileName.Caption = "FILE NAME";
            this.col_FileName.FieldName = "NAME";
            this.col_FileName.Name = "col_FileName";
            this.col_FileName.Visible = true;
            this.col_FileName.VisibleIndex = 0;
            this.col_FileName.Width = 393;
            // 
            // col_FileType
            // 
            this.col_FileType.Caption = "FILE TYPE";
            this.col_FileType.FieldName = "CONTENT_TYPE";
            this.col_FileType.Name = "col_FileType";
            this.col_FileType.Visible = true;
            this.col_FileType.VisibleIndex = 1;
            this.col_FileType.Width = 393;
            // 
            // col_Download
            // 
            this.col_Download.Caption = "DOWNLOAD";
            this.col_Download.ColumnEdit = this.repositoryItemButtonEdit1;
            this.col_Download.FieldName = "DOWNLOAD";
            this.col_Download.Name = "col_Download";
            this.col_Download.Visible = true;
            this.col_Download.VisibleIndex = 2;
            this.col_Download.Width = 40;
            // 
            // col_Delete
            // 
            this.col_Delete.Caption = "DELETE";
            this.col_Delete.ColumnEdit = this.repositoryItemButtonEdit2;
            this.col_Delete.FieldName = "DELETE";
            this.col_Delete.Name = "col_Delete";
            this.col_Delete.Visible = true;
            this.col_Delete.VisibleIndex = 3;
            this.col_Delete.Width = 40;
            // 
            // repositoryItemButtonEdit1
            // 
            this.repositoryItemButtonEdit1.AutoHeight = false;
            this.repositoryItemButtonEdit1.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit1.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit1.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit1.Name = "repositoryItemButtonEdit1";
            // 
            // repositoryItemButtonEdit2
            // 
            this.repositoryItemButtonEdit2.AutoHeight = false;
            this.repositoryItemButtonEdit2.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit2.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit2.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit2.Name = "repositoryItemButtonEdit2";
            // 
            // DOCUMENT_FORM
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(922, 522);
            this.Controls.Add(this.groupControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("DOCUMENT_FORM.IconOptions.Icon")));
            this.Name = "DOCUMENT_FORM";
            this.Text = "DOCUMENT_FORM";
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).EndInit();
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
        private XSimpleButton btnUpload;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraGrid.Columns.GridColumn col_FileName;
        private DevExpress.XtraGrid.Columns.GridColumn col_FileType;
        private DevExpress.XtraGrid.Columns.GridColumn col_Download;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit1;
        private DevExpress.XtraGrid.Columns.GridColumn col_Delete;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit2;
    }
}