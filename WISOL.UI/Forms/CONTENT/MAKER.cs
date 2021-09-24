using System;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class MAKER : PageType
    {
        public string code = string.Empty;
        public MAKER()
        {
            InitializeComponent();
            this.Load += MAKER_Load;
        }

        private void MAKER_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "MAKER");
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MAKER.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MAKER.GET", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void btn_Click(object sender, EventArgs e)
        {
            POP.POP_MAKER_CREATE popup = new POP.POP_MAKER_CREATE();
            popup.ShowDialog();
            this.SearchPage();
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
                    code = gvList.GetDataRow(e.RowHandle)["CODE"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(code) != true)
            {
                POP.POP_MAKER_UPDATE popup = new POP.POP_MAKER_UPDATE(code);
                popup.ShowDialog();
                this.SearchPage();
            }
        }

        private void btnDestroy_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(code) == true)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MAKER.DELETE",
                        new string[] { "A_CODE", "A_TRANS_USER" },
                        new string[] { code, Consts.USER_INFO.Id });

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
