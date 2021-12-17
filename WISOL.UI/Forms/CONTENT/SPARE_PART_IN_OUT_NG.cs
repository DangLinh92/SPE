using DevExpress.XtraTab;
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
    public partial class SPARE_PART_IN_OUT_NG : PageType
    {
        public SPARE_PART_IN_OUT_NG()
        {
            InitializeComponent();
            this.Load += SPARE_PART_IN_OUT_NG_Load;
        }

        private void SPARE_PART_IN_OUT_NG_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "SPARE_PART_IN_OUT_NG");
            cheInput.Checked = true;
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.INIT",
                    new string[] { "A_DEPARTMENT" },
                    new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection tableCollection = m_ResultDB.ReturnDataSet.Tables;

                    m_BindData.BindGridLookEdit(stlKho, tableCollection[0], "CODE", "NAME");

                    stlKho.EditValue = tableCollection[0].Rows[0]["CODE"].NullString();

                    m_BindData.BindGridLookEdit(stlSparepart, tableCollection[1], "CODE", "NAME_VI");
                    m_BindData.BindGridLookEdit(stlSparepartMove, tableCollection[1], "CODE", "NAME_VI");
                    m_BindData.BindGridLookEdit(stlLocationOld, tableCollection[2], "CODE", "CODE");
                    m_BindData.BindGridLookEdit(stlLocation_New, tableCollection[2], "CODE", "CODE");
                    m_BindData.BindGridLookEdit(stlVitri, tableCollection[2], "CODE", "CODE");

                    m_BindData.BindGridView(gcList, tableCollection[3]);
                    m_BindData.BindGridView(gcLocation, tableCollection[4]);
                    m_BindData.BindGridView(gcInventory, tableCollection[5]);

                    gvList.Columns["ID"].Visible = false;
                    gvLocation.Columns["ID"].Visible = false;

                    gvList.OptionsView.ColumnAutoWidth = true;
                    gvLocation.OptionsView.ColumnAutoWidth = true;
                    gvInventory.OptionsView.ColumnAutoWidth = true;
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

        private void cheInput_CheckedChanged(object sender, EventArgs e)
        {
            cheOutput.Checked = !cheInput.Checked;
            stlVitri.Enabled = !cheInput.Checked;
        }

        private void cheOutput_CheckedChanged(object sender, EventArgs e)
        {
            cheInput.Checked = !cheOutput.Checked;
            stlVitri.Enabled = !cheInput.Checked;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string inout = "";
                if (cheInput.Checked)
                {
                    inout = "IN";
                    stlVitri.EditValue = "";
                }
                else if (cheOutput.Checked)
                {
                    inout = "OUT";
                }

                if (inout == "" ||
                    stlKho.EditValue.NullString() == "" ||
                    stlSparepart.EditValue.NullString() == "" ||
                    stlUnit.EditValue.NullString() == "" ||
                    txtQuantity.EditValue.NullString() == "" ||
                    dateInOut.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.PUT",
                    new string[]
                    {
                        "A_ID",
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_SPARE_PART",
                        "A_UNIT",
                        "A_QUANTITY",
                        "A_DATE",
                        "A_USER",
                        "A_IN_OUT",
                        "A_LOCATION"
                    },
                    new string[]
                    {
                        txtID.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        stlSparepart.EditValue.NullString(),
                        stlUnit.EditValue.NullString(),
                        txtQuantity.EditValue.NullString(),
                        dateInOut.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                        inout,
                        stlVitri.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
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

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.DELETE",
                   new string[]
                   {
                        "A_ID",
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_USER",
                   },
                   new string[]
                   {
                        txtID.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                   });

                    if (base.m_ResultDB.ReturnInt == 0)
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

        private void btnClear_Click(object sender, EventArgs e)
        {
            txtID.EditValue = "";
            stlSparepart.EditValue = "";
            txtQuantity.EditValue = "";
            stlUnit.EditValue = "";
            stlVitri.EditValue = "";
            dateInOut.EditValue = "";
            txtUser.EditValue = "";
        }

        private void btnSaveMove_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlSparepartMove.EditValue.NullString() == "" ||
                    stlKho.EditValue.NullString() == "" ||
                    stlLocationOld.EditValue.NullString() == stlLocation_New.EditValue.NullString() ||
                    txtQuantityMove.EditValue.NullString() == "" ||
                    stlUnitMove.EditValue.NullString() == "" ||
                     float.Parse(txtQuantityMove.EditValue.NullString()) == 0)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_NG.MOVE_LOCATION",
                 new string[]
                 {
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_SPAREPARTS",
                        "A_LOCATION_OLD",
                        "A_LOCATION_NEW",
                        "A_QUANTITY",
                        "A_UNIT"
                 },
                 new string[]
                 {
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        stlSparepartMove.EditValue.NullString(),
                        stlLocationOld.EditValue.NullString(),
                        stlLocation_New.EditValue.NullString(),
                        txtQuantityMove.EditValue.NullString(),
                        stlUnitMove.EditValue.NullString()
                 });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
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

        private void btnClearMove_Click(object sender, EventArgs e)
        {
            stlSparepartMove.EditValue = "";
            stlLocationOld.EditValue = "";
            stlLocation_New.EditValue = "";
            txtQuantityMove.EditValue = "";
            stlUnitMove.EditValue = "";
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            txtID.EditValue = gvList.GetRowCellValue(e.RowHandle, "ID").NullString();
            stlSparepart.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
            txtQuantity.EditValue = gvList.GetRowCellValue(e.RowHandle, "QUANTITY").NullString();
            stlUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
            stlVitri.EditValue = "";
            dateInOut.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE").NullString();
            string inOut = gvList.GetRowCellValue(e.RowHandle, "IN_OUT").NullString();

            if (inOut == "IN")
            {
                cheInput.Checked = true;
            }
            else if (inOut == "OUT")
            {
                cheOutput.Checked = true;
            }
        }

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepart.EditValue.NullString(), stlUnit, m_BindData);
            Classes.Common.GetLocationBySparepart(stlSparepart.EditValue.NullString(), stlVitri, m_BindData);
        }

        private void stlSparepartMove_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepartMove.EditValue.NullString(), stlUnitMove, m_BindData);
            Classes.Common.GetLocationBySparepart(stlSparepartMove.EditValue.NullString(), stlLocationOld, m_BindData);
        }

        private void gvLocation_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            stlSparepartMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
            stlLocationOld.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "LOCATION_CODE").NullString();
            txtQuantityMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "QUANTITY").NullString();
            stlUnitMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "UNIT").NullString();
        }

        private void MainTabControl_TabIndexChanged(object sender, EventArgs e)
        {

        }

        private void MainTabControl_Click(object sender, EventArgs e)
        {

        }

        private void MainTabControl_SelectedPageChanged(object sender, DevExpress.XtraTab.TabPageChangedEventArgs e)
        {
            var obj = e.Page as XtraTabPage;
            if(obj.Name == "TabHistory")
            {
                btnSave.Enabled = true;
                btnDelete.Enabled = true;
            }
            else
            {
                btnSave.Enabled = false;
                btnDelete.Enabled = false;
            }

            if(obj.Name == "TabPageLocation")
            {
                btnSaveMove.Enabled = true;
            }
            else
            {
                btnSaveMove.Enabled = false;
            }
        }
    }
}
