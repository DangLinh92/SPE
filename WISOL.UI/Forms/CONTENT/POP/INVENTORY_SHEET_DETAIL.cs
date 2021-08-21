using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class INVENTORY_SHEET_DETAIL : FormType
    {
        public INVENTORY_SHEET_DETAIL()
        {
            InitializeComponent();
        }

        public string Kho { get; set; }
        public string Mode { get; set; }
        public string SheetId { get; set; }
        public string TimeFrom { get; set; }
        public string TimeTo { get; set; }
        public string Title { get; set; }
        public string InventorySheetMonth { get; set; }

        private void ShowData()
        {
            if (Mode == Consts.MODE_NEW)
            {
                GetData("PKG_BUSINESS_SP_INVENTORY.REPORT_BY_SPAREPART_LOCATION_SHEET_DETAIL", new string[] { "A_DEPARTMENT", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT, Kho });
            }
            else
            {
                txtSheetId.EditValue = SheetId;
                txtTitle.EditValue = Title;
                dateFrom.EditValue = TimeFrom;
                dateTo.EditValue = TimeTo;
                dateMonthSheetDetail.EditValue = InventorySheetMonth;

                GetData("PKG_BUSINESS_INVENTORY_SHEET.GET_DETAIL", new string[] { "A_SHEET_ID", "A_DEPT_CODE", "A_STOCK" }, new string[] { SheetId, Consts.DEPARTMENT, Kho });
            }

            gvList.OptionsView.ColumnAutoWidth = true;
            gvList.OptionsSelection.MultiSelect = true;
            gvList.OptionsSelection.MultiSelectMode = DevExpress.XtraGrid.Views.Grid.GridMultiSelectMode.CheckBoxRowSelect;

            gvList.OptionsBehavior.Editable = true;

            if (gvList.RowCount == 0) return;

            gvList.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
            gvList.Columns["SPARE_PART_CODE"].OptionsColumn.AllowEdit = false;
            gvList.Columns["NAME_VI"].OptionsColumn.AllowEdit = false;
            gvList.Columns["CONDITION_CODE"].OptionsColumn.AllowEdit = false;
            gvList.Columns["UNIT"].OptionsColumn.AllowEdit = false;

            gvList.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
            gvList.Columns["EXPIRED_DATE"].OptionsColumn.AllowEdit = false;
            gvList.Columns["TIME_IN"].OptionsColumn.AllowEdit = false;
            gvList.Columns["INVENTORY_ASSETS_TIME"].OptionsColumn.AllowEdit = false;
            gvList.Columns["QUANTITY_REAL"].OptionsColumn.AllowEdit = true;
            gvList.Columns["DIFF"].OptionsColumn.AllowEdit = false;
            gvList.OptionsView.ColumnAutoWidth = true;
        }

        private void GetData(string storeProcedureName, string[] param, string[] values)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc(storeProcedureName, param, values);
                if (mResultDB.ReturnInt == 0)
                {
                    if (mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        base.mBindData.BindGridView(gcList, mResultDB.ReturnDataSet.Tables[0]);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void INVENTORY_SHEET_DETAIL_Load(object sender, EventArgs e)
        {
            Wisol.MES.Classes.Common.GetEncriptCode();
            ShowData();
        }

        private void btnGetSheetId_Click(object sender, EventArgs e)
        {
            try
            {
                if (Mode == Consts.MODE_NEW)
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP.CREATE_SHEET_CODE",
                 new string[] { "A_DEPARTMENT" },
                 new string[] { Consts.DEPARTMENT });

                    if (mResultDB.ReturnInt == 0)
                    {
                        txtSheetId.EditValue = mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].NullString();
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

        private List<string> cellChecked = new List<string>();
        private int CountPosition = 0;
        private void xTextEdit1_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                InputLanguage originalInputLang = InputLanguage.CurrentInputLanguage;
                var lang = InputLanguage.InstalledInputLanguages.OfType<InputLanguage>().Where(l => l.Culture.Name.StartsWith("en")).FirstOrDefault();
                if (lang != null)
                {
                    InputLanguage.CurrentInputLanguage = lang;
                }

                if (e.KeyCode == Keys.Enter)
                {
                    string barcode = txtScanbarcode.EditValue.NullString().ToUpper().ToString(new CultureInfo("en-US"));
                    string[] items = barcode.Split(Consts.CHARACTER_SPILIT_ON_BARCODE);

                    if (items.Length > 0)
                    {
                        string sparepartCode = Classes.Common.GetSparepartCodeWithEncript(items[0].NullString());
                        string location = items[1];
                        string condition = items[2];
                        string dateInWarehouse = items[3];
                        string dateExpiried = items[4];
                        string quantity = items[5];
                        string unit = items[6];

                        if (Consts.lstUnicodeUnitErr.Contains(unit))
                        {
                            unit = Consts.lstUnicodeUnitOK[Consts.lstUnicodeUnitErr.FindIndex(x => x == unit)];
                        }

                        if (dateExpiried == "2199-01-01")
                        {
                            dateExpiried = "";
                        }

                        for (int i = 0; i < gvList.RowCount; i++)
                        {
                            if (location == gvList.GetRowCellValue(i, "LOCATION").NullString())
                            {
                                string time = gvList.GetRowCellValue(i, "TIME_IN").NullString();
                                DateTime timeIn = new DateTime();
                                if (time != "")
                                {
                                    DateTime.TryParse(time, out timeIn);
                                }

                                if (sparepartCode == gvList.GetRowCellValue(i, "SPARE_PART_CODE").NullString() &&
                                    condition == gvList.GetRowCellValue(i, "CONDITION_CODE").NullString() &&
                                    dateInWarehouse == timeIn.ToString("yyyy-MM-dd") &&
                                    dateExpiried == gvList.GetRowCellValue(i, "EXPIRED_DATE").NullString())
                                {
                                    if (unit == gvList.GetRowCellValue(i, "UNIT").NullString())
                                    {
                                        string oldQuantity = gvList.GetRowCellValue(i, "QUANTITY_REAL").NullString();
                                        if (oldQuantity == "")
                                        {
                                            oldQuantity = "0";
                                        }

                                        if (quantity == "")
                                        {
                                            quantity = "0";
                                        }
                                        float newQuantity = float.Parse(quantity) + float.Parse(oldQuantity);
                                        gvList.SetRowCellValue(i, "QUANTITY_REAL", newQuantity.NullString());

                                        if (!gvList.IsRowSelected(i))
                                        {
                                            ++CountPosition;
                                        }

                                        gvList.SelectRow(i);
                                    }
                                    else
                                    {
                                        string oldQuantity = gvList.GetRowCellValue(i, "QUANTITY_REAL").NullString();
                                        if (oldQuantity == "")
                                        {
                                            oldQuantity = "0";
                                        }

                                        float newQuantity = Wisol.MES.Classes.Common.ConvertUnit(unit, gvList.GetRowCellValue(i, "UNIT").NullString(), sparepartCode) * float.Parse(quantity);
                                        float newQ = newQuantity + float.Parse(oldQuantity);
                                        gvList.SetRowCellValue(i, "QUANTITY_REAL", newQ.NullString());
                                        if (!gvList.IsRowSelected(i))
                                        {
                                            ++CountPosition;
                                        }
                                        gvList.SelectRow(i);
                                    }
                                    gvList.MakeRowVisible(i);
                                    cellChecked.Add("QUANTITY" + ";" + i);


                                    lblCountPosition.Text = (CountPosition).NullString() + "/" + gvList.RowCount;
                                    break;
                                }
                            }
                        }

                        txtScanbarcode.EditValue = null;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        List<string> cells = new List<string>();
        private void gvList_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {
            if (e.Column.FieldName == "QUANTITY_REAL")
            {
                float diff = float.Parse(e.Value.NullString()) - float.Parse(gvList.GetRowCellValue(e.RowHandle, "QUANTITY").NullString());
                gvList.SetRowCellValue(e.RowHandle, "DIFF", diff);

                if (diff != 0)
                {
                    string key = "QUANTITY" + ";" + e.RowHandle.ToString();
                    if (!cells.Contains(key))
                        cells.Add(key);
                }
                else
                {
                    string key = "QUANTITY" + ";" + e.RowHandle.ToString();
                    if (cells.Contains(key))
                        cells.Remove(key);
                }
            }
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.Column.FieldName == "LOCATION" || e.Column.FieldName == "QUANTITY")
            {
                e.Appearance.BackColor = Color.FromArgb(255, 255, 204);
            }

            string key = e.Column.FieldName + ";" + e.RowHandle.ToString();

            if (cellChecked.Contains(key))
            {
                e.Appearance.BackColor = Color.FromArgb(0, 204, 204);
            }

            if (cells.Contains(key))
            {
                e.Appearance.BackColor = Color.FromArgb(255, 204, 204);
            }
            else
            {
                e.Appearance.BackColor = Color.FromArgb(229, 255, 204);
            }

            if (Mode == Consts.MODE_UPDATE)
            {
                if (e.Column.FieldName == "DIFF")
                {
                    if (gvList.GetRowCellValue(e.RowHandle, "DIFF").NullString() != Consts.ZERO)
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 153, 153);
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                }
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (txtSheetId.EditValue.NullString() == "" || dateFrom.EditValue.NullString() == "" || dateTo.EditValue.NullString() == "" || txtTitle.EditValue.NullString() == "")
            {
                MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                return;
            }

            DialogResult dialogResult = MsgBox.Show("MSG_COM_INVENTORY_QUANTITY_REAL".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                gvList.ClearColumnsFilter();

                DataTable data = Wisol.MES.Classes.Common.GetDataTable(gvList,new string[] { });
                if (data != null && data.Rows.Count > 0)
                {
                    base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_INVENTORY_SHEET.INSERT_BATCH_INVENTORY_REAL",
                        new string[] { "A_DEPARTMENT_CODE", "A_STOCK", "A_USER", "A_TIME", "A_FROM_TIME", "A_TO_TIME", "A_TITLE", "A_SHEET_ID" }, "A_DATA",
                        new string[] { Consts.DEPARTMENT, Kho, Consts.USER_INFO.Id, dateMonthSheetDetail.EditValue.NullString(), dateFrom.EditValue.NullString(), dateTo.EditValue.NullString(), txtTitle.EditValue.NullString(), txtSheetId.EditValue.NullString() }, data);

                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                        this.Close();
                    }
                    else
                    {
                        MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
            }
        }

        private void btnClearSelected_Click(object sender, EventArgs e)
        {
            foreach (var i in gvList.GetSelectedRows())
            {
                gvList.SetRowCellValue(i, "QUANTITY_REAL", 0);
                gvList.SetRowCellValue(i, "DIFF", 0);
            }
            gvList.ClearSelection();
            cells.Clear();
        }

        private void cboFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var x = gvList.Columns;
            //if(cboFilter.SelectedIndex == 0)
            //{
            //    gvList.ActiveFilter.Clear();
            //}
            //else if(cboFilter.SelectedIndex == 1)
            //{
            //    for (int i = 0; i < gvList.RowCount; i++)
            //    {
            //        if (!gvList.IsRowSelected(i))
            //        {

            //        }
            //    }
            //}
        }
    }
}
