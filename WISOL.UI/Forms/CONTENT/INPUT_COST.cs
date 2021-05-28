using DevExpress.XtraEditors.Repository;
using System;
using Wisol.Components;
using Wisol.MES.Inherit;
using DevExpress.XtraGrid.Columns;
using System.Data;
using Wisol.Common;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class INPUT_COST : PageType
    {
        DataTable dt = new DataTable();
        DataTable dtEdit = new DataTable();

        public INPUT_COST()
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INPUT_COST.GET", new string[] { "A_DEPARTMENT", "A_ROLE", "A_CTG" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, "NEW" });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    dt = base.m_ResultDB.ReturnDataSet.Tables[1];
                    base.m_BindData.BindGridLookEdit(sltCtg, base.m_ResultDB.ReturnDataSet.Tables[0], "CODE", "NAME");
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[1]);

                    RepositoryItemTextEdit textEdit = new RepositoryItemTextEdit();
                    RepositoryItemComboBox select = new RepositoryItemComboBox();
                    select.Items.AddRange(new object[] {"VND","USD"});
                    
                    textEdit.Mask.MaskType = DevExpress.XtraEditors.Mask.MaskType.Numeric;
                    textEdit.Mask.EditMask = "n2";
                    gvList.Columns["ID"].Visible = false;
                    gvList.OptionsBehavior.Editable = true;

                    GridColumn cost = gvList.Columns["COST_INPUT"];
                    cost.OptionsColumn.AllowEdit = true;
                    cost.ColumnEdit = textEdit;
                    cost.FieldName = "txtCost";

                    GridColumn currency = gvList.Columns["CURRENCY"];
                    currency.OptionsColumn.AllowEdit = true;
                    currency.ColumnEdit = select;
                    currency.FieldName = "sltCurrency";
                }

                Init_Control(true);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }
        public override void SearchPage()
        {
            base.SearchPage();
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INPUT_COST.GET", new string[] { "A_DEPARTMENT", "A_ROLE", "A_CTG" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, sltCtg.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    dt = base.m_ResultDB.ReturnDataSet.Tables[1];
                    base.m_BindData.BindGridLookEdit(sltCtg, base.m_ResultDB.ReturnDataSet.Tables[0], "CODE", "NAME");
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[1]);

                    RepositoryItemTextEdit textEdit = new RepositoryItemTextEdit();
                    textEdit.Mask.MaskType = DevExpress.XtraEditors.Mask.MaskType.Numeric;
                    textEdit.Mask.EditMask = "n2";
                    gvList.Columns["ID"].Visible = false;
                    gvList.OptionsBehavior.Editable = true;
                    GridColumn cost = gvList.Columns["COST_INPUT"];
                    cost.OptionsColumn.AllowEdit = true;
                    cost.ColumnEdit = textEdit;
                    cost.FieldName = "txtCost";
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                sltCtg.EditValue = "NEW";
                dtEdit.Columns.Add("ID", typeof(string));
                dtEdit.Columns.Add("COST", typeof(string));
                dtEdit.Columns.Add("CODE", typeof(string));
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void gvList_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {
            dtEdit.Rows.Add(new object[] { dt.Rows[e.RowHandle]["ID"].NullString(), e.Value, dt.Rows[e.RowHandle]["CODE"].NullString() });
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (dtEdit.Rows.Count == 0)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                //WaitForm loading = new WaitForm();
                //loading.ShowDialog();

                for (int i = 0; i < dtEdit.Rows.Count; i++)
                {
                    Console.WriteLine(dtEdit.Rows[i]["ID"].NullString());
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INPUT_COST@PUT",
                    new string[] { "A_DEPARTMENT", "A_ROLE", "A_COST", "A_ID", "A_CODE", "A_CURRENCY" },
                    new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, dtEdit.Rows[i]["COST"].NullString(), dtEdit.Rows[i]["ID"].NullString(), dtEdit.Rows[i]["CODE"].NullString(), dtEdit.Rows[i]["CURRENCY"].NullString() });
                    if(base.m_ResultDB.ReturnInt != 0)
                    {
                        //loading.Close();
                    }
                }
                //loading.Close();
                dtEdit.Clear();
                MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                SearchPage();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
