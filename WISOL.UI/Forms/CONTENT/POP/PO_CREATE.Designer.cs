
namespace Wisol.MES.Forms.CONTENT.POP
{
    partial class PO_CREATE
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PO_CREATE));
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.xLayoutControl1 = new Wisol.XLayoutControl();
            this.stlPO = new Wisol.AceGridLookUpEdit(this.components);
            this.aceGridLookUpEdit1View = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.btnCreatePO = new Wisol.XSimpleButton(this.components);
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnReload = new Wisol.XSimpleButton(this.components);
            this.gcListPr = new Wisol.XGridControl();
            this.gvListPr = new Wisol.XGridView();
            this.col_ID = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PR_CODE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_MRP_CODE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TOTAL_VALUE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TOTAL_VALUE_US = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_CREATE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_NEED_FINISH = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DEPT_CODE = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PR_STATUS = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_Add = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.gcListPr_PO = new Wisol.XGridControl();
            this.gvListPr_PO = new Wisol.XGridView();
            this.col_ID1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PR_CODE1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_MRP_CODE1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TOTAL_VALUE1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_TOTAL_VALUE_US1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_CREATE1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DATE_NEED_FINISH1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_DEPT_CODE1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_PR_STATUS1 = new DevExpress.XtraGrid.Columns.GridColumn();
            this.col_SUB = new DevExpress.XtraGrid.Columns.GridColumn();
            this.repositoryItemButtonEdit2 = new DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit();
            this.Root = new DevExpress.XtraLayout.LayoutControlGroup();
            this.layoutControlItem1 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem2 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem6 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem7 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem4 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem8 = new DevExpress.XtraLayout.LayoutControlItem();
            this.layoutControlItem5 = new DevExpress.XtraLayout.LayoutControlItem();
            this.splashScreenManager1 = new DevExpress.XtraSplashScreen.SplashScreenManager(this, typeof(global::Wisol.MES.FrmWaitForm), true, true);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).BeginInit();
            this.xLayoutControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.stlPO.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcListPr)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvListPr)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcListPr_PO)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvListPr_PO)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem8)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).BeginInit();
            this.SuspendLayout();
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.xLayoutControl1);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(0, 0);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.Size = new System.Drawing.Size(1344, 827);
            this.groupControl1.TabIndex = 1;
            this.groupControl1.Text = "Danh sách yêu cầu mua hàng, tạo PO";
            // 
            // xLayoutControl1
            // 
            this.xLayoutControl1.Controls.Add(this.stlPO);
            this.xLayoutControl1.Controls.Add(this.btnCreatePO);
            this.xLayoutControl1.Controls.Add(this.label2);
            this.xLayoutControl1.Controls.Add(this.label1);
            this.xLayoutControl1.Controls.Add(this.btnReload);
            this.xLayoutControl1.Controls.Add(this.gcListPr);
            this.xLayoutControl1.Controls.Add(this.gcListPr_PO);
            this.xLayoutControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.xLayoutControl1.Location = new System.Drawing.Point(2, 23);
            this.xLayoutControl1.Name = "xLayoutControl1";
            this.xLayoutControl1.Root = this.Root;
            this.xLayoutControl1.Size = new System.Drawing.Size(1340, 802);
            this.xLayoutControl1.TabIndex = 0;
            this.xLayoutControl1.Text = "xLayoutControl1";
            // 
            // stlPO
            // 
            this.stlPO.EditValue = "";
            this.stlPO.Location = new System.Drawing.Point(48, 366);
            this.stlPO.Name = "stlPO";
            this.stlPO.Properties.Appearance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(153)))));
            this.stlPO.Properties.Appearance.ForeColor = System.Drawing.Color.Black;
            this.stlPO.Properties.Appearance.Options.UseBackColor = true;
            this.stlPO.Properties.Appearance.Options.UseForeColor = true;
            this.stlPO.Properties.Appearance.Options.UseTextOptions = true;
            this.stlPO.Properties.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center;
            this.stlPO.Properties.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)});
            this.stlPO.Properties.ImmediatePopup = true;
            this.stlPO.Properties.NullText = "";
            this.stlPO.Properties.PopupView = this.aceGridLookUpEdit1View;
            this.stlPO.Size = new System.Drawing.Size(237, 20);
            this.stlPO.StyleController = this.xLayoutControl1;
            this.stlPO.TabIndex = 1;
            this.stlPO.EditValueChanged += new System.EventHandler(this.stlPO_ID_EditValueChanged);
            // 
            // aceGridLookUpEdit1View
            // 
            this.aceGridLookUpEdit1View.FocusRectStyle = DevExpress.XtraGrid.Views.Grid.DrawFocusRectStyle.RowFocus;
            this.aceGridLookUpEdit1View.Name = "aceGridLookUpEdit1View";
            this.aceGridLookUpEdit1View.OptionsSelection.EnableAppearanceFocusedCell = false;
            this.aceGridLookUpEdit1View.OptionsView.ShowAutoFilterRow = true;
            this.aceGridLookUpEdit1View.OptionsView.ShowGroupPanel = false;
            // 
            // btnCreatePO
            // 
            this.btnCreatePO.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnCreatePO.ImageOptions.Image")));
            this.btnCreatePO.Location = new System.Drawing.Point(145, 12);
            this.btnCreatePO.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnCreatePO.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnCreatePO.Name = "btnCreatePO";
            this.btnCreatePO.Size = new System.Drawing.Size(129, 30);
            this.btnCreatePO.StyleController = this.xLayoutControl1;
            this.btnCreatePO.TabIndex = 7;
            this.btnCreatePO.Text = "Tạo File PO";
            this.btnCreatePO.Click += new System.EventHandler(this.btnCreatePO_Click);
            // 
            // label2
            // 
            this.label2.ForeColor = System.Drawing.Color.Maroon;
            this.label2.Location = new System.Drawing.Point(289, 366);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(1039, 20);
            this.label2.TabIndex = 10;
            this.label2.Text = "DANH SÁCH TỔNG HỢP YÊU CẦU MUA HÀNG CÁC BỘ PHẬN";
            this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // label1
            // 
            this.label1.ForeColor = System.Drawing.Color.Maroon;
            this.label1.Location = new System.Drawing.Point(12, 46);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(1316, 20);
            this.label1.TabIndex = 9;
            this.label1.Text = "DANH SÁCH YÊU CẦU MUA HÀNG CÁC BỘ PHẬN";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnReload
            // 
            this.btnReload.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("btnReload.ImageOptions.Image")));
            this.btnReload.Location = new System.Drawing.Point(12, 12);
            this.btnReload.MaximumSize = new System.Drawing.Size(129, 30);
            this.btnReload.MinimumSize = new System.Drawing.Size(129, 30);
            this.btnReload.Name = "btnReload";
            this.btnReload.Size = new System.Drawing.Size(129, 30);
            this.btnReload.StyleController = this.xLayoutControl1;
            this.btnReload.TabIndex = 8;
            this.btnReload.Text = "RELOAD DATA";
            this.btnReload.Click += new System.EventHandler(this.btnReload_Click);
            // 
            // gcListPr
            // 
            this.gcListPr.Location = new System.Drawing.Point(12, 70);
            this.gcListPr.MainView = this.gvListPr;
            this.gcListPr.Name = "gcListPr";
            this.gcListPr.RepositoryItems.AddRange(new DevExpress.XtraEditors.Repository.RepositoryItem[] {
            this.repositoryItemButtonEdit1});
            this.gcListPr.Size = new System.Drawing.Size(1316, 292);
            this.gcListPr.TabIndex = 5;
            this.gcListPr.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvListPr});
            // 
            // gvListPr
            // 
            this.gvListPr.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.col_ID,
            this.col_PR_CODE,
            this.col_MRP_CODE,
            this.col_TOTAL_VALUE,
            this.col_TOTAL_VALUE_US,
            this.col_DATE_CREATE,
            this.col_DATE_NEED_FINISH,
            this.col_DEPT_CODE,
            this.col_PR_STATUS,
            this.col_Add});
            this.gvListPr.GridControl = this.gcListPr;
            this.gvListPr.Name = "gvListPr";
            this.gvListPr.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvListPr_RowCellClick);
            this.gvListPr.RowCellStyle += new DevExpress.XtraGrid.Views.Grid.RowCellStyleEventHandler(this.gvListPr_RowCellStyle);
            // 
            // col_ID
            // 
            this.col_ID.Caption = "ID";
            this.col_ID.FieldName = "ID";
            this.col_ID.Name = "col_ID";
            this.col_ID.Visible = true;
            this.col_ID.VisibleIndex = 0;
            this.col_ID.Width = 129;
            // 
            // col_PR_CODE
            // 
            this.col_PR_CODE.Caption = "PR CODE";
            this.col_PR_CODE.FieldName = "PR_CODE";
            this.col_PR_CODE.Name = "col_PR_CODE";
            this.col_PR_CODE.Visible = true;
            this.col_PR_CODE.VisibleIndex = 1;
            this.col_PR_CODE.Width = 129;
            // 
            // col_MRP_CODE
            // 
            this.col_MRP_CODE.Caption = "MRP CODE";
            this.col_MRP_CODE.FieldName = "MRP_CODE";
            this.col_MRP_CODE.Name = "col_MRP_CODE";
            this.col_MRP_CODE.Visible = true;
            this.col_MRP_CODE.VisibleIndex = 2;
            this.col_MRP_CODE.Width = 129;
            // 
            // col_TOTAL_VALUE
            // 
            this.col_TOTAL_VALUE.Caption = "Giá trị đơn hàng(VN)";
            this.col_TOTAL_VALUE.FieldName = "TOTAL_VALUE";
            this.col_TOTAL_VALUE.Name = "col_TOTAL_VALUE";
            this.col_TOTAL_VALUE.Visible = true;
            this.col_TOTAL_VALUE.VisibleIndex = 3;
            this.col_TOTAL_VALUE.Width = 129;
            // 
            // col_TOTAL_VALUE_US
            // 
            this.col_TOTAL_VALUE_US.Caption = "Giá trị đơn hàng(USD)";
            this.col_TOTAL_VALUE_US.FieldName = "TOTAL_VALUE_US";
            this.col_TOTAL_VALUE_US.Name = "col_TOTAL_VALUE_US";
            this.col_TOTAL_VALUE_US.Visible = true;
            this.col_TOTAL_VALUE_US.VisibleIndex = 4;
            this.col_TOTAL_VALUE_US.Width = 129;
            // 
            // col_DATE_CREATE
            // 
            this.col_DATE_CREATE.Caption = "Ngày tạo";
            this.col_DATE_CREATE.FieldName = "DATE_CREATE";
            this.col_DATE_CREATE.Name = "col_DATE_CREATE";
            this.col_DATE_CREATE.Visible = true;
            this.col_DATE_CREATE.VisibleIndex = 5;
            this.col_DATE_CREATE.Width = 129;
            // 
            // col_DATE_NEED_FINISH
            // 
            this.col_DATE_NEED_FINISH.Caption = "Ngày cần hàng";
            this.col_DATE_NEED_FINISH.FieldName = "DATE_NEED_FINISH";
            this.col_DATE_NEED_FINISH.Name = "col_DATE_NEED_FINISH";
            this.col_DATE_NEED_FINISH.Visible = true;
            this.col_DATE_NEED_FINISH.VisibleIndex = 6;
            this.col_DATE_NEED_FINISH.Width = 129;
            // 
            // col_DEPT_CODE
            // 
            this.col_DEPT_CODE.Caption = "Bộ phận";
            this.col_DEPT_CODE.FieldName = "DEPT_CODE";
            this.col_DEPT_CODE.Name = "col_DEPT_CODE";
            this.col_DEPT_CODE.Visible = true;
            this.col_DEPT_CODE.VisibleIndex = 7;
            this.col_DEPT_CODE.Width = 129;
            // 
            // col_PR_STATUS
            // 
            this.col_PR_STATUS.Caption = "STATUS";
            this.col_PR_STATUS.FieldName = "STATUS";
            this.col_PR_STATUS.Name = "col_PR_STATUS";
            this.col_PR_STATUS.Visible = true;
            this.col_PR_STATUS.VisibleIndex = 8;
            this.col_PR_STATUS.Width = 129;
            // 
            // col_Add
            // 
            this.col_Add.Caption = "ADD";
            this.col_Add.ColumnEdit = this.repositoryItemButtonEdit1;
            this.col_Add.FieldName = "ADD";
            this.col_Add.Name = "col_Add";
            this.col_Add.Visible = true;
            this.col_Add.VisibleIndex = 9;
            this.col_Add.Width = 25;
            // 
            // repositoryItemButtonEdit1
            // 
            this.repositoryItemButtonEdit1.AutoHeight = false;
            this.repositoryItemButtonEdit1.Buttons.AddRange(new DevExpress.XtraEditors.Controls.EditorButton[] {
            new DevExpress.XtraEditors.Controls.EditorButton()});
            this.repositoryItemButtonEdit1.ContextImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("repositoryItemButtonEdit1.ContextImageOptions.Image")));
            this.repositoryItemButtonEdit1.Name = "repositoryItemButtonEdit1";
            // 
            // gcListPr_PO
            // 
            this.gcListPr_PO.Location = new System.Drawing.Point(12, 390);
            this.gcListPr_PO.MainView = this.gvListPr_PO;
            this.gcListPr_PO.Name = "gcListPr_PO";
            this.gcListPr_PO.RepositoryItems.AddRange(new DevExpress.XtraEditors.Repository.RepositoryItem[] {
            this.repositoryItemButtonEdit2});
            this.gcListPr_PO.Size = new System.Drawing.Size(1316, 400);
            this.gcListPr_PO.TabIndex = 4;
            this.gcListPr_PO.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gvListPr_PO});
            // 
            // gvListPr_PO
            // 
            this.gvListPr_PO.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.col_ID1,
            this.col_PR_CODE1,
            this.col_MRP_CODE1,
            this.col_TOTAL_VALUE1,
            this.col_TOTAL_VALUE_US1,
            this.col_DATE_CREATE1,
            this.col_DATE_NEED_FINISH1,
            this.col_DEPT_CODE1,
            this.col_PR_STATUS1,
            this.col_SUB});
            this.gvListPr_PO.GridControl = this.gcListPr_PO;
            this.gvListPr_PO.Name = "gvListPr_PO";
            this.gvListPr_PO.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gvListPr_PO_RowCellClick);
            this.gvListPr_PO.RowCellStyle += new DevExpress.XtraGrid.Views.Grid.RowCellStyleEventHandler(this.gvListPr_PO_RowCellStyle);
            // 
            // col_ID1
            // 
            this.col_ID1.Caption = "ID";
            this.col_ID1.FieldName = "ID";
            this.col_ID1.Name = "col_ID1";
            this.col_ID1.Visible = true;
            this.col_ID1.VisibleIndex = 0;
            this.col_ID1.Width = 129;
            // 
            // col_PR_CODE1
            // 
            this.col_PR_CODE1.Caption = "PR CODE";
            this.col_PR_CODE1.FieldName = "PR_CODE";
            this.col_PR_CODE1.Name = "col_PR_CODE1";
            this.col_PR_CODE1.Visible = true;
            this.col_PR_CODE1.VisibleIndex = 1;
            this.col_PR_CODE1.Width = 129;
            // 
            // col_MRP_CODE1
            // 
            this.col_MRP_CODE1.Caption = "MRP CODE";
            this.col_MRP_CODE1.FieldName = "MRP_CODE";
            this.col_MRP_CODE1.Name = "col_MRP_CODE1";
            this.col_MRP_CODE1.Visible = true;
            this.col_MRP_CODE1.VisibleIndex = 2;
            this.col_MRP_CODE1.Width = 129;
            // 
            // col_TOTAL_VALUE1
            // 
            this.col_TOTAL_VALUE1.Caption = "Giá trị đơn hàng(VN)";
            this.col_TOTAL_VALUE1.FieldName = "TOTAL_VALUE";
            this.col_TOTAL_VALUE1.Name = "col_TOTAL_VALUE1";
            this.col_TOTAL_VALUE1.Visible = true;
            this.col_TOTAL_VALUE1.VisibleIndex = 3;
            this.col_TOTAL_VALUE1.Width = 129;
            // 
            // col_TOTAL_VALUE_US1
            // 
            this.col_TOTAL_VALUE_US1.Caption = "Giá trị đơn hàng(USD)";
            this.col_TOTAL_VALUE_US1.FieldName = "TOTAL_VALUE_US";
            this.col_TOTAL_VALUE_US1.Name = "col_TOTAL_VALUE_US1";
            this.col_TOTAL_VALUE_US1.Visible = true;
            this.col_TOTAL_VALUE_US1.VisibleIndex = 4;
            this.col_TOTAL_VALUE_US1.Width = 129;
            // 
            // col_DATE_CREATE1
            // 
            this.col_DATE_CREATE1.Caption = "Ngày tạo";
            this.col_DATE_CREATE1.FieldName = "DATE_CREATE";
            this.col_DATE_CREATE1.Name = "col_DATE_CREATE1";
            this.col_DATE_CREATE1.Visible = true;
            this.col_DATE_CREATE1.VisibleIndex = 5;
            this.col_DATE_CREATE1.Width = 129;
            // 
            // col_DATE_NEED_FINISH1
            // 
            this.col_DATE_NEED_FINISH1.Caption = "Ngày cần hàng";
            this.col_DATE_NEED_FINISH1.FieldName = "DATE_NEED_FINISH";
            this.col_DATE_NEED_FINISH1.Name = "col_DATE_NEED_FINISH1";
            this.col_DATE_NEED_FINISH1.Visible = true;
            this.col_DATE_NEED_FINISH1.VisibleIndex = 6;
            this.col_DATE_NEED_FINISH1.Width = 129;
            // 
            // col_DEPT_CODE1
            // 
            this.col_DEPT_CODE1.Caption = "Bộ phận";
            this.col_DEPT_CODE1.FieldName = "DEPT_CODE";
            this.col_DEPT_CODE1.Name = "col_DEPT_CODE1";
            this.col_DEPT_CODE1.Visible = true;
            this.col_DEPT_CODE1.VisibleIndex = 7;
            this.col_DEPT_CODE1.Width = 129;
            // 
            // col_PR_STATUS1
            // 
            this.col_PR_STATUS1.Caption = "STATUS";
            this.col_PR_STATUS1.FieldName = "STATUS";
            this.col_PR_STATUS1.Name = "col_PR_STATUS1";
            this.col_PR_STATUS1.Visible = true;
            this.col_PR_STATUS1.VisibleIndex = 8;
            this.col_PR_STATUS1.Width = 129;
            // 
            // col_SUB
            // 
            this.col_SUB.Caption = "SUB";
            this.col_SUB.ColumnEdit = this.repositoryItemButtonEdit2;
            this.col_SUB.FieldName = "SUB";
            this.col_SUB.Name = "col_SUB";
            this.col_SUB.Visible = true;
            this.col_SUB.VisibleIndex = 9;
            this.col_SUB.Width = 25;
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
            this.layoutControlItem6,
            this.layoutControlItem7,
            this.layoutControlItem4,
            this.layoutControlItem8,
            this.layoutControlItem5});
            this.Root.Name = "Root";
            this.Root.Size = new System.Drawing.Size(1340, 802);
            this.Root.TextVisible = false;
            // 
            // layoutControlItem1
            // 
            this.layoutControlItem1.Control = this.gcListPr_PO;
            this.layoutControlItem1.Location = new System.Drawing.Point(0, 378);
            this.layoutControlItem1.Name = "layoutControlItem1";
            this.layoutControlItem1.Size = new System.Drawing.Size(1320, 404);
            this.layoutControlItem1.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem1.TextVisible = false;
            // 
            // layoutControlItem2
            // 
            this.layoutControlItem2.Control = this.gcListPr;
            this.layoutControlItem2.Location = new System.Drawing.Point(0, 58);
            this.layoutControlItem2.Name = "layoutControlItem2";
            this.layoutControlItem2.Size = new System.Drawing.Size(1320, 296);
            this.layoutControlItem2.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem2.TextVisible = false;
            // 
            // layoutControlItem6
            // 
            this.layoutControlItem6.Control = this.label1;
            this.layoutControlItem6.Location = new System.Drawing.Point(0, 34);
            this.layoutControlItem6.Name = "layoutControlItem6";
            this.layoutControlItem6.Size = new System.Drawing.Size(1320, 24);
            this.layoutControlItem6.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem6.TextVisible = false;
            // 
            // layoutControlItem7
            // 
            this.layoutControlItem7.Control = this.label2;
            this.layoutControlItem7.Location = new System.Drawing.Point(277, 354);
            this.layoutControlItem7.Name = "layoutControlItem7";
            this.layoutControlItem7.Size = new System.Drawing.Size(1043, 24);
            this.layoutControlItem7.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem7.TextVisible = false;
            // 
            // layoutControlItem4
            // 
            this.layoutControlItem4.Control = this.btnCreatePO;
            this.layoutControlItem4.Location = new System.Drawing.Point(133, 0);
            this.layoutControlItem4.Name = "layoutControlItem4";
            this.layoutControlItem4.Size = new System.Drawing.Size(1187, 34);
            this.layoutControlItem4.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem4.TextVisible = false;
            // 
            // layoutControlItem8
            // 
            this.layoutControlItem8.AppearanceItemCaption.BackColor = System.Drawing.Color.Transparent;
            this.layoutControlItem8.AppearanceItemCaption.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold);
            this.layoutControlItem8.AppearanceItemCaption.ForeColor = System.Drawing.Color.Firebrick;
            this.layoutControlItem8.AppearanceItemCaption.Options.UseBackColor = true;
            this.layoutControlItem8.AppearanceItemCaption.Options.UseFont = true;
            this.layoutControlItem8.AppearanceItemCaption.Options.UseForeColor = true;
            this.layoutControlItem8.Control = this.stlPO;
            this.layoutControlItem8.Location = new System.Drawing.Point(0, 354);
            this.layoutControlItem8.Name = "layoutControlItem8";
            this.layoutControlItem8.Size = new System.Drawing.Size(277, 24);
            this.layoutControlItem8.Text = "PO.NO";
            this.layoutControlItem8.TextSize = new System.Drawing.Size(33, 13);
            // 
            // layoutControlItem5
            // 
            this.layoutControlItem5.Control = this.btnReload;
            this.layoutControlItem5.Location = new System.Drawing.Point(0, 0);
            this.layoutControlItem5.Name = "layoutControlItem5";
            this.layoutControlItem5.Size = new System.Drawing.Size(133, 34);
            this.layoutControlItem5.TextSize = new System.Drawing.Size(0, 0);
            this.layoutControlItem5.TextVisible = false;
            // 
            // splashScreenManager1
            // 
            this.splashScreenManager1.ClosingDelay = 500;
            // 
            // PO_CREATE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1344, 827);
            this.Controls.Add(this.groupControl1);
            this.IconOptions.Icon = ((System.Drawing.Icon)(resources.GetObject("PO_CREATE.IconOptions.Icon")));
            this.Name = "PO_CREATE";
            this.Text = "PR LIST";
            this.Controls.SetChildIndex(this.groupControl1, 0);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.xLayoutControl1)).EndInit();
            this.xLayoutControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.stlPO.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.aceGridLookUpEdit1View)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcListPr)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvListPr)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gcListPr_PO)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gvListPr_PO)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemButtonEdit2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Root)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem8)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.layoutControlItem5)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraEditors.GroupControl groupControl1;
        private XLayoutControl xLayoutControl1;
        private XSimpleButton btnCreatePO;
        private XGridControl gcListPr;
        private XGridView gvListPr;
        private XGridControl gcListPr_PO;
        private XGridView gvListPr_PO;
        private DevExpress.XtraLayout.LayoutControlGroup Root;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem2;
        private DevExpress.XtraGrid.Columns.GridColumn col_ID;
        private DevExpress.XtraGrid.Columns.GridColumn col_PR_CODE;
        private DevExpress.XtraGrid.Columns.GridColumn col_MRP_CODE;
        private DevExpress.XtraGrid.Columns.GridColumn col_TOTAL_VALUE;
        private DevExpress.XtraGrid.Columns.GridColumn col_TOTAL_VALUE_US;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_CREATE;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_NEED_FINISH;
        private DevExpress.XtraGrid.Columns.GridColumn col_DEPT_CODE;
        private DevExpress.XtraGrid.Columns.GridColumn col_PR_STATUS;
        private DevExpress.XtraGrid.Columns.GridColumn col_Add;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit1;
        private DevExpress.XtraGrid.Columns.GridColumn col_ID1;
        private DevExpress.XtraGrid.Columns.GridColumn col_PR_CODE1;
        private DevExpress.XtraGrid.Columns.GridColumn col_MRP_CODE1;
        private DevExpress.XtraGrid.Columns.GridColumn col_TOTAL_VALUE1;
        private DevExpress.XtraGrid.Columns.GridColumn col_TOTAL_VALUE_US1;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_CREATE1;
        private DevExpress.XtraGrid.Columns.GridColumn col_DATE_NEED_FINISH1;
        private DevExpress.XtraGrid.Columns.GridColumn col_DEPT_CODE1;
        private DevExpress.XtraGrid.Columns.GridColumn col_PR_STATUS1;
        private DevExpress.XtraGrid.Columns.GridColumn col_SUB;
        private DevExpress.XtraEditors.Repository.RepositoryItemButtonEdit repositoryItemButtonEdit2;
        private XSimpleButton btnReload;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem5;
        private DevExpress.XtraSplashScreen.SplashScreenManager splashScreenManager1;
        private System.Windows.Forms.Label label1;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem6;
        private System.Windows.Forms.Label label2;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem7;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem4;
        private AceGridLookUpEdit stlPO;
        private DevExpress.XtraGrid.Views.Grid.GridView aceGridLookUpEdit1View;
        private DevExpress.XtraLayout.LayoutControlItem layoutControlItem8;
    }
}