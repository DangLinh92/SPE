
namespace Wisol.MES.Forms.CONTENT
{
    partial class PO_LIST
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PO_LIST));
            this.splashScreenManager1 = new DevExpress.XtraSplashScreen.SplashScreenManager(this, typeof(global::Wisol.MES.FrmWaitForm), true, true, typeof(System.Windows.Forms.UserControl));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnLoadData = new Wisol.XSimpleButton(this.components);
            this.btnPR_list = new Wisol.XSimpleButton(this.components);
            this.gcList = new Wisol.XGridControl();
            this.gvList = new Wisol.XGridView();
            this.col_ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PO_ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PO_ID_TEMP = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TITLE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_ORERED = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TIME = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_STATUS = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_NEED_FINISH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_CREATE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_UPDATED_DATE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_USER_CREATE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_View = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit3 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.col_Edit = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.col_CANCEL = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit4 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.col_DELETE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit2 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem3 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).BeginInit();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            this.SuspendLayout();
            // 
            // splashScreenManager1
            // 
            this.splashScreenManager1.ClosingDelay = 500;
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1352, 843);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "Danh sách PO";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.splitContainerControl1);
            this.xLayoutControl1.Controls.Add(this.label2);
            this.xLayoutControl1.Controls.Add(this.label1);
            this.xLayoutControl1.Controls.Add(this.btnLoadData);
            this.xLayoutControl1.Controls.Add(this.btnPR_list);
            this.xLayoutControl1.Controls.Add(this.gcList);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1348, 818);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Location = new System.Drawing.Point(12, 805);
            this.splitContainerControl1.Name = "splitContainerControl1";
            // 
            // splitContainerControl1.Panel1
            // 
            this.splitContainerControl1.Panel1.Text = "Panel1";
            // 
            // splitContainerControl1.Panel2
            // 
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1324, 1);
            this.splitContainerControl1.TabIndex = 9;
            // 
            // label2
            // 
            this.label2.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold);
            this.label2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.label2.Location = new System.Drawing.Point(12, 46);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(1324, 20);
            this.label2.TabIndex = 8;
            this.label2.Text = "Danh sách PO";
            this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(278, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(1058, 30);
            this.label1.TabIndex = 7;
            this.label1.Text = "[Danh sách yêu cầu mua hàng từ bộ phận]";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // btnLoadData
            // 
            this.btnLoadData.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnLoadData.ImageOptions.Image")));
            this.btnLoadData.Location = new System.Drawing.Point(12, 12);
            this.btnLoadData.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnLoadData.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnLoadData.Name = "btnLoadData";
            this.btnLoadData.Size = new System.Drawing.Size(129, 30);
            this.btnLoadData.StyleController = this.xLayoutControl1;
            this.btnLoadData.TabIndex = 6;
            this.btnLoadData.Text = "LOAD DATA";
            this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
            // 
            // btnPR_list
            // 
            this.btnPR_list.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnPR_list.ImageOptions.Image")));
            this.btnPR_list.Location = new System.Drawing.Point(145, 12);
            this.btnPR_list.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnPR_list.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnPR_list.Name = "btnPR_list";
            this.btnPR_list.Size = new System.Drawing.Size(129, 30);
            this.btnPR_list.StyleController = this.xLayoutControl1;
            this.btnPR_list.TabIndex = 5;
            this.btnPR_list.Text = "Danh sách yêu cầu";
            this.btnPR_list.Click += new System.EventHandler(this.btnPR_list_Click);
            // 
            // gcList
            // 
            this.gcList.Location = new System.Drawing.Point(12, 70);
            this.gcList.MainView = this.gvList;
            this.gcList.Name = "gcList";
            this.gcList.RepositoryItems.AddRange(new DevExpress.XtraEditors.Repository.RepositoryItem[] {
            this.repositoryItemButtonEdit1,
            this.repositoryItemButtonEdit2,
            this.repositoryItemButtonEdit3,
            this.repositoryItemButtonEdit4});
            this.gcList.Size = new System.Drawing.Size(1324, 731);
            this.gcList.TabIndex = 4;
            this.gcList.UseEmbeddedNavigator = true;
            this.gcList.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvList});
            // 
            // gvList
            // 
            this.gvList.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.col_ID,
            this.col_PO_ID,
            this.col_PO_ID_TEMP,
            this.col_TITLE,
            this.col_DATE_ORERED,
            this.col_TIME,
            this.col_STATUS,
            this.col_DATE_NEED_FINISH,
            this.col_DATE_CREATE,
            this.col_UPDATED_DATE,
            this.col_USER_CREATE,
            this.col_View,
            this.col_Edit,
            this.col_CANCEL,
            this.col_DELETE});
            this.gvList.GridControl = this.gcList;
            this.gvList.Name = "gvList";
            this.gvList.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvList_RowCellClick);
            this.gvList.RowCellStyle += new DevExpress.XtraGrid.Views.Grid.RowCellStyleEventHandler(this.gvList_RowCellStyle);
            // 
            // col_ID
            // 
            this.col_ID.Caption = "ID";
            this.col_ID.FieldName = "ID";
            this.col_ID.Name = "col_ID";
            this.col_ID.Visible = true;
            this.col_ID.VisibleIndex = 0;
            this.col_ID.Width = 137;
            // 
            // col_PO_ID
            // 
            this.col_PO_ID.Caption = "Mã PO";
            this.col_PO_ID.FieldName = "PO_ID";
            this.col_PO_ID.Name = "col_PO_ID";
            this.col_PO_ID.Visible = true;
            this.col_PO_ID.VisibleIndex = 1;
            this.col_PO_ID.Width = 137;
            // 
            // col_PO_ID_TEMP
            // 
            this.col_PO_ID_TEMP.Caption = "PO_ID_TEMP";
            this.col_PO_ID_TEMP.FieldName = "PO_ID_TEMP";
            this.col_PO_ID_TEMP.Name = "col_PO_ID_TEMP";
            this.col_PO_ID_TEMP.Visible = true;
            this.col_PO_ID_TEMP.VisibleIndex = 2;
            // 
            // col_TITLE
            // 
            this.col_TITLE.Caption = "Tiêu đề";
            this.col_TITLE.FieldName = "TITLE";
            this.col_TITLE.Name = "col_TITLE";
            this.col_TITLE.Visible = true;
            this.col_TITLE.VisibleIndex = 3;
            this.col_TITLE.Width = 137;
            // 
            // col_DATE_ORERED
            // 
            this.col_DATE_ORERED.Caption = "Ngày PO";
            this.col_DATE_ORERED.FieldName = "DATE_ORERED";
            this.col_DATE_ORERED.Name = "col_DATE_ORERED";
            this.col_DATE_ORERED.Visible = true;
            this.col_DATE_ORERED.VisibleIndex = 4;
            this.col_DATE_ORERED.Width = 137;
            // 
            // col_TIME
            // 
            this.col_TIME.Caption = "Thời gian";
            this.col_TIME.FieldName = "TIME_PO";
            this.col_TIME.Name = "col_TIME";
            this.col_TIME.Visible = true;
            this.col_TIME.VisibleIndex = 5;
            this.col_TIME.Width = 87;
            // 
            // col_STATUS
            // 
            this.col_STATUS.Caption = "Trạng thái";
            this.col_STATUS.FieldName = "STATUS";
            this.col_STATUS.Name = "col_STATUS";
            this.col_STATUS.Visible = true;
            this.col_STATUS.VisibleIndex = 6;
            this.col_STATUS.Width = 137;
            // 
            // col_DATE_NEED_FINISH
            // 
            this.col_DATE_NEED_FINISH.Caption = "Ngày cần giao hàng";
            this.col_DATE_NEED_FINISH.FieldName = "DATE_NEED_FINISH";
            this.col_DATE_NEED_FINISH.Name = "col_DATE_NEED_FINISH";
            this.col_DATE_NEED_FINISH.Visible = true;
            this.col_DATE_NEED_FINISH.VisibleIndex = 7;
            this.col_DATE_NEED_FINISH.Width = 137;
            // 
            // col_DATE_CREATE
            // 
            this.col_DATE_CREATE.Caption = "Ngày tạo";
            this.col_DATE_CREATE.FieldName = "DATE_CREATE";
            this.col_DATE_CREATE.Name = "col_DATE_CREATE";
            this.col_DATE_CREATE.Visible = true;
            this.col_DATE_CREATE.VisibleIndex = 8;
            this.col_DATE_CREATE.Width = 137;
            // 
            // col_UPDATED_DATE
            // 
            this.col_UPDATED_DATE.Caption = "Ngày cập nhật";
            this.col_UPDATED_DATE.FieldName = "UPDATED_DATE";
            this.col_UPDATED_DATE.Name = "col_UPDATED_DATE";
            this.col_UPDATED_DATE.Visible = true;
            this.col_UPDATED_DATE.VisibleIndex = 9;
            this.col_UPDATED_DATE.Width = 137;
            // 
            // col_USER_CREATE
            // 
            this.col_USER_CREATE.Caption = "Người tạo";
            this.col_USER_CREATE.FieldName = "USER_CREATE";
            this.col_USER_CREATE.Name = "col_USER_CREATE";
            this.col_USER_CREATE.Visible = true;
            this.col_USER_CREATE.VisibleIndex = 10;
            // 
            // col_View
            // 
            this.col_View.Caption = "VIEW";
            this.col_View.ColumnEdit = this.repositoryItemButtonEdit3;
            this.col_View.FieldName = "VIEW";
            this.col_View.Name = "col_View";
            this.col_View.ToolTip = "View";
            this.col_View.Visible = true;
            this.col_View.VisibleIndex = 11;
            this.col_View.Width = 25;
            // 
            // repositoryItemButtonEdit3
            // 
            this.repositoryItemButtonEdit3.AutoHeight = false;
            this.repositoryItemButtonEdit3.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit3.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit3.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit3.Name = "repositoryItemButtonEdit3";
            // 
            // col_Edit
            // 
            this.col_Edit.Caption = "EDIT";
            this.col_Edit.ColumnEdit = this.repositoryItemButtonEdit1;
            this.col_Edit.FieldName = "EDIT";
            this.col_Edit.Name = "col_Edit";
            this.col_Edit.ToolTip = "Sửa PO";
            this.col_Edit.Visible = true;
            this.col_Edit.VisibleIndex = 12;
            this.col_Edit.Width = 25;
            // 
            // repositoryItemButtonEdit1
            // 
            this.repositoryItemButtonEdit1.AutoHeight = false;
            this.repositoryItemButtonEdit1.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit1.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit1.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit1.Name = "repositoryItemButtonEdit1";
            // 
            // col_CANCEL
            // 
            this.col_CANCEL.Caption = "HUY";
            this.col_CANCEL.ColumnEdit = this.repositoryItemButtonEdit4;
            this.col_CANCEL.FieldName = "CANCEL";
            this.col_CANCEL.Name = "col_CANCEL";
            this.col_CANCEL.ToolTip = "Hủy PO";
            this.col_CANCEL.Visible = true;
            this.col_CANCEL.VisibleIndex = 13;
            this.col_CANCEL.Width = 25;
            // 
            // repositoryItemButtonEdit4
            // 
            this.repositoryItemButtonEdit4.AutoHeight = false;
            this.repositoryItemButtonEdit4.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit4.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit4.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit4.Name = "repositoryItemButtonEdit4";
            // 
            // col_DELETE
            // 
            this.col_DELETE.Caption = "DELETE";
            this.col_DELETE.ColumnEdit = this.repositoryItemButtonEdit2;
            this.col_DELETE.FieldName = "DELETE";
            this.col_DELETE.Name = "col_DELETE";
            this.col_DELETE.ToolTip = "Xóa PO";
            this.col_DELETE.Visible = true;
            this.col_DELETE.VisibleIndex = 14;
            this.col_DELETE.Width = 25;
            // 
            // repositoryItemButtonEdit2
            // 
            this.repositoryItemButtonEdit2.AutoHeight = false;
            this.repositoryItemButtonEdit2.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit2.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit2.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit2.Name = "repositoryItemButtonEdit2";
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
            this.layoutControlItem6});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1348, 818);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcList;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 58);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1328, 735);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.btnPR_list;
            this.layoutControlItem2.Location = new System.Drawing.Point(133, 0);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem3
            // 
            this.layoutControlItem3.Control = this.btnLoadData;
            this.layoutControlItem3.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem3.Name = "layoutControlItem3";
            this.layoutControlItem3.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem3.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem3.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.label1;
            this.layoutControlItem4.Location = new System.Drawing.Point(266, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(1062, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.label2;
            this.layoutControlItem5.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(1328, 24);
            this.layoutControlItem5.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem5.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.splitContainerControl1;
            this.layoutControlItem6.Location = new System.Drawing.Point(0, 793);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(1328, 5);
            this.layoutControlItem6.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem6.TextVisible = false;
            // 
            // PO_LIST
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.groupControl1);
            this.Name = "PO_LIST";
            this.Size = new System.Drawing.Size(1352, 843);
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.gcList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvList)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private XSimpleButton btnPR_list;
        private XGridControl gcList;
        private XGridView gvList;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private XSimpleButton btnLoadData;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem3;
        private DevExpress.XtraGrid.Columns.GridColumn col_ID;
        private DevExpress.XtraGrid.Columns.GridColumn col_PO_ID;
        private DevExpress.XtraGrid.Columns.GridColumn col_TITLE;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_ORERED;
        private DevExpress.XtraGrid.Columns.GridColumn col_STATUS;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_NEED_FINISH;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_CREATE;
        private DevExpress.XtraGrid.Columns.GridColumn col_UPDATED_DATE;
        private DevExpress.XtraGrid.Columns.GridColumn col_View;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit3;
        private DevExpress.XtraGrid.Columns.GridColumn col_Edit;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit1;
        private DevExpress.XtraGrid.Columns.GridColumn col_DELETE;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit2;
        private System.Windows.Forms.Label label1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private System.Windows.Forms.Label label2;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
        private DevExpress.XtraGrid.Columns.GridColumn col_TIME;
        private DevExpress.XtraGrid.Columns.GridColumn col_CANCEL;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit4;
        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
        private DevExpress.XtraSplashScreen.SplashScreenManager splashScreenManager1;
        private DevExpress.XtraGrid.Columns.GridColumn col_PO_ID_TEMP;
        private DevExpress.XtraGrid.Columns.GridColumn col_USER_CREATE;
    }
}