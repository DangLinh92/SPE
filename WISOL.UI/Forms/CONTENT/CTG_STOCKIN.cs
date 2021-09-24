using System;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class CTG_STOCKIN : PageType
    {
        public CTG_STOCKIN()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();

            Classes.Common.SetFormIdToButton(this, "CTG_STOCKIN");
        }
        public override void InitializePage()
        {
            try
            {
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }
                else
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CTG_STOCKIN.GET", new string[] { "A_ROLE", "A_DEPARTMENT" }, new string[] { Consts.USER_INFO.UserRole, Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[1], "DEPARTMENT", "DEPARTMENT");
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["CREATED_AT"].Visible = false;
                    gvList.Columns["DELETED_AT"].Visible = false;
                    gvList.Columns["UPDATED_AT"].Visible = false;
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CTG_STOCKIN.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[1], "DEPARTMENT", "DEPARTMENT");
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["CREATED_AT"].Visible = false;
                    gvList.Columns["DELETED_AT"].Visible = false;
                    gvList.Columns["UPDATED_AT"].Visible = false;

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
                txtCode.EditValue = string.Empty;
                txtName.EditValue = string.Empty;
                sltDepartment.EditValue = Consts.DEPARTMENT;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCode.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CTG_STOCKIN.PUT",
                    new string[] { "A_CODE", "A_NAME", "A_DEPARTMENT", "A_TRANS_USER" },
                    new string[] { txtCode.EditValue.NullString(), txtName.EditValue.NullString(), Consts.DEPARTMENT, Consts.USER_INFO.Id });
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

        private void btnClear_Click(object sender, EventArgs e)
        {
            this.Init_Control(true);
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (txtCode.Text.Trim() == string.Empty)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_CTG_STOCKIN.DELETE", new string[] { "A_CODE", "A_TRANS_USER" }, new string[] { txtCode.EditValue.NullString(),Consts.USER_INFO.Id });
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

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    txtCode.EditValue = gvList.GetDataRow(e.RowHandle)["CODE"].NullString();
                    txtName.EditValue = gvList.GetDataRow(e.RowHandle)["NAME"].NullString();
                    sltDepartment.EditValue = gvList.GetDataRow(e.RowHandle)["DEPARTMENT"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
