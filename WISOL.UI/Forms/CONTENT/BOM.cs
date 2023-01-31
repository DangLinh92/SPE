using DevExpress.XtraEditors.Repository;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Columns;
using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;
using DialogType = Wisol.Components.DialogType;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class BOM : PageType
    {
        public BOM()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();

            Classes.Common.SetFormIdToButton(this, "BOM");
        }
        public override void InitializePage()
        {
            try
            {
                Init_Control();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }

        string lineNumber = "7";

        private void Init_Control()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection table = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridView(gcList, table[2]);
                    m_BindData.BindGridLookEdit(stlSparepart, table[0], "CODE", "NAME");
                    m_BindData.BindGridLookEdit(stlUnit, table[1], "CODE", "NAME");

                    gvList.OptionsView.ColumnAutoWidth = true;

                    if(table[3].Rows.Count > 0)
                    {
                        txtSanLuong.Text = table[3].Rows[0]["SANLUONG"].NullString();
                        dateSanLuongFrom.EditValue = table[3].Rows[0]["FROM_TIME"].NullString();
                        dateSanLuongTo.EditValue = table[3].Rows[0]["TO_TIME"].NullString();

                        if (table[3].Rows[0]["LINE_NUMBER"].NullString() != "")
                        {
                            lineNumber = table[3].Rows[0]["LINE_NUMBER"].NullString();
                            txtLine.EditValue = lineNumber;
                        }
                    }
                }

                txtLine.EditValue = lineNumber;
                txtWorkingday.EditValue = 26;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCreate_Click(object sender, EventArgs e)
        {
        }

        private void gvList_InitNewRow(object sender, DevExpress.XtraGrid.Views.Grid.InitNewRowEventArgs e)
        {
            gvList.SetRowCellValue(e.RowHandle, gvList.Columns["YN"], true);
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
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM_SPAREPART.GET", new string[] { "A_DEPARTMENT", "A_SPARE_PART_CODE" }, new string[] { Consts.DEPARTMENT, gvList.GetRowCellValue(e.RowHandle, gvList.Columns["CODE"]).NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTableCollection table = base.m_ResultDB.ReturnDataSet.Tables;
                        if (table[0].Rows.Count > 0)
                        {
                            m_BindData.BindGridLookEdit(stlUnit, table[1], "CODE", "NAME");

                            stlUnit.EditValue = table[0].Rows[0]["UNIT"].NullString();
                            stlSparepart.EditValue = table[0].Rows[0]["CODE"].NullString();
                            txtQuantityInpack.EditValue = table[0].Rows[0]["QUANTITY_IN_PACK"].NullString();
                            txtWorkingday.EditValue = (table[0].Rows[0]["WORKING_DAY_NUMBER"].NullString() == "" ? "26" : table[0].Rows[0]["WORKING_DAY_NUMBER"].NullString());
                            txtLine.EditValue = (table[0].Rows[0]["WORKING_LINE_NUMBER"].NullString() == "" ? lineNumber : table[0].Rows[0]["WORKING_LINE_NUMBER"].NullString());
                            txtAlineWithEa.EditValue = table[0].Rows[0]["WORKING_A_LINE"].NullString();
                            txtMonthlyUsing.EditValue = table[0].Rows[0]["WORKING_A_MONTH"].NullString();
                            txtAlineWithPack.EditValue = table[0].Rows[0]["WORKING_A_LINE_PACK"].NullString();

                            if (table[0].Rows[0]["RATE"].NullString() != "")
                            {
                                txtRate.EditValue = table[0].Rows[0]["RATE"].NullString();
                            }
                            else
                            {
                                txtRate.EditValue = "1";
                            }

                            if (table[0].Rows[0]["FROM_TIME"].NullString() != "")
                            {
                                dateFrom.EditValue = table[0].Rows[0]["FROM_TIME"].NullString();
                            }
                            else
                            {
                                dateFrom.EditValue = null;
                            }

                            if (table[0].Rows[0]["TO_TIME"].NullString() != "")
                            {
                                dateTo.EditValue = table[0].Rows[0]["TO_TIME"].NullString();
                            }
                            else
                            {
                                dateTo.EditValue = null;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_Click(object sender, EventArgs e)
        {

        }

        private void btnCreate_Click_1(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlSparepart.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtQuantityInpack.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtWorkingday.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtLine.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtAlineWithEa.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtAlineWithPack.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtMonthlyUsing.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (txtRate.EditValue.NullString() == "")
                {
                    txtRate.EditValue = 1;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM_SPAREPART.PUT",
                new string[] {
                    "A_DEPARTMENT",
                    "A_SPARE_PART_CODE",
                    "A_QUANTITY_IN_PACK",
                    "A_UNIT",
                    "A_WORKING_DAY",
                    "A_LINE",
                    "A_WORKING_A_LINE",
                    "A_WORKING_A_LINE_PACK",
                    "A_MONTHLY_USING",
                    "A_RATE","A_TIME_FROM","A_TIME_TO"
                },
                new string[] {
                    Consts.DEPARTMENT,
                    stlSparepart.EditValue.NullString(),
                    txtQuantityInpack.EditValue.NullString(),
                    stlUnit.EditValue.NullString(),
                    txtWorkingday.EditValue.NullString(),
                    txtLine.EditValue.NullString(),
                    txtAlineWithEa.EditValue.NullString(),
                    txtAlineWithPack.EditValue.NullString(),
                    txtMonthlyUsing.EditValue.NullString(),
                    txtRate.EditValue.NullString(),
                    dateFrom.EditValue.NullString(),
                    dateTo.EditValue.NullString()
                });

                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    Init_Control();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtAlineWithEa_EditValueChanged(object sender, EventArgs e)
        {
            SetMonthUsing();
        }

        private void SetMonthUsing()
        {
            try
            {
                if (txtQuantityInpack.EditValue.NullString() != "" && float.TryParse(txtQuantityInpack.EditValue.NullString(), out float quantityInPack))
                {
                    if (float.TryParse(txtAlineWithEa.EditValue.NullString(), out float alineWithEa))
                    {
                        txtAlineWithPack.EditValue = Math.Round(alineWithEa / quantityInPack, 3);

                        if (txtWorkingday.EditValue.NullString() != "" && float.TryParse(txtWorkingday.EditValue.NullString(), out float workingDay))
                        {
                            if (txtLine.EditValue.NullString() != "" && float.TryParse(txtLine.EditValue.NullString(), out float line))
                            {
                                txtMonthlyUsing.EditValue = Math.Round(workingDay * line * alineWithEa / quantityInPack, 3);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlSparepart.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM_SPAREPART.DELETE",
                                new string[] {
                    "A_DEPARTMENT",
                    "A_SPARE_PART_CODE"
                                },
                                new string[] {
                    Consts.DEPARTMENT,
                    stlSparepart.EditValue.NullString()
                                });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        Init_Control();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            stlSparepart.EditValue = null;
            stlSparepart.EditValue = null;
            txtQuantityInpack.EditValue = 0;
            stlUnit.EditValue = null;
            txtWorkingday.EditValue = 26;
            txtLine.EditValue = lineNumber;
            txtAlineWithEa.EditValue = 0;
            txtAlineWithPack.EditValue = 0;
            txtMonthlyUsing.EditValue = 0;
            txtRate.EditValue = 1;
        }

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (stlSparepart.EditValue.NullString() == "")
                {
                    return;
                }
                else
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM_SPAREPART.GET", new string[] { "A_DEPARTMENT", "A_SPARE_PART_CODE" }, new string[] { Consts.DEPARTMENT, stlSparepart.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTableCollection table = base.m_ResultDB.ReturnDataSet.Tables;
                        if (table[0].Rows.Count > 0)
                        {
                            m_BindData.BindGridLookEdit(stlUnit, table[1], "CODE", "NAME");

                            stlUnit.EditValue = table[0].Rows[0]["UNIT"].NullString();
                            stlSparepart.EditValue = table[0].Rows[0]["CODE"].NullString();
                            txtQuantityInpack.EditValue = table[0].Rows[0]["QUANTITY_IN_PACK"].NullString();
                            txtWorkingday.EditValue = (table[0].Rows[0]["WORKING_DAY_NUMBER"].NullString() == "" ? "26" : table[0].Rows[0]["WORKING_DAY_NUMBER"].NullString());
                            txtLine.EditValue = (table[0].Rows[0]["WORKING_LINE_NUMBER"].NullString() == "" ? lineNumber : table[0].Rows[0]["WORKING_LINE_NUMBER"].NullString());
                            txtAlineWithEa.EditValue = table[0].Rows[0]["WORKING_A_LINE"].NullString();
                            txtMonthlyUsing.EditValue = table[0].Rows[0]["WORKING_A_MONTH"].NullString();
                            txtAlineWithPack.EditValue = table[0].Rows[0]["WORKING_A_LINE_PACK"].NullString();

                            if (table[0].Rows[0]["RATE"].NullString() != "")
                            {
                                txtRate.EditValue = table[0].Rows[0]["RATE"].NullString();
                            }
                            else
                            {
                                txtRate.EditValue = "1";
                            }

                            if (table[0].Rows[0]["FROM_TIME"].NullString() != "")
                            {
                                dateFrom.EditValue = table[0].Rows[0]["FROM_TIME"].NullString();
                            }
                            else
                            {
                                dateFrom.EditValue = null;
                            }

                            if (table[0].Rows[0]["TO_TIME"].NullString() != "")
                            {
                                dateTo.EditValue = table[0].Rows[0]["TO_TIME"].NullString();
                            }
                            else
                            {
                                dateTo.EditValue = null;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtWorkingday_EditValueChanged(object sender, EventArgs e)
        {
            SetMonthUsing();
        }

        private void txtLine_EditValueChanged(object sender, EventArgs e)
        {
            SetMonthUsing();
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "MIN_STOCK_PACK")
            {
                e.Appearance.BackColor = Color.FromArgb(212, 239, 223);
            }
            else if (e.Column.FieldName == "WORKING_A_MONTH")
            {
                e.Appearance.BackColor = Color.FromArgb(253, 235, 208);
            }
            else if (e.Column.FieldName == "WORKING_A_LINE_PACK")
            {
                e.Appearance.BackColor = Color.FromArgb(253, 242, 233);
            }
        }

        private void btnSaveSanLuong_Click(object sender, EventArgs e)
        {
            if (txtSanLuong.EditValue.NullString() == "" || dateSanLuongFrom.EditValue.NullString() == "" || dateSanLuongTo.EditValue.NullString() == "")
            {
                MsgBox.Show("Nhập thông tin sản lượng, thời gian!", MsgType.Error);
                return;
            }

            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_BOM_SANLUONG.PUT",
                new string[] { "A_DEPARTMENT", "A_SANLUONG", "A_DATE_FROM", "A_DATE_TO" },
                new string[]
                {
                    Consts.DEPARTMENT,
                    txtSanLuong.EditValue.NullString(),
                    dateSanLuongFrom.EditValue.NullString(),
                    dateSanLuongTo.EditValue.NullString()
                });

            if (m_ResultDB.ReturnInt == 0)
            {
                MsgBox.Show("Update Success!", MsgType.Information);
                Init_Control();
            }
            else
            {
                MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                return;
            }
        }
    }
}
