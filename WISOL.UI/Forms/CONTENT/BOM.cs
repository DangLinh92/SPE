using DevExpress.XtraEditors.Repository;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Columns;
using System;
using System.Data;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class BOM : PageType
    {
        public BOM()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
        }
        public override void InitializePage()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);

                Init_Control(true);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                txtLine.EditValue = 7;
                txtWorkingday.EditValue = 26;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCreate_Click(object sender, EventArgs e)
        {
            gvList.AddNewRow();
        }

        private void gvList_InitNewRow(object sender, DevExpress.XtraGrid.Views.Grid.InitNewRowEventArgs e)
        {
            gvList.SetRowCellValue(e.RowHandle, gvList.Columns["YN"], true);
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if(e.Column.FieldName == "ID")
            {
                RepositoryItemTextEdit textEdit = new RepositoryItemTextEdit();
                gvList.OptionsBehavior.Editable = true;
                GridColumn cost = gvList.Columns["ID"];
                cost.OptionsColumn.AllowEdit = true;
                cost.ColumnEdit = textEdit;
                cost.FieldName = "txtCost";
            }
            MsgBox.Show(e.RowHandle.ToString());
        }

        private void gvList_Click(object sender, EventArgs e)
        {
            
        }
    }
}
