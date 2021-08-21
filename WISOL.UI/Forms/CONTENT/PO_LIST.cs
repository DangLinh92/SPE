using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class PO_LIST : PageType
    {
        public PO_LIST()
        {
            InitializeComponent();
        }

        private void btnPR_list_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PO.CREATE_PO_CODE", new string[] { }, new string[] { });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    POP.PO_CREATE pop = new POP.PO_CREATE();
                    pop.PO_CODE_TEMP = data.Rows[0]["CODE"].NullString();
                    pop.Mode = Consts.MODE_NEW;
                    pop.ShowDialog();
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PO.GET_LIST", new string[] { }, new string[] { });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    gcList.DataSource = data;

                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["PO_ID_TEMP"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;
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
                string poId = gvList.GetRowCellValue(e.RowHandle, "PO_ID").NullString();
                string poIdTemp = gvList.GetRowCellValue(e.RowHandle, "PO_ID_TEMP").NullString();
                if (e.Column.FieldName == "VIEW")
                {
                    splashScreenManager1.ShowWaitForm();
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PO.GET_PR_BY_PO", new string[] { "A_PO_ID", "A_PO_TEMP" }, new string[] { poId, poIdTemp });
                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable table = m_ResultDB.ReturnDataSet.Tables[0];
                        string data = "";
                        foreach (DataRow row in table.Rows)
                        {
                            data += row["PR_CODE"] + "^";
                        }

                        data += "$" + poIdTemp + "$" + poId+"$"+Consts.MODE_VIEW;

                        Consts.mainForm.NewPageFromOtherPage("PO_EXPORT", "PO FILE", "W", "Y", data);
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                    splashScreenManager1.CloseWaitForm();
                }
                else if (e.Column.FieldName == "EDIT")
                {
                    POP.PO_CREATE pop = new POP.PO_CREATE();
                    pop.PO_CODE_TEMP = gvList.GetRowCellValue(e.RowHandle, "PO_ID_TEMP").NullString();
                    pop.PO_ID = gvList.GetRowCellValue(e.RowHandle, "PO_ID").NullString();
                    pop.Mode = Consts.MODE_UPDATE;
                    pop.ShowDialog();
                }
                else if (e.Column.FieldName == "CANCEL")
                {

                }
                else if (e.Column.FieldName == "DELETE")
                {

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {

        }
    }
}
