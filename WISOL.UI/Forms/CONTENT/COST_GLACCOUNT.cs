using System;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms
{
    public partial class COST_GLACCOUNT : PageType
    {
        public COST_GLACCOUNT()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();

            Classes.Common.SetFormIdToButton(this, "COST_GLACCOUNT");
        }
        public override void InitializePage()
        {
            try
            {

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_COST_CTR.GET", new string[] { "A_ROLE", "A_DEPARTMENT" }, new string[] { Consts.USER_INFO.UserRole, Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcCtr, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvCtr.Columns["ID"].Visible = false;
                    gvCtr.Columns["CREATED_AT"].Visible = false;
                    gvCtr.Columns["DELETED_AT"].Visible = false;
                    gvCtr.Columns["UPDATED_AT"].Visible = false;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GL_ACCOUNT.GET", new string[] { "A_ROLE", "A_DEPARTMENT" }, new string[] { Consts.USER_INFO.UserRole, Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcGlaccount, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvGlaccount.Columns["ID"].Visible = false;
                    gvGlaccount.Columns["CREATED_AT"].Visible = false;
                    gvGlaccount.Columns["DELETED_AT"].Visible = false;
                    gvGlaccount.Columns["UPDATED_AT"].Visible = false;
                }
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_COST_CTR.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcCtr, base.m_ResultDB.ReturnDataSet.Tables[0]);

                    gvCtr.Columns["ID"].Visible = false;
                    gvCtr.Columns["CREATED_AT"].Visible = false;
                    gvCtr.Columns["DELETED_AT"].Visible = false;
                    gvCtr.Columns["UPDATED_AT"].Visible = false;

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GL_ACCOUNT.GET", new string[] { "A_ROLE", "A_DEPARTMENT" }, new string[] { Consts.USER_INFO.UserRole, Consts.DEPARTMENT });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        base.m_BindData.BindGridView(gcGlaccount, base.m_ResultDB.ReturnDataSet.Tables[0]);
                        gvGlaccount.Columns["ID"].Visible = false;
                        gvGlaccount.Columns["CREATED_AT"].Visible = false;
                        gvGlaccount.Columns["DELETED_AT"].Visible = false;
                        gvGlaccount.Columns["UPDATED_AT"].Visible = false;
                    }
                    this.Init_Control(true);
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
                txtCostCtr.EditValue = string.Empty;
                txtGlaccount.EditValue = string.Empty;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            
        }

        private void btnSaveCTR_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCostCtr.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_COST_CTR.PUT",
                    new string[] { "A_COST_CTR", "A_USER_ID", "A_DEPARTMENT"},
                    new string[] { txtCostCtr.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.Id });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    SearchPage();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnSave_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtGlaccount.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GL_ACCOUNT.PUT",
                    new string[] { "A_GL_ACCOUNT", "A_USER_ID", "A_DEPARTMENT" },
                    new string[] { txtGlaccount.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.Id });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    SearchPage();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvCtr_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    txtCostCtr.EditValue = gvCtr.GetDataRow(e.RowHandle)["COST_CTR"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvGlaccount_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    txtGlaccount.EditValue = gvGlaccount.GetDataRow(e.RowHandle)["GL_ACCOUNT"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDelete_Click_1(object sender, EventArgs e)
        {
            if (txtCostCtr.Text.Trim() == string.Empty)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_COST_CTR.DELETE", new string[] { "A_COST_CTR", "A_DEPARTMENT", "A_ROLE" }, new string[] { txtCostCtr.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        SearchPage();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                    }
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
        }

        private void btnDelete1_Click(object sender, EventArgs e)
        {
            if (txtGlaccount.Text.Trim() == string.Empty)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GL_ACCOUNT.DELETE", new string[] { "A_GL_ACCOUNT", "A_DEPARTMENT", "A_ROLE" }, new string[] { txtGlaccount.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        SearchPage();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                    }
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
        }
    }
}
