using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.MES.Inherit;
using Wisol.Common;
using Wisol.Components;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class INVENTORY_SHEET : PageType
    {
        public INVENTORY_SHEET()
        {
            InitializeComponent();
            this.Load += INVENTORY_SHEET_Load;
        }

        private void INVENTORY_SHEET_Load(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_KHO.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection dataKho = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridLookEdit(stlKho, dataKho[0], "CODE", "NAME");
                    string firstValue = dataKho[0].Rows[0]["CODE"].NullString();
                    stlKho.EditValue = firstValue;

                    InitData();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_SHEET.GET", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    gcList.DataSource = data[0];
                    //base.m_BindData.BindGridView(gcList, data[0]);
                    gvList.OptionsView.ColumnAutoWidth = true;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            InitData();
        }

        private void btnCreateSheet_Click(object sender, EventArgs e)
        {
            POP.INVENTORY_SHEET_DETAIL pop = new POP.INVENTORY_SHEET_DETAIL();
            pop.Kho = stlKho.EditValue.NullString();
            pop.Mode = Consts.MODE_NEW;
            pop.ShowDialog();
            InitData();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (dateFrom.EditValue.NullString() == "" || dateTo.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_SHEET.SEARCH_BY_TIME", new string[] { "A_FROM_TIME", "A_TO_TIME", "A_DEPT_CODE", "A_STOCK" }, new string[] { dateFrom.EditValue.NullString(), dateTo.EditValue.NullString(), Consts.DEPARTMENT, stlKho.EditValue.NullString() });
                if (m_ResultDB.ReturnInt == 0)
                {
                    if (m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                        gcList.DataSource = data[0];
                        gvList.OptionsView.ColumnAutoWidth = true;
                    }
                    else
                    {
                        MsgBox.Show("KHÔNG TỒN TẠI DỮ LIỆU CẦN TÌM", MsgType.Information);
                    }
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                if (e.Column.FieldName == "EDIT")
                {
                    POP.INVENTORY_SHEET_DETAIL pop = new POP.INVENTORY_SHEET_DETAIL();
                    pop.Kho = stlKho.EditValue.NullString();
                    pop.Mode = Consts.MODE_UPDATE;
                    pop.SheetId = gvList.GetRowCellValue(e.RowHandle, "SHEET_ID").NullString();
                    pop.TimeFrom = gvList.GetRowCellValue(e.RowHandle, "DATE_START").NullString();
                    pop.TimeTo = gvList.GetRowCellValue(e.RowHandle, "DATE_END").NullString();
                    pop.Title = gvList.GetRowCellValue(e.RowHandle, "TITLE").NullString();
                    pop.ShowDialog();
                    InitData();
                }
                else if (e.Column.FieldName == "DELETE")
                {
                    DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_SHEET.DELETE",
                            new string[] { "A_DEPARTMENT", "A_STOCK_CODE", "A_SHEET_ID" },
                            new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), gvList.GetRowCellValue(e.RowHandle, "SHEET_ID").NullString() });

                        if (m_ResultDB.ReturnInt == 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString, MsgType.Information);
                            InitData();
                        }
                        else
                        {
                            MsgBox.Show(m_ResultDB.ReturnString, MsgType.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
