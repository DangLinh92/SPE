using System;
using System.Data;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class MRP_LIST : FormType
    {
        public MRP_LIST()
        {
            InitializeComponent();
        }

        private void MRP_LIST_Load(object sender, EventArgs e)
        {
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP_LIST_GROUP.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.mResultDB.ReturnDataSet.Tables;
                    gcGroupList.DataSource = data[0];
                    base.mBindData.BindGridView(gcList, data[1]);
                    mBindData.BindGridLookEdit(stlStatus, data[2], "CODE", "NAME");
                    gvGroupList.OptionsView.ColumnAutoWidth = true;
                    gvList.OptionsView.ColumnAutoWidth = true;
                    gvGroupList.Columns["MRP_CODE"].Visible = false;
                    gvGroupList.Columns["ID"].Visible = false;
                    gvGroupList.Columns["MRP_CODE"].Group();
                    gvGroupList.Columns["col_delete"].Width = 25;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvGroupList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            try
            {
                if (e.Column.Name == "col_delete")
                {
                    string id = gvGroupList.GetRowCellValue(e.RowHandle, "ID").NullString();
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP.DETACK_MRP", new string[] { "A_ID", "A_USER" }, new string[] { id, Consts.USER_INFO.Id });
                    if (mResultDB.ReturnInt == 0)
                    {
                        gvGroupList.DeleteRow(e.RowHandle);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnGencode_Click(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP.CREATE_MRP_CODE",
                 new string[] { "A_DEPARTMENT" },
                 new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    txtMrpcode.EditValue = mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].NullString();
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void Clear()
        {
            txtMrpcode.EditValue = null;
            txtTitle.EditValue = null;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP_LIST.DELETE",
                 new string[] { "A_DEPARTMENT", "A_MRP_CODE" },
                 new string[] { Consts.DEPARTMENT, txtMrpcode.EditValue.NullString() });

                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                        Clear();
                    }
                    else
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                    }
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
                if (txtMrpcode.EditValue.NullString() == string.Empty)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP_LIST.PUT",
                new string[] { "A_DEPARTMENT", "A_MRP_CODE", "A_TITLE", "A_STATUS", "A_DATE_NEED_FINISH", "A_USER" },
                new string[] { Consts.DEPARTMENT, txtMrpcode.EditValue.NullString(), txtTitle.EditValue.NullString(), stlStatus.EditValue.NullString(), dateNeedFinish.EditValue.NullString(), Consts.USER_INFO.Id });

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
                    Clear();
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            try
            {
                txtMrpcode.EditValue = gvList.GetRowCellValue(e.RowHandle, "MRP_CODE").NullString();
                txtTitle.EditValue = gvList.GetRowCellValue(e.RowHandle, "TITLE").NullString();
                stlStatus.EditValue = gvList.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                dateNeedFinish.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_NEED_FINISH").NullString();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
