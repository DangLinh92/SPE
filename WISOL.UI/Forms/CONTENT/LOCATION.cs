using DevExpress.XtraTreeList;
using System;
using System.Data;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class LOCATION : PageType
    {
        public LOCATION()
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
                if (Consts.USER_INFO.UserRole == "ROLE_ADMIN")
                {
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }else 
                    this.lctDepartment.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "DEPARTMENT");
                    base.m_BindData.BindGridLookEdit(sltParent, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "NAME_LOCATION");

                    treeList.KeyFieldName = "CODE";
                    treeList.ParentFieldName = "PARENT";
                    base.m_BindData.BindTreeList(treeList, base.m_ResultDB.ReturnDataSet.Tables[0], false, "CODE, PARENT");

                    treeList.ExpandAll();
                }
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
                txtCode.EditValue = string.Empty;
                txtLocation.EditValue = string.Empty;
                txtFloor.EditValue = string.Empty;
                sltParent.EditValue = "0";
                sltDepartment.EditValue = Consts.DEPARTMENT;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        public override void SearchPage()
        {
            base.SearchPage();
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    treeList.KeyFieldName = "CODE";
                    treeList.ParentFieldName = "PARENT";

                    base.m_BindData.BindTreeList(treeList, base.m_ResultDB.ReturnDataSet.Tables[0], false, "CODE", "PARENT");

                    treeList.ExpandAll();

                    base.m_BindData.BindGridLookEdit(sltDepartment, base.m_ResultDB.ReturnDataSet.Tables[1], "DEPARTMENT", "DEPARTMENT");
                    base.m_BindData.BindGridLookEdit(sltParent, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "NAME_LOCATION");

                    this.Init_Control(true);
                }
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
                if (String.IsNullOrEmpty(txtCode.EditValue.NullString()) == true || string.IsNullOrEmpty(txtLocation.EditValue.NullString()) == true)
                {
                    MsgBox.Show("MSG_ERR_102".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.PUT",
                    new string[] { "A_CODE", "A_LOCATION", "A_PARENT", "A_DEPARTMENT", "A_TRANS_USER", "A_FLOOR" },
                    new string[] { txtCode.EditValue.NullString(), txtLocation.EditValue.NullString(), sltParent.EditValue.NullString(), sltDepartment.EditValue.NullString(), Consts.USER_INFO.Id, txtFloor.EditValue.NullString() });
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
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.DELETE",
                        new string[] { "A_CODE", "A_TRANS_USER" },
                        new string[] { txtCode.EditValue.NullString(), Consts.USER_INFO.Id });

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

        private void treeList_RowCellClick(object sender, DevExpress.XtraTreeList.RowCellClickEventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.SHOW"
                    , new string[] { "A_CODE"
                    }
                    , new string[] {(string)e.Node.GetValue("CODE")
                    }
                    );
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable dt = base.m_ResultDB.ReturnDataSet.Tables[0];
                    txtCode.EditValue = dt.Rows[0]["CODE"].NullString();
                    txtLocation.EditValue = dt.Rows[0]["LOCATION"].NullString();
                    txtFloor.EditValue = dt.Rows[0]["FLOOR"].NullString();
                    sltDepartment.EditValue = dt.Rows[0]["DEPARTMENT"].NullString();
                    sltParent.EditValue = dt.Rows[0]["PARENT"].NullString();

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            POP.POP_LOCATION_LABEL popup = new POP.POP_LOCATION_LABEL();
            popup.ShowDialog();
            this.SearchPage();
        }
    }
}
