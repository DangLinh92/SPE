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
    public partial class MRO_SUB : PageType
    {
        public MRO_SUB()
        {
            InitializeComponent();
            this.Load += MRO_SUB_Load;
        }

        private void MRO_SUB_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "MRO_SUB");
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    gcList.DataSource = data;
                    gvList.Columns["Id"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;

                    FormatData();
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

        private void FormatData()
        {
            gvList.Columns["PLAN_MRO"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["PLAN_MRO"].DisplayFormat.FormatString = "c3";
            gvList.Columns["ACTUAL_PLAN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["ACTUAL_PLAN"].DisplayFormat.FormatString = "c3";

            gvList.Columns["OLD_COMPLETE"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["OLD_COMPLETE"].DisplayFormat.FormatString = "c3";

            gvList.Columns["ADD_ORDER"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["ADD_ORDER"].DisplayFormat.FormatString = "c3";

            gvList.Columns["TOTAL_ORDER"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["TOTAL_ORDER"].DisplayFormat.FormatString = "c3";

            gvList.Columns["REMAIN_PLAN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["REMAIN_PLAN"].DisplayFormat.FormatString = "c3";
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                if(e.Column.FieldName != "DETAIL")
                {
                    txtId.EditValue = gvList.GetRowCellValue(e.RowHandle, "Id").NullString();
                    dateMonthYear.EditValue = gvList.GetRowCellValue(e.RowHandle, "MONTH_YEAR").NullString();
                    txtPlan.EditValue = gvList.GetRowCellValue(e.RowHandle, "PLAN_MRO").NullString();
                    txtActualPlan.EditValue = gvList.GetRowCellValue(e.RowHandle, "ACTUAL_PLAN").NullString();
                    txtOldComplete.EditValue = gvList.GetRowCellValue(e.RowHandle, "OLD_COMPLETE").NullString();
                    txtAddOrder.EditValue = gvList.GetRowCellValue(e.RowHandle, "ADD_ORDER").NullString();
                    txtTotalOrder.EditValue = gvList.GetRowCellValue(e.RowHandle, "TOTAL_ORDER").NullString();
                    txtPlanOder.EditValue = gvList.GetRowCellValue(e.RowHandle, "REMAIN_PLAN").NullString();
                    cboUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
                }
                else
                {
                    POP.SHOW_ORDER popup = new POP.SHOW_ORDER();
                    popup.DateSearch = gvList.GetRowCellValue(e.RowHandle, "MONTH_YEAR").NullString();
                    popup.ShowDialog();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearData();
        }

        private void ClearData()
        {
            txtId.EditValue = "";
            dateMonthYear.EditValue = "";
            txtPlan.EditValue = "";
            txtActualPlan.EditValue = "";
            txtOldComplete.EditValue = "";
            txtAddOrder.EditValue = "";
            txtTotalOrder.EditValue = "";
            txtPlanOder.EditValue = "";
            cboUnit.EditValue = "VND";
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if(txtId.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@INIT", new string[] { "A_ID" }, new string[] { txtId.EditValue.NullString() });
                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRO_SUB@PUT",
                    new string[] { "A_ID", "A_DEPT_CODE", "A_PLAN_MRO", "A_ACTUAL", "A_OLD", "A_ADD", "A_TOLTAL", "A_REMAIN", "A_TIME", "A_UNIT" }, 
                    new string[] {
                        txtId.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        txtPlan.EditValue.NullString(),
                        txtActualPlan.EditValue.NullString(),
                        txtOldComplete.EditValue.NullString(),
                        txtAddOrder.EditValue.NullString(),
                        txtTotalOrder.EditValue.NullString(),
                        txtPlanOder.EditValue.NullString(),
                        dateMonthYear.EditValue.NullString(),
                        cboUnit.EditValue.NullString()
                    });
                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
                    ClearData();
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

        private void btnReloadData_Click(object sender, EventArgs e)
        {
            InitData();
        }
    }
}
