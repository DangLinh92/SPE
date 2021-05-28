using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Views.Grid;
using System;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class STOCKIN_CANCEL : PageType
    {
        public string code = string.Empty;
        public string id = string.Empty;
        public STOCKIN_CANCEL()
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
            base.InitializePage();
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKIN_CANCEL.INIT", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(sltSparePart, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    Init_Control(true);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
                throw;
            }
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                DateTime date = DateTime.Now;
                sltSparePart.EditValue = string.Empty;
                dtDate.EditValue = date.ToString("yyyy-MM-dd");
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKIN_CANCEL.GET", new string[] {
                    "A_SP", "A_DATE", "A_DEPARTMENT", "A_ROLE"
                }, new string[] { sltSparePart.EditValue.NullString(), dtDate.DateTime.ToString("yyyyMMdd"),Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if(base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcStockin, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvStockin.Columns["COST"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvStockin.Columns["COST"].DisplayFormat.FormatString = "n0";
                    gvStockin.Columns["QUANTITY"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvStockin.Columns["QUANTITY"].DisplayFormat.FormatString = "n0";

                    gvStockin.Columns["ID"].Visible = false;
                    gvStockin.OptionsView.GroupFooterShowMode = GroupFooterShowMode.VisibleAlways;

                    gvStockin.Columns["COST"].Group();
                    gvStockin.ExpandAllGroups();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (id == string.Empty)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_STOCKIN_CANCEL.PUT",
                        new string[] { "A_STOCKIN", "A_TRANS_USER", "A_DEPARTMENT", "A_ROLE" },
                        new string[] { id, Consts.USER_INFO.Id, Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

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

        private void gvStockin_RowCellClick(object sender, RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    id = gvStockin.GetDataRow(e.RowHandle)["ID"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
