using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Classes;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class LOCATION : PageType
    {
        private bool firstLoad = true;
        public LOCATION()
        {
            InitializeComponent();
        }

        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            firstLoad = false;
        }

        public override void InitializePage()
        {
            try
            {
                Classes.Common.SelectPrinter(cboPrinter);
                Classes.Common.SetFormIdToButton(this, "LOCATION");

                Init_Control();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }

        public override void ReloadData()
        {
            if (firstLoad && cheAutoRefresh.Checked)
            {
                InitializePage();
            }
            firstLoad = true;
        }

        private void Init_Control()
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

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_INIT.GET", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                        base.m_BindData.BindGridLookEdit(stlPosition, data[0], "CODE", "CODE");
                        base.m_BindData.BindGridLookEdit(stlNew_Location, data[0], "CODE", "CODE");
                        base.m_BindData.BindGridLookEdit(stlCondition, data[2], "CODE", "NAME");
                        base.m_BindData.BindGridLookEdit(stlConditionMove, data[2], "CODE", "NAME");
                        base.m_BindData.BindGridLookEdit(stlUnit, data[3], "CODE", "NAME");
                        base.m_BindData.BindGridLookEdit(stlUnitMove, data[3], "CODE", "NAME");
                        base.m_BindData.BindGridLookEdit(stlSparepart, data[4], "CODE", "NAME_VI");
                        base.m_BindData.BindGridLookEdit(stlSparepartCode_Move, data[4], "CODE", "NAME_VI");
                        base.m_BindData.BindGridLookEdit(stlSparePartSearch, data[4], "CODE", "NAME_VI");
                    }

                    m_BindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");

                    SettingDefaultValueControl();

                    ViewLocation();

                    GetLabelTemplate();
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

        private void GetLocationForCombobox()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_INIT.GET", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];
                    base.m_BindData.BindGridLookEdit(stlPosition, data, "CODE", "CODE");
                    base.m_BindData.BindGridLookEdit(stlNew_Location, data, "CODE", "CODE");
                }
                else{
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void SettingDefaultValueControl()
        {
            rdoChoose.EditValue = "2";// normal add position

            ActiveInactiveControl();

            cheIsWait.Checked = false;
            stlPosition.EditValue = string.Empty;
            stlSparepart.EditValue = string.Empty;
            txtQuantity.EditValue = "0";
            stlUnit.EditValue = string.Empty;
            txtQuantityNewAdd.EditValue = "0";
            stlCondition.EditValue = Consts.CONDITION_DEFAULT;
            dateInputTime.EditValue = DateTime.Now;
            txtPoNo.EditValue = string.Empty;
            txtQuantity.Enabled = false;
        }

        private void ActiveInactiveControl()
        {
            if ("1".Equals(rdoChoose.EditValue.NullString()))// add quick
            {
                txtposition1.Enabled = false;
                //txtPosition2.Enabled = false;

                loStartPosition.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                loSquareNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                loPositionNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
            }
            else
            {
                txtposition1.Enabled = true;
                //txtPosition2.Enabled = true;

                loStartPosition.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                loSquareNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                loPositionNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
            }
        }

        private void AddNewLocation()
        {
            // add quick
            if ("1".Equals(rdoChoose.EditValue.NullString()))
            {
                if (
                    string.IsNullOrEmpty(txtStartPosition.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtsquare.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtPositionNumber.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                int squareNumber = int.Parse(txtsquare.EditValue.NullString());
                int positionNumber = int.Parse(txtPositionNumber.EditValue.NullString());
                int startPositionNumber = int.Parse(txtStartPosition.EditValue.NullString());

                DataTable LOCATION_TYPE = new DataTable();
                LOCATION_TYPE.Columns.Add("CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("STOCK_CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("DEPT_CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("RACK_CODE", typeof(string));

                string stockCode = stlKho.EditValue.NullString();
                string codeLocation = string.Empty;
                string position1 = string.Empty;

                for (int j = startPositionNumber; j < startPositionNumber + squareNumber; j++)
                {
                    position1 = CreateNumberCode(j);

                    for (int k = 1; k <= positionNumber; k++)
                    {
                        codeLocation = position1 + "-" + CreateNumberCode(k);
                        LOCATION_TYPE.Rows.Add(codeLocation, stockCode, Consts.DEPARTMENT, string.Empty);
                    }
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_LOCATION.INSERT_BATCH", new string[] { }, "@A_LOCATION_TYPE", new string[] { }, LOCATION_TYPE);

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtposition1.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (txtposition1.EditValue.NullString().Contains(".") || txtposition1.EditValue.NullString().Contains("$") || txtposition1.EditValue.NullString().Contains("_"))
                {
                    MsgBox.Show("Vị trí không được chứa ký tự . $ _".Translation(), MsgType.Warning);
                    return;
                }

                string codeLocation = txtposition1.EditValue.NullString();

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.INSERT_SINGLE", new string[] { "A_CODE", "A_STOCK_CODE", "A_DEPT_CODE" }, new string[] { codeLocation, stlKho.EditValue.NullString(), Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    txtposition1.EditValue = null;
                    ViewLocation();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
        }

        private void ViewLocation()
        {
            try
            {
                DataTableCollection dataLocations = GetLocations();
                if (dataLocations != null)
                {
                    //base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    base.m_BindData.BindGridView(gcList, dataLocations[0]);
                    if (dataLocations[0].Rows.Count > 0)
                    {
                        gvList.Columns["KHO"].Visible = false;
                        gvList.Columns["LOCATION"].Width = 230;
                        gvList.MakeRowVisible(gvList.DataRowCount - 1);
                    }

                    //base.m_BindData.BindGridView(gcListNoPosition, base.m_ResultDB.ReturnDataSet.Tables[1]);
                    base.m_BindData.BindGridView(gcListNoPosition, dataLocations[1]);
                    if (dataLocations[1].Rows.Count > 0)
                    {
                        gvListNoPosition.Columns["KHO"].Visible = false;
                        gvListNoPosition.Columns["STT"].Visible = false;
                        gvListNoPosition.Columns["BARCODE"].Visible = false;
                        gvListNoPosition.Columns["QUANTITY_PRINT_LABEL"].Visible = false;

                        gvListNoPosition.OptionsSelection.MultiSelect = true;
                        gvListNoPosition.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                        gvListNoPosition.OptionsBehavior.Editable = true;
                        gvListNoPosition.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["SPARE_PART_CODE"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["NAME_VI"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["CONDITION_NAME"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["UNIT"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["EXPIRED_DATE"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["QUANTITY_PRINT_LABEL"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["PO_NO"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.BestFitColumns();
                        //gvListNoPosition.OptionsView.ColumnAutoWidth = true;

                        gvListNoPosition.Columns.Where(x => x.VisibleIndex <= gvListNoPosition.Columns["NAME_VI"].VisibleIndex).ToList().ForEach(x => x.Fixed = DevExpress.XtraGrid.Columns.FixedStyle.Left);
                    }

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private DataTableCollection GetLocations()
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET", new string[] { "A_DEPARTMENT", "A_STOCK" }, new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                return base.m_ResultDB.ReturnDataSet.Tables;
            }
            return null;
        }

        private string CreateNumberCode(int number)
        {
            if (number <= 9) return "0" + number;
            return string.Empty + number;
        }

        public override void SearchPage()
        {
            base.SearchPage();
        }

        private void radioGroup1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActiveInactiveControl();
        }

        private void cheIsWait_CheckedChanged(object sender, EventArgs e)
        {
            if (cheIsWait.Checked)
            {
                stlPosition.Enabled = false;
                stlPosition.EditValue = null;
            }
            else
            {
                stlPosition.Enabled = true;
            }
        }

        private void btnSaveNewLocation_Click(object sender, EventArgs e)
        {
            try
            {
                AddNewLocation();

                // View UI
                ViewLocation();

                // update location and rack in combobox
                GetLocationForCombobox();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearLocationNew_Click(object sender, EventArgs e)
        {
            txtsquare.EditValue = null;
            txtPositionNumber.EditValue = null;
            txtposition1.EditValue = null;
            txtStartPosition.EditValue = null;
        }

        private void txtSearch_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Vị trí") args.IsSearchColumn = false;
        }

        private void btnDeleteLocation_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) || string.IsNullOrEmpty(txtposition1.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    rdoChoose.EditValue = "2";
                    txtposition1.Focus();
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    string codeLocation = txtposition1.EditValue.NullString();
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.DELETE", new string[] { "A_CODE", "A_DEPARTMENT", "A_STOCK" }, new string[] { codeLocation, Consts.DEPARTMENT, stlKho.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);

                        txtposition1.EditValue = null;

                        // reload location in grid
                        ViewLocation();

                        // update location and rack in combobox
                        GetLocationForCombobox();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            if (e.RowHandle < 0)
            {
                txtSearchNoLocation.EditValue = null;
                return;
            }
            else
            {
                string location = gvList.GetDataRow(e.RowHandle)["LOCATION"].NullString();
                txtSearchNoLocation.EditValue = location;
                txtposition1.EditValue = location;//.Split('-')[0];
                //txtPosition2.EditValue = location.Split('-')[1];
            }
        }

        private void btnSaveLocation_Sparepart_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlPosition.EditValue.NullString()) && cheIsWait.Checked == false
                    || string.IsNullOrEmpty(stlSparepart.EditValue.NullString())
                    || (string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && string.IsNullOrEmpty(txtQuantityNewAdd.EditValue.NullString()))
                    || string.IsNullOrEmpty(stlUnit.EditValue.NullString())
                    || string.IsNullOrEmpty(stlCondition.EditValue.NullString())
                    || string.IsNullOrEmpty(dateInputTime.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
                {
                    txtQuantity.EditValue = "0";
                }

                if (string.IsNullOrEmpty(txtQuantityNewAdd.EditValue.NullString()))
                {
                    txtQuantityNewAdd.EditValue = "0";
                }

                float quantity = float.Parse(txtQuantity.EditValue.NullString()) + float.Parse(txtQuantityNewAdd.EditValue.NullString());

                string barcode = string.Empty;

                string DateExpired = "2199-01-01";
                if (cheHasDateExpired.Checked)
                {
                    DateExpired = dateExpiredTime.Text.NullString();
                }

                //if (!(cheEditQuantity.Checked && txtQuantity.Enabled))
                //{
                //    string message;
                //    bool checkRemain = CheckRemainQuantity(out message);

                //    if (checkRemain == false)
                //    {
                //        if (!string.IsNullOrEmpty(message))
                //        {
                //            MsgBox.Show(message.Translation(), MsgType.Information);
                //        }
                //        return;
                //    }
                //}

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.INSERT_SPAREPART_EXPIRED",
                    new string[] { "A_STT", "A_SPARE_PART_CODE", "A_LOCATION", "A_CONDITION", "A_ISWATE", "A_QUANTITY", "A_DEPART_MENT", "A_STOCK", "A_BARCODE", "A_UNIT", "A_EXPIRED_DATE", "A_TIME_IN", "A_PO_NO" },
                    new string[]
                    {
                        txtSTT.EditValue.NullString(),
                        stlSparepart.EditValue.NullString() ,
                        stlPosition.EditValue.NullString() ,
                        stlCondition.EditValue.NullString() ,
                        cheIsWait.Checked.NullString(),
                        quantity.NullString() ,
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        barcode,
                        stlUnit.EditValue.NullString(),
                        DateExpired,
                        dateInputTime.Text.NullString(),
                        txtPoNo.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);

                    if (chePrint.Checked)
                    {
                        Print(stlPosition.EditValue.NullString(),
                            stlCondition.EditValue.NullString(),
                            stlSparepart.EditValue.NullString(),
                            DateTime.Parse(dateInputTime.Text.NullString()).ToString("yyyy-MM-dd"),
                            DateTime.Parse(DateExpired).ToString("yyyy-MM-dd"),
                            quantity.NullString(), stlUnit.EditValue.NullString().ToUpper(),
                            int.Parse(txtLabelNumber.EditValue.NullString()), txtPoNo.EditValue.NullString());
                    }

                    ViewLocation();
                    ClearSparepartLocation();
                    for (int i = 0; i < gvListNoPosition.DataRowCount; i++)
                    {
                        string location = gvListNoPosition.GetRowCellValue(i, "LOCATION").NullString();
                        if (stlPosition.EditValue.NullString() == location)
                        {
                            gvListNoPosition.MakeRowVisible(i);
                            break;
                        }
                    }
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

        private void btnClearSparePartLocation_Click(object sender, EventArgs e)
        {
            ClearSparepartLocation();
        }

        private void ClearSparepartLocation()
        {
            try
            {
                cheIsWait.EditValue = false;
                stlPosition.EditValue = null;
                stlSparepart.EditValue = null;
                txtQuantity.EditValue = null;
                stlUnit.EditValue = null;
                stlCondition.EditValue = Consts.CONDITION_DEFAULT;
                stlPosition.Enabled = true;
                txtSTT.EditValue = null;
                txtQuantityNewAdd.EditValue = null;
                cheHasDateExpired.Checked = false;
                dateExpiredTime.EditValue = null;

                //stlSparepart.Enabled = true;
                stlCondition.Enabled = true;
                cheEditQuantity.Checked = true;
                txtQuantity.Enabled = false;
                dateInputTime.EditValue = DateTime.Now;
                txtPoNo.EditValue = string.Empty;
                chePrint.Checked = false;
                txtLabelNumber.EditValue = 0;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDeleteLocation_Sparepart_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    (string.IsNullOrEmpty(stlPosition.EditValue.NullString()) && !cheIsWait.Checked) ||
                    string.IsNullOrEmpty(stlSparepart.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlCondition.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);                      
                    stlPosition.Focus();
                    return;
                }


                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {

                    string DateExpired = "2199-01-01";
                    if (cheHasDateExpired.Checked)
                    {
                        DateExpired = dateExpiredTime.Text.NullString();
                    }

                    string codeLocation = txtposition1.EditValue.NullString();// + "-" + txtPosition2.EditValue.NullString();
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.DELETE",
                        new string[] { "A_STT", "A_SPARE_PART_CODE", "A_LOCATION", "A_DEPART_MENT", "A_STOCK", "A_CONDITION", "A_UNIT", "A_EXPIRED_DATE", "A_TIME_IN", "A_PO_NO","A_USER" },
                        new string[]
                        {
                            txtSTT.EditValue.NullString(),
                            stlSparepart.EditValue.NullString(),
                            stlPosition.EditValue.NullString(),
                            Consts.DEPARTMENT,
                            stlKho.EditValue.NullString(),
                            stlCondition.EditValue.NullString(),
                            stlUnit.EditValue.NullString(),
                            DateExpired,
                            dateInputTime.Text.NullString(),
                            txtPoNo.EditValue.NullString(),
                            Consts.USER_INFO.Id
                        });

                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);

                        // reload location in grid
                        ViewLocation();

                        ClearSparepartLocation();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtSearchNoLocation_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Vị trí-위치" && s != "Mã thiết bị" && s != "Tên tiếng việt[Sparepart의 이름]") args.IsSearchColumn = false;
        }

        private void gvListNoPosition_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            if (e.RowHandle < 0)
            {
                return;
            }
            else
            {
                try
                {
                    // Get spare part no position
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.GET_SINGLE", new string[] { "A_STT" }, new string[] { gvListNoPosition.GetDataRow(e.RowHandle)["STT"].NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                        {
                            stlSparepart.Enabled = false;
                            stlCondition.Enabled = false;
                            txtQuantityNewAdd.EditValue = 0;

                            DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];

                            txtQuantity.EditValue = data.Rows[0]["QUANTITY"].NullString();
                            stlSparepart.EditValue = data.Rows[0]["SPARE_PART_CODE"].NullString();
                            stlUnit.EditValue = data.Rows[0]["UNIT"].NullString();
                            stlPosition.EditValue = data.Rows[0]["LOCATION"].NullString();

                            stlCondition.EditValue = data.Rows[0]["CONDITION_CODE"].NullString();
                            txtSTT.EditValue = gvListNoPosition.GetDataRow(e.RowHandle)["STT"].NullString();

                            if (string.IsNullOrEmpty(data.Rows[0]["LOCATION"].NullString()))
                            {
                                cheIsWait.Checked = true;
                            }
                            else
                            {
                                stlPosition.Enabled = false;
                                cheIsWait.Checked = false;
                            }

                            string dateExpired = data.Rows[0]["EXPIRED_DATE"].NullString();
                            if (dateExpired != string.Empty && !dateExpired.Contains("2199")) // 2199-01-01
                            {
                                cheHasDateExpired.Checked = true;
                                dateExpiredTime.EditValue = dateExpired;
                                dateExpired_Move.EditValue = dateExpired;
                            }
                            else
                            {
                                cheHasDateExpired.Checked = false;
                                dateExpiredTime.EditValue = "2199-01-01";
                                dateExpired_Move.EditValue = "2199-01-01";
                            }

                            dateInputTime.EditValue = data.Rows[0]["TIME_IN"].NullString();
                            dateTimeIn_Move.EditValue = data.Rows[0]["TIME_IN"].NullString();
                            txtPoNo.EditValue = data.Rows[0]["PO_NO"].NullString();
                            txtPoNo_Move.EditValue = data.Rows[0]["PO_NO"].NullString();

                            //-- fill to move position
                            UnitMoveOld = string.Empty;
                            stlSparepartCode_Move.EditValue = data.Rows[0]["SPARE_PART_CODE"].NullString();
                            txtQuantityMove.EditValue = data.Rows[0]["QUANTITY"].NullString();
                            txtOld_Location.EditValue = data.Rows[0]["LOCATION"].NullString();
                            stlUnitMove.EditValue = data.Rows[0]["UNIT"].NullString();
                            stlConditionMove.EditValue = data.Rows[0]["CONDITION_CODE"].NullString();
                            stlConditionMove.Enabled = false;
                            dateTimeIn_Move.Enabled = false;
                            dateExpired_Move.Enabled = false;
                            stlSparepartCode_Move.Enabled = false;
                            txtOld_Location.Enabled = false;
                            txtPoNo_Move.Enabled = false;
                            UnitMoveOld = stlUnitMove.EditValue.NullString();
                        }
                    }
                    else
                    {
                        txtQuantityNewAdd.EditValue = 0;
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                    cheEditQuantity.Checked = false;
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
        }

        private void stlPosition_EditValueChanged(object sender, EventArgs e)
        {
            AceGridLookUpEdit position = (AceGridLookUpEdit)sender;
            if (!string.IsNullOrEmpty(position.EditValue.NullString()))
            {
                cheIsWait.Checked = false;
            }

            if (stlSparepart.Enabled == false) // mode edit
            {
                txtQuantityRemain.EditValue = 0;
                CheckRemainQuantity(out _);
            }
        }

        private PrinterSettings prnSettings;
        private void btnPrintLabel_Click(object sender, EventArgs e)
        {
            POP.PRINT_LABEL popup = new POP.PRINT_LABEL();
            popup.Kho = stlKho.EditValue.NullString();
            popup.ShowDialog();
        }

        private void Print(string position, string condition, string spareCode, string timeIn, string Exdate, string quantity, string unit, int numberLabel, string poNo)
        {
            #region print
            string designFile = string.Empty;
            string xml_content_Original = string.Empty;
            string xml_content = label;
            string sparepartInput = spareCode;
            try
            {
                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();

                ReportPrintTool pt1 = new ReportPrintTool(reportPrint);
                pt1.PrintingSystem.StartPrint += new PrintDocumentEventHandler(PrintingSystem_StartPrint);

                List<XtraReport> reports = new List<XtraReport>();

                for (int j = 0; j < numberLabel; j++)
                {
                    spareCode = sparepartInput;

                    xml_content = label;

                    string lblPosition_condition = position + (position == string.Empty ? (condition == "NG" ? "NG" : string.Empty) : (condition == "NG" ? ".NG" : string.Empty));

                    DateTime dTimeIn;
                    if (DateTime.TryParse(timeIn, out dTimeIn))
                    {
                        timeIn = dTimeIn.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        timeIn = "-";
                    }

                    DateTime dExdate;
                    if (DateTime.TryParse(Exdate, out dExdate))
                    {
                        Exdate = dExdate.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        Exdate = "2199-01-01";
                    }

                    if (spareCode.Length > 8 && Consts.DEPARTMENT == Consts.SMT_DEPT)
                    {
                        if (Consts.SPAREPART_TO_ID != null && Consts.SPAREPART_TO_ID.Rows.Count > 0)
                        {
                            DataRow[] rows = Consts.SPAREPART_TO_ID.Select("[SPARE_PART_CODE] = '" + spareCode + "'");
                            if (rows.Length == 1)
                            {
                                spareCode = rows[0]["ENCRIPT_CODE"].NullString();
                            }
                        }
                    }

                    string addPo = string.Empty;
                    if (poNo != string.Empty)
                    {
                        addPo = Consts.STR_SPILIT_ON_BARCODE + poNo;
                    }

                    string quantityInLabel = (float.Parse(quantity) / numberLabel).ToString();
                    string barcode =
                       spareCode + Consts.STR_SPILIT_ON_BARCODE +
                       position + Consts.STR_SPILIT_ON_BARCODE +
                       condition + Consts.STR_SPILIT_ON_BARCODE +
                       timeIn + Consts.STR_SPILIT_ON_BARCODE +
                       Exdate + Consts.STR_SPILIT_ON_BARCODE +
                       quantityInLabel + Consts.STR_SPILIT_ON_BARCODE +
                       unit + addPo;

                    string newSparepartCode = sparepartInput + "-" + quantityInLabel + unit;
                    if (Exdate == "2199-01-01")
                    {
                        xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                    }
                    else
                    {
                        if (DateTime.TryParse(Exdate, out DateTime ExpriDate))
                        {
                            xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "EXP:" + ExpriDate.ToString("yyyy-MM-dd"));
                        }
                        else
                        {
                            xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                        }
                    }

                    xml_content = xml_content.Replace("&", "&amp;");
                    File.WriteAllText(designFile, xml_content);

                    XtraReport report = new XtraReport();
                    report.PrintingSystem.ShowPrintStatusDialog = false;
                    report.PrintingSystem.ShowMarginsWarning = false;
                    report.LoadLayoutFromXml(designFile);

                    int leftMargine = report.Margins.Left + 0;
                    int rightMargine = report.Margins.Right;
                    int topMargine = report.Margins.Top + 0;
                    int bottomMargine = report.Margins.Bottom;
                    if (leftMargine < 0)
                    {
                        leftMargine = 0;
                    }
                    if (topMargine < 0)
                    {
                        topMargine = 0;
                    }
                    report.Margins = new System.Drawing.Printing.Margins(leftMargine, rightMargine, topMargine, bottomMargine);
                    report.CreateDocument();

                    reports.Add(report);
                    File.Delete(designFile);

                }

                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    pts.PrintingSystem.StartPrint +=
                        new PrintDocumentEventHandler(reportsStartPrintEventHandler);
                }

                pt1.PrintDialog();
                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    pts.Print();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            #endregion
        }

        private void reportsStartPrintEventHandler(object sender, PrintDocumentEventArgs e)
        {
            int pageCount = e.PrintDocument.PrinterSettings.ToPage;
            e.PrintDocument.PrinterSettings = prnSettings;

            // The following line is required if the number of pages for each report varies, 
            // and you consistently need to print all pages.
            e.PrintDocument.PrinterSettings.ToPage = pageCount;
        }

        private void PrintingSystem_StartPrint(object sender, PrintDocumentEventArgs e)
        {
            prnSettings = e.PrintDocument.PrinterSettings;
        }


        string label;
        private void GetLabelTemplate()
        {
            try
            {
                label = string.Empty;
                string LabelCode = "QRCODE_" + cboPrinter.Text;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET_TEMP", new string[] { "A_CODE_TEMP" }, new string[] { LabelCode });//QRCODE 
                if (m_ResultDB.ReturnInt == 0)
                {
                    if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        label = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["LABEL"].NullString();
                    }
                    else
                    {
                        MsgBox.Show("Không có File label cho printer " + cboPrinter.Text, MsgType.Warning);
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

        private void btnImport_Click(object sender, EventArgs e)
        {
            // check lại file template xem có column PO_NO ?
            POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
            popup.stock_code = stlKho.EditValue.NullString();
            popup.ImpportType = Consts.IMPORT_TYPE_BUSINESS_LOCATION_SPAREPART_INSERT_BATCH;
            popup.ShowDialog();
            ViewLocation();
        }

        /// <summary>
        /// Save file excel template to DB
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSaveFileTemp_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog dlg = new OpenFileDialog();
                dlg.Filter = "Excel Files (.xls*)|*.xls*";
                dlg.Multiselect = false;

                DialogResult dlgResult = dlg.ShowDialog();
                if (dlgResult == DialogResult.OK)
                {
                    string fileName = dlg.FileName;
                    byte[] bytes = File.ReadAllBytes(fileName);
                    string contentType = string.Empty;

                    switch (Path.GetExtension(fileName))
                    {
                        case ".xls":
                        case ".xlsx":
                            contentType = "application/vnd.ms-excel";
                            break;
                    }

                    base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_FILE_TEMP.INSERT", new string[] { "A_FILENAME", "A_CONTENT_TYPE" }, "A_DATA", new string[] { Path.GetFileName(fileName), contentType }, bytes);
                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
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

        /// <summary>
        /// Download file
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnGetFileTemp_Click(object sender, EventArgs e)
        {
            try
            {
                byte[] bytes;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_FILE_TEMP.GET_FILE", new string[] { "A_FILENAME" }, new string[] { "EWIP_SPAREPART_LOCATION.xlsx" });
                if (m_ResultDB.ReturnInt == 0)
                {
                    bytes = (byte[])base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["Data"];

                    Stream stream;
                    SaveFileDialog saveFileDialog = new SaveFileDialog();
                    saveFileDialog.Filter = "All files (*.*)|*.*";
                    saveFileDialog.FilterIndex = 1;
                    saveFileDialog.RestoreDirectory = true;
                    saveFileDialog.FileName = "EWIP_SPAREPART_LOCATION.xlsx";
                    if (saveFileDialog.ShowDialog() == DialogResult.OK)
                    {
                        stream = saveFileDialog.OpenFile();
                        stream.Write(bytes, 0, bytes.Length);
                        stream.Close();

                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    }
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

        private void cboFilterSparepart_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboFilterSparepart.SelectedIndex == 0) // Ton tai vi tri
            {
                gvListNoPosition.ActiveFilterString = "[LOCATION] != '' AND [LOCATION] IS NOT NULL";
            }
            else if (cboFilterSparepart.SelectedIndex == 1) // Dang cho
            {
                gvListNoPosition.ActiveFilterString = "[LOCATION] = '' OR [LOCATION] IS NULL";
            }
            else // All
            {
                gvListNoPosition.ActiveFilter.Clear();
            }
        }

        private void stlSparePartSearch_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlSparePartSearch.EditValue.NullString()))
                {
                    txtSearchNoLocation.EditValue = null;
                    cboFilterSparepart.EditValue = null;
                    stlSparePartSearch.EditValue = null;
                    ViewLocation();
                    return;
                }

                gvListNoPosition.ActiveFilter.Clear();
                gvListNoPosition.ActiveFilterString = "[SPARE_PART_CODE] = '" + stlSparePartSearch.EditValue.NullString() + "'";
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearchNoLocation.EditValue = null;
            cboFilterSparepart.EditValue = null;
            stlSparePartSearch.EditValue = null;
            ViewLocation();
        }

        private void cheHasDateExpired_CheckedChanged(object sender, EventArgs e)
        {
            if (cheHasDateExpired.Checked)
            {
                loDateExpired.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
            }
            else
            {
                loDateExpired.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
            }
        }

        private void btnPrintLabelExpiredDate_Click(object sender, EventArgs e)
        {
            string designFile = string.Empty;
            string xml_content_Original = string.Empty;
            string xml_content = label;

            try
            {
                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();

                ReportPrintTool pt1 = new ReportPrintTool(reportPrint);
                pt1.PrintingSystem.StartPrint += new PrintDocumentEventHandler(PrintingSystem_StartPrint);

                List<XtraReport> reports = new List<XtraReport>();
                int check = 0;
                for (int i = 0; i < gvListNoPosition.DataRowCount; i++)
                {
                    if (gvListNoPosition.IsRowSelected(i))
                    {
                        int numberLabel = int.Parse(Math.Ceiling(decimal.Parse(gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[9]).NullString())).NullString());
                        for (int j = 0; j < numberLabel; j++)
                        {
                            xml_content = label;

                            string position = gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[0]).NullString();
                            string condition = gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[3]).NullString();
                            string lblPosition_condition = position + (position == string.Empty ? string.Empty : ".") + (condition == "NG" ? "NG" : string.Empty);
                            string strDate = gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[10]).NullString();
                            if (!DateTime.TryParse(strDate, out DateTime ExpriDate))
                            {
                                continue;
                            }
                            xml_content = xml_content.Replace("$BARCODE$", ExpriDate.ToString("yyyy-MM-dd")).Replace("$CODE$", ExpriDate.ToString("yyyy-MM-dd")).Replace("$POSITION$", "HẠN SỬ DỤNG");

                            xml_content = xml_content.Replace("&", "&amp;");
                            File.WriteAllText((i + 1).NullString() + designFile, xml_content);

                            XtraReport report = new XtraReport();
                            report.PrintingSystem.ShowPrintStatusDialog = false;
                            report.PrintingSystem.ShowMarginsWarning = false;
                            report.LoadLayoutFromXml((i + 1).NullString() + designFile);

                            int leftMargine = report.Margins.Left + 0;
                            int rightMargine = report.Margins.Right;
                            int topMargine = report.Margins.Top + 0;
                            int bottomMargine = report.Margins.Bottom;
                            if (leftMargine < 0)
                            {
                                leftMargine = 0;
                            }
                            if (topMargine < 0)
                            {
                                topMargine = 0;
                            }
                            report.Margins = new System.Drawing.Printing.Margins(leftMargine, rightMargine, topMargine, bottomMargine);
                            report.CreateDocument();

                            reports.Add(report);
                            File.Delete((i + 1).NullString() + designFile);
                            //i++;

                            //check++;
                        }

                        check++;
                    }
                }

                if (check == 0)
                {
                    MsgBox.Show("MSG_NOT_HAVE_LOCATION".Translation(), MsgType.Warning);
                    return;
                }

                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    pts.PrintingSystem.StartPrint +=
                        new PrintDocumentEventHandler(reportsStartPrintEventHandler);
                }

                pt1.PrintDialog();
                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    //pts.ShowPreview();
                    pts.Print();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            GetUnitBySparePart(stlSparepart.EditValue.NullString(), stlUnit);

            if (stlSparepart.Enabled == true) // mode new
            {
                txtQuantity.EditValue = 0;
                txtQuantityRemain.EditValue = 0;
                CheckRemainQuantity(out _);
            }
        }

        private void GetUnitBySparePart(string sparepartCode, AceGridLookUpEdit unitControl)
        {
            try
            {
                if (!string.IsNullOrEmpty(sparepartCode))
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_UNIT_SPAREPART.GET_UNIT_BY_SPAREPART",
                        new string[] { "A_DEPT_CODE", "A_SPARE_PART_CODE" },
                        new string[] { Consts.DEPARTMENT, sparepartCode });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable table = base.m_ResultDB.ReturnDataSet.Tables[0];
                        base.m_BindData.BindGridLookEdit(unitControl, table, "CODE", "NAME");

                        if (table.Rows.Count > 0)
                        {
                            unitControl.EditValue = table.Rows[0]["CODE"].NullString();
                        }
                    }
                    else
                    {
                        MsgBox.Show("NOT FOUND UNIT FOR SPAREPART", MsgType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtQuantity_EditValueChanged(object sender, EventArgs e)
        {
        }

        private bool CheckRemainQuantity(out string message)
        {
            try
            {
                if (!string.IsNullOrEmpty(stlSparepart.EditValue.NullString()) &&
                    !string.IsNullOrEmpty(stlKho.EditValue.NullString()) &&
                    !string.IsNullOrEmpty(stlUnit.EditValue.NullString()))
                {
                    txtQuantityRemain.EditValue = 0;

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.CACULAR_REMAIN_QUANTITY",
                        new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_UNIT" },
                        new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), stlSparepart.EditValue.NullString(), stlUnit.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                        {
                            string quantityRemain = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["QUANTITY"].NullString();

                            if (float.Parse(quantityRemain) >= 0)
                            {
                                txtQuantityRemain.EditValue = quantityRemain;
                                if (stlSparepart.Enabled == true)// create new
                                {
                                    string q1 = txtQuantity.EditValue.NullString();
                                    string q2 = txtQuantityNewAdd.EditValue.NullString();

                                    if (q1 == string.Empty) q1 = "0";
                                    if (q2 == string.Empty) q2 = "0";

                                    if (float.Parse(q1) + float.Parse(q2) > float.Parse(quantityRemain))
                                    {
                                        message = "MSG_QUANTITY_INVALID";
                                        return false;
                                    }
                                }
                                message = string.Empty;
                                return true;
                            }
                            else
                            {
                                message = "QUANTITY_ZERO";
                                return false;
                            }
                        }
                    }
                    else
                    {
                        message = m_ResultDB.ReturnString;
                        return false;
                    }
                    message = string.Empty;
                    return false;
                }
                message = string.Empty;
                return false;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            message = string.Empty;
            return false;
        }

        private void txtQuantityNewAdd_EditValueChanged(object sender, EventArgs e)
        {
            //CheckRemainQuantity(txtQuantityNewAdd.EditValue.NullString());
        }

        private void cheEditQuantity_CheckedChanged(object sender, EventArgs e)
        {
            txtQuantity.Enabled = cheEditQuantity.Checked;
        }

        private void gcListNoPosition_Click(object sender, EventArgs e)
        {

        }

        private void btnClear_Move_Click(object sender, EventArgs e)
        {
            ClearInputMoveSparepart();
        }

        private void ClearInputMoveSparepart()
        {
            stlSparepartCode_Move.EditValue = null;
            txtOld_Location.EditValue = null;
            stlNew_Location.EditValue = null;
            stlUnitMove.EditValue = null;
            txtQuantityMove.EditValue = null;
            stlConditionMove.EditValue = null;
            dateExpired_Move.EditValue = null;
            dateTimeIn_Move.EditValue = null;
            txtPoNo_Move.EditValue = string.Empty;

            stlSparepartCode_Move.Enabled = false;
            txtOld_Location.Enabled = false;
            stlNew_Location.Enabled = true;
            stlUnitMove.Enabled = true;
            txtQuantityMove.Enabled = true;
            stlConditionMove.Enabled = false;
            dateExpired_Move.Enabled = false;
            dateTimeIn_Move.Enabled = false;
            chePrint_Move.Checked = false;
            txtLabelNumber_Move.EditValue = 0;
            txtPoNo_Move.Enabled = false;
        }

        private void btnSaveMoveLocation_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtQuantityMove.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlUnitMove.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlSparepartCode_Move.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlConditionMove.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateTimeIn_Move.Text.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    stlPosition.Focus();
                    return;
                }

                if(!float.TryParse(txtQuantityMove.EditValue.NullString(),out _))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtQuantityMove.Focus();
                    return;
                }

                string DateExpired = "2199-01-01";
                if (dateExpired_Move.EditValue.NullString() != string.Empty)
                {
                    DateExpired = dateExpired_Move.Text.NullString();
                }

                if(txtOld_Location.EditValue.NullString() == stlNew_Location.EditValue.NullString())
                {
                    MsgBox.Show("VỊ TRÍ BỊ TRÙNG NHAU!!!".Translation(), MsgType.Warning);
                    stlNew_Location.Focus();
                    return;
                }

                string barcode = string.Empty;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.MOVE_SPARE_PART_TO_LOCATION",
                      new string[] { "A_STT", "A_SPARE_PART_CODE", "A_LOCATION_OLD", "A_LOCATION_NEW", "A_CONDITION", "A_QUANTITY", "A_DEPART_MENT", "A_STOCK", "A_BARCODE", "A_UNIT", "A_EXPIRED_DATE", "A_TIME_IN", "A_USER", "A_PO_NO" },
                       new string[]
                    {
                        txtSTT.EditValue.NullString(),
                        stlSparepartCode_Move.EditValue.NullString() ,
                        txtOld_Location.EditValue.NullString() ,
                        stlNew_Location.EditValue.NullString() ,
                        stlConditionMove.EditValue.NullString() ,
                        txtQuantityMove.EditValue.NullString(),
                        Consts.DEPARTMENT,
                         stlKho.EditValue.NullString(),
                         barcode,
                         stlUnitMove.EditValue.NullString(),
                         DateExpired,
                        dateTimeIn_Move.Text.NullString(),
                        Consts.USER_INFO.Id,
                        txtPoNo_Move.EditValue.NullString()
                    });

                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);

                    if (chePrint_Move.Checked)
                    {
                        Print(stlNew_Location.EditValue.NullString(),
                            stlConditionMove.EditValue.NullString(),
                            stlSparepartCode_Move.EditValue.NullString(),
                            DateTime.Parse(dateTimeIn_Move.Text.NullString()).ToString("yyyy-MM-dd"),
                            DateTime.Parse(DateExpired).ToString("yyyy-MM-dd"),
                            txtQuantityMove.EditValue.NullString(), stlUnitMove.EditValue.NullString().ToUpper(),
                            int.Parse(txtLabelNumber_Move.EditValue.NullString()), txtPoNo_Move.EditValue.NullString());
                    }

                    ViewLocation();
                    ClearInputMoveSparepart();

                    for (int i = 0; i < gvListNoPosition.DataRowCount; i++)
                    {
                        string location = gvListNoPosition.GetRowCellValue(i, "LOCATION").NullString();
                        if (stlNew_Location.EditValue.NullString() == location)
                        {
                            gvListNoPosition.MakeRowVisible(i);
                            break;
                        }
                    }
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

        private void stlSparepartCode_Move_EditValueChanged(object sender, EventArgs e)
        {
            GetUnitBySparePart(stlSparepartCode_Move.EditValue.NullString(), stlUnitMove);
            UnitMoveOld = string.Empty;
        }

        private void bntClearMemory_Click(object sender, EventArgs e)
        {
            try
            {
                Consts.GetDataMemory().Rows.Clear();
                m_BindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");
                MsgBox.Show("MSG_COM_004".Translation(), MsgType.Information);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlUnit_EditValueChanged(object sender, EventArgs e)
        {
            CheckRemainQuantity(out _);
        }

        private void stlMemoryData_EditValueChanged(object sender, EventArgs e)
        {
            if (stlSparepart.Enabled && stlMemoryData.EditValue.NullString() != string.Empty)
            {
                stlSparepart.EditValue = stlMemoryData.EditValue;
            }
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            InitializePage();
        }

        private void chePrint_CheckedChanged(object sender, EventArgs e)
        {
        }

        private void cboPrinter_SelectedIndexChanged(object sender, EventArgs e)
        {
            PrinterClass.SetDefaultPrinter(cboPrinter.Text);
            GetLabelTemplate();
        }

        private void btnHistory_Move_Click(object sender, EventArgs e)
        {
            POP.HISTORY_MOVE_LOCATION popup = new POP.HISTORY_MOVE_LOCATION();
            popup.StockCode = stlKho.EditValue.NullString();
            popup.ShowDialog();
        }

        private string UnitMoveOld = string.Empty;
        private void stlUnitMove_EditValueChanged(object sender, EventArgs e)
        {
            if (UnitMoveOld == string.Empty)
            {
                UnitMoveOld = stlUnitMove.EditValue.NullString();
            }
            else
            {
                float quantityMove = MES.Classes.Common.ConvertUnit(UnitMoveOld, stlUnitMove.EditValue.NullString(), stlSparepartCode_Move.EditValue.NullString()) * float.Parse(txtQuantityMove.EditValue.IfNullIsZero());
                txtQuantityMove.EditValue = quantityMove;
                UnitMoveOld = stlUnitMove.EditValue.NullString();
            }
        }

        private void gvListNoPosition_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "INVENTORY_TIME")
            {
                e.Appearance.BackColor = Color.FromArgb(253, 242, 233);
            }
            else if (e.Column.FieldName == "QUANTITY")
            {
                e.Appearance.BackColor = Color.FromArgb(254, 245, 231);
            }
            else if (e.Column.FieldName == "SPARE_PART_CODE")
            {
                e.Appearance.BackColor = Color.FromArgb(251, 238, 230);
            }
        }
    }
}
