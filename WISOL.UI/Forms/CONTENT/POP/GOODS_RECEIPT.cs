using DevExpress.XtraGrid.Views.Base;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Forms.REPORT;
using Wisol.MES.Forms.REPORT.Models;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class GOODS_RECEIPT : FormType
    {
        public GOODS_RECEIPT()
        {
            InitializeComponent();
        }
        private void GOODS_RECEIPT_Load(object sender, EventArgs e)
        {
            grcontrolGoodReceipt.Text = INOUT == Consts.IN ? "Goods receipt-Nhập kho-입고" : "Goods Issue-Xuất kho-출고";
            STATUS.Columns.Add("CODE");
            STATUS.Columns.Add("NAME");
            STATUS.Rows.Add("NEW", "TẠO MỚI");
            STATUS.Rows.Add("INPROGRESS", "ĐANG XỬ LÝ");
            STATUS.Rows.Add("COMPLETE", "HOÀN THÀNH");
            Wisol.MES.Classes.Common.GetEncriptCode();
            InitData();

            Classes.Common.SetFormIdToButton(null, "GOODS_RECEIPT", this);
        }
        public DataTable Data { get; set; }
        private DataTable STATUS = new DataTable();

        public string Mode { get; set; }
        public string ReceiptCode { get; set; }
        public string INOUT { get; set; }

        public string StockCode { get; set; }
        public DataTable SparePartData { get; set; }
        public string CurrentStatus { get; set; }

        private void InitData()
        {
            try
            {
                Data = new DataTable();
                Data.Columns.Add("RECEIPT_ISSUE_CODE", typeof(string));
                Data.Columns.Add("SPARE_PART_CODE", typeof(string));
                Data.Columns.Add("NAME", typeof(string));
                Data.Columns.Add("QUANTITY", typeof(string));
                Data.Columns.Add("UNIT", typeof(string));
                Data.Columns.Add("PRICE_VN", typeof(string));
                Data.Columns.Add("PRICE_US", typeof(string));
                Data.Columns.Add("AMOUNT_VN", typeof(string));
                Data.Columns.Add("AMOUNT_US", typeof(string));
                Data.Columns.Add("CAUSE", typeof(string));
                Data.Columns.Add("NOTE", typeof(string));

                Data.Columns.Add("STOCK_CODE", typeof(string));
                Data.Columns.Add("DEPT_CODE", typeof(string));
                Data.Columns.Add("INT_OUT", typeof(string));
                Data.Columns.Add("CREATE_DATE", typeof(DateTime));
                Data.Columns.Add("USER_CREATE", typeof(string));
                Data.Columns.Add("USER_SYS", typeof(string));
                Data.Columns.Add("ORDER_CODE", typeof(string));
                Data.Columns.Add("STATUS", typeof(string));
                Data.Columns.Add("TYPE_IN_OUT_CODE", typeof(string));
                Data.Columns.Add("RETURN_TIME", typeof(string));
                Data.Columns.Add("LOCATION", typeof(string));
                Data.Columns.Add("QUANTITY_NG", typeof(string));
                Data.Columns.Add("EXPRIRED_DATE", typeof(string));
                Data.Columns.Add("IS_INTEGRATED", typeof(string)); // thiết bị tích hợp theo máy

                base.mBindData.BindGridLookEdit(cboStatus, STATUS, "CODE", "NAME");

                dateInput.EditValue = DateTime.Now;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (mResultDB.ReturnInt == 0)
                {
                    SparePartData = base.mResultDB.ReturnDataSet.Tables[1];
                    base.mBindData.BindGridLookEdit(stlSparePartCode, base.mResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.mBindData.BindGridLookEdit(stlKho, base.mResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.mBindData.BindGridLookEdit(stlOrderCode, base.mResultDB.ReturnDataSet.Tables[4], "PO_ID", "PO_ID");

                    DataTable tmp = new DataTable();
                    tmp.Columns.Add("CODE");
                    tmp.Columns.Add("NAME");
                    string selectedValueFirt = string.Empty;
                    foreach (DataRow item in base.mResultDB.ReturnDataSet.Tables[5].Rows)
                    {
                        if (INOUT == Consts.IN)
                        {
                            if (item["CODE"].NullString() == "1" || item["CODE"].NullString() == "2")
                            {
                                tmp.Rows.Add(item["CODE"], item["NAME"]);
                            }

                            selectedValueFirt = "1";
                        }
                        else
                        {
                            if (item["CODE"].NullString() == "3" || item["CODE"].NullString() == "4")
                            {
                                tmp.Rows.Add(item["CODE"], item["NAME"]);
                            }
                            selectedValueFirt = "4";
                        }
                    }
                    base.mBindData.BindGridLookEdit(stlType, tmp, "CODE", "NAME");

                    stlType.EditValue = selectedValueFirt;

                    base.mBindData.BindGridLookEdit(stlUnit, base.mResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");

                    stlKho.EditValue = StockCode;
                }

                InitByMode();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void InitByMode()
        {
            mBindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");
            if (INOUT == Consts.OUT)
            {
                txtQuantity_NG.Enabled = false;
                dateExpired.Enabled = false;
                mmNote.Enabled = false;
                cheIsScanbarcode.Checked = true;
                txtScanbarcode.Focus();
                cheIsReturn.Enabled = false;
                btnListSparepartPay.Enabled = false;
                btnCreateLendCode.Enabled = true;
            }
            else
            {
                cheIsReturn.Enabled = true;
                txtQuantity_NG.Enabled = true;
                dateExpired.Enabled = true;
                loNote.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                mmNote.Enabled = true;
                cheIsScanbarcode.Checked = false;
                cheIsScanbarcode.Enabled = false;
                txtScanbarcode.Enabled = false;
                stlSparePartCode.Focus();
                btnCreateLendCode.Enabled = false;
            }

            if (Mode == Consts.MODE_DELETE)
            {
                dateInput.Enabled = false;
                cboStatus.Enabled = false;
                btnClear.Enabled = false;
                btnSave.Enabled = false;
            }
            else
            {
                dateInput.Enabled = true;
                cboStatus.Enabled = true;
                btnClear.Enabled = true;
                btnSave.Enabled = true;

                if (Mode == Consts.MODE_NEW)
                {
                    cboStatus.EditValue = Consts.STATUS_NEW;
                }
            }

            btnDelete.Enabled = Mode != Consts.MODE_NEW;

            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.INIT", new string[] { "A_STOCK_INT_OUT_CODE", "A_DEPT_CODE", "A_STOCK_CODE", "A_INOUT" }, new string[] { ReceiptCode, Consts.DEPARTMENT, StockCode, INOUT });
            if (mResultDB.ReturnInt == 0)
            {
                DataTable leftData = mResultDB.ReturnDataSet.Tables[0];
                DataTable righttData = mResultDB.ReturnDataSet.Tables[1];

                Data.Clear();

                foreach (DataRow item in leftData.Rows)
                {
                    Data.Rows.Add
                        (
                            item["RECEIPT_ISSUE_CODE"].NullString(),
                            item["SPARE_PART_CODE"].NullString(),
                            item["NAME_VI"].NullString(),
                            item["QUANTITY"].NullString(),
                            item["UNIT"].NullString(),
                            item["PRICE_VN"].NullString(),
                            item["PRICE_US"].NullString(),
                            item["AMOUNT_VN"].NullString(),
                            item["AMOUNT_US"].NullString(),
                            item["CAUSE"].NullString(),
                            item["NOTE"].NullString(),
                            string.Empty,
                            string.Empty,
                            string.Empty,
                            item["CREATE_DATE"].NullString(), string.Empty, string.Empty, string.Empty, string.Empty,
                            item["TYPE_IN_OUT_CODE"].NullString(),
                            item["RETURN_TIME"].NullString(),
                            item["LOCATION"].NullString(),
                            item["QUANTITY_NG"].NullString(),
                            item["EXPRIRED_DATE"].NullString(),
                            item["IS_INTEGRATED"].NullString()
                        );
                }
                base.mBindData.BindGridView(gcList, Data);
                FormatGridColumn(INOUT == "OUT");

                if (righttData.Rows.Count > 0)
                {
                    stlKho.EditValue = righttData.Rows[0]["STOCK_CODE"];
                    stlType.EditValue = righttData.Rows[0]["TYPE_IN_CODE"];
                    stlOrderCode.EditValue = righttData.Rows[0]["ORDER_CODE"];
                    txtUserCreate.EditValue = righttData.Rows[0]["USER_CREATE"];
                    dateInput.EditValue = DateTime.Parse(righttData.Rows[0]["DATE"].NullString());
                    cboStatus.EditValue = righttData.Rows[0]["STATUS"];
                    txtDelivererAndReceiver.EditValue = righttData.Rows[0]["DELIVERET_RECEIVER"].NullString();
                }

                if (INOUT == Consts.IN)
                {
                    txtScanbarcode.Enabled = false;
                    dateReturnTime.Enabled = false;
                    btnPrintReport.Enabled = false;
                    gcLocation.Enabled = false;
                    lblRedNote.Visible = false;
                    loRedNote.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                }
                else
                {
                    gcLocation.Enabled = true;
                    btnPrintReport.Enabled = true;
                    txtScanbarcode.Enabled = true;
                    txtScanbarcode.Focus();
                    lblRedNote.Visible = true;
                    loRedNote.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                }

                if ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && cboStatus.EditValue.NullString() == Consts.STATUS_COMPLETE)
                {
                    cboStatus.Enabled = false;
                }
                else
                {
                    cboStatus.Enabled = true;
                }
            }


            if (Mode == Consts.MODE_VIEW)
            {
                btnClear.Enabled = false;
                btnSave.Enabled = false;
                btnDelete.Enabled = false;
                cheMoreLoaction.Checked = false;

                if (INOUT == Consts.OUT)
                {
                    Print();
                    this.Close();
                }
            }
        }

        private Dictionary<string, string> LocationDic = new Dictionary<string, string>();
        private void btnAddItem_Click(object sender, EventArgs e)
        {
            try
            {
                if (INOUT == Consts.IN) // NHAP KHO
                {
                    if (string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) ||
                            string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                            string.IsNullOrEmpty(stlType.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    DataRow checkRow = Data.Rows.Count > 0 ? Data.Select().FirstOrDefault(x => x["SPARE_PART_CODE"].NullString() == stlSparePartCode.EditValue.NullString()) : null;

                    if (checkRow != null)
                    {
                        checkRow["CREATE_DATE"] = dateInput.EditValue;
                        checkRow["STOCK_CODE"] = stlKho.EditValue.NullString();
                        checkRow["DEPT_CODE"] = Consts.DEPARTMENT;
                        checkRow["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                        checkRow["USER_SYS"] = Consts.USER_INFO.Id;
                        checkRow["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        checkRow["STATUS"] = cboStatus.EditValue.NullString();

                        checkRow["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        checkRow["QUANTITY"] = txtQuantity.EditValue.NullString();
                        checkRow["UNIT"] = stlUnit.EditValue.NullString();
                        checkRow["PRICE_VN"] = Consts.ZERO;
                        checkRow["PRICE_US"] = Consts.ZERO;
                        checkRow["AMOUNT_VN"] = Consts.ZERO;
                        checkRow["AMOUNT_US"] = Consts.ZERO;
                        checkRow["CAUSE"] = mmCause.EditValue.NullString();
                        checkRow["NOTE"] = mmNote.EditValue.NullString();
                        checkRow["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        checkRow["NAME"] = stlSparePartCode.Text;
                        checkRow["QUANTITY_NG"] = txtQuantity_NG.EditValue.NullString() == string.Empty ? "0" : txtQuantity_NG.EditValue.NullString();
                        checkRow["EXPRIRED_DATE"] = dateExpired.EditValue.NullString() == string.Empty ? "2199-01-01" : dateExpired.EditValue.NullString();
                        checkRow["IS_INTEGRATED"] = cheIsIntegrated.Checked ? "True" : "False";

                        if (cheIsReturn.Checked)
                        {
                            checkRow["RETURN_TIME"] = dateReturnTime.EditValue.NullString();
                        }
                        else
                        {
                            checkRow["RETURN_TIME"] = DBNull.Value;
                        }
                    }
                    else
                    {
                        DataRow row = Data.NewRow();
                        row["RECEIPT_ISSUE_CODE"] = Mode == Consts.MODE_NEW ? "N" : ReceiptCode;
                        row["INT_OUT"] = INOUT;
                        row["CREATE_DATE"] = dateInput.EditValue;
                        row["STOCK_CODE"] = stlKho.EditValue.NullString();
                        row["DEPT_CODE"] = Consts.DEPARTMENT;
                        row["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                        row["USER_SYS"] = Consts.USER_INFO.Id;
                        row["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        row["STATUS"] = cboStatus.EditValue.NullString();

                        row["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        row["QUANTITY"] = txtQuantity.EditValue.NullString();
                        row["UNIT"] = stlUnit.EditValue.NullString();
                        row["PRICE_VN"] = Consts.ZERO;
                        row["PRICE_US"] = Consts.ZERO;
                        row["AMOUNT_VN"] = Consts.ZERO;
                        row["AMOUNT_US"] = Consts.ZERO;
                        row["CAUSE"] = mmCause.EditValue.NullString();
                        row["NOTE"] = mmNote.EditValue.NullString();
                        row["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        row["NAME"] = stlSparePartCode.Text;
                        row["QUANTITY_NG"] = txtQuantity_NG.EditValue.NullString() == string.Empty ? "0" : txtQuantity_NG.EditValue.NullString();
                        row["EXPRIRED_DATE"] = dateExpired.EditValue.NullString() == string.Empty ? "2199-01-01" : dateExpired.EditValue.NullString();
                        row["IS_INTEGRATED"] = cheIsIntegrated.Checked ? "True" : "False";
                        if (cheIsReturn.Checked)
                        {
                            row["RETURN_TIME"] = dateReturnTime.EditValue.NullString();
                        }
                        else
                        {
                            row["RETURN_TIME"] = DBNull.Value;
                        }

                        Data.Rows.Add(row);
                    }
                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn();

                    ClearInputItemAdd();
                }
                else // XUAT KHO
                {
                    if (AddItemWoodIssue())
                    {
                        ClearInputItemAdd();
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private bool AddItemWoodIssue()
        {
            try
            {
                LocationDic.Clear();
                for (int i = 0; i < gvLocation.RowCount; i++)
                {
                    if (!gvLocation.IsRowSelected(i))
                    {
                        gvLocation.SetRowCellValue(i, "QUANTITY_GET", 0);
                    }
                }

                if (!cheIsScanbarcode.Checked) // NHAP KHO HOAC XUAT FIFO
                {
                    if (string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()) ||
                        string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) ||
                        string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                        string.IsNullOrEmpty(stlType.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return false;
                    }

                    if (stlType.EditValue.NullString() == "3") // xuat tra lai
                    {
                        if (string.IsNullOrEmpty(dateReturnTime.EditValue.NullString()))
                        {
                            MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                            return false;
                        }
                    }

                    if (gvLocation.GetSelectedRows().Length == 0)
                    {
                        MsgBox.Show("CHỌN VỊ TRÍ CỦA THIẾT BỊ".Translation(), MsgType.Warning);
                        return false;
                    }

                    // Get location
                    float quantitySum = 0;
                    foreach (int i in gvLocation.GetSelectedRows())
                    {
                        var location = gvLocation.GetRowCellValue(i, "LOCATION").NullString();
                        var condition = gvLocation.GetRowCellValue(i, "CONDITION_CODE").NullString();
                        string quantity = gvLocation.GetRowCellValue(i, "QUANTITY_GET").NullString();
                        string expiredDate = gvLocation.GetRowCellValue(i, "EXPIRED_DATE").NullString();
                        string dateInWareHouse = gvLocation.GetRowCellValue(i, "TIME_IN").NullString();
                        string unit = gvLocation.GetRowCellValue(i, "UNIT").NullString();
                        string poNo = gvLocation.GetRowCellValue(i, "PO_NO").NullString();

                        if (string.IsNullOrEmpty(location))
                        {
                            location = "W";
                        }

                        DateTime exDate;
                        string valueDicItem;
                        if (expiredDate.Contains("2199") || expiredDate == string.Empty || !DateTime.TryParse(expiredDate, out exDate)) // no expired date
                        {
                            valueDicItem = quantity + "_" + condition + "_" + "2199-01-01";
                        }
                        else
                        {
                            valueDicItem = quantity + "_" + condition + "_" + exDate.ToString("yyyy-MM-dd");
                        }

                        DateTime inTime;
                        if (DateTime.TryParse(dateInWareHouse, out inTime)) // in time
                        {
                            valueDicItem += "_" + inTime.ToString("yyyy-MM-dd") + "_" + unit; // location_quantity_condition_expired date_in time_unit
                        }
                        else
                        {
                            valueDicItem += "_" + DateTime.Now.ToString("yyyy-MM-dd") + "_" + unit;
                        }

                        if (poNo != "")
                        {
                            valueDicItem += "_" + poNo; // location_quantity_condition_expired date_in time_unit_poNo : add PO 29-8-2021
                        }

                        if (LocationDic.ContainsKey(location))
                        {
                            LocationDic[location] += "," + location + "_" + valueDicItem;
                        }
                        else
                        {
                            LocationDic.Add(location, valueDicItem);
                        }

                        quantitySum += float.Parse(quantity);
                    }

                    if (quantitySum != float.Parse(txtQuantity.EditValue.NullString()) || LocationDic.Count <= 0)
                    {
                        MsgBox.Show("MSG_QUANTITY_INVALID".Translation(), MsgType.Warning);
                        return false;
                    }

                    DataRow checkRow = Data.Rows.Count > 0 ? Data.Select().FirstOrDefault(x => x["SPARE_PART_CODE"].NullString() == stlSparePartCode.EditValue.NullString()) : null;

                    if (checkRow != null)
                    {
                        checkRow["CREATE_DATE"] = dateInput.EditValue;
                        checkRow["STOCK_CODE"] = stlKho.EditValue.NullString();
                        checkRow["DEPT_CODE"] = Consts.DEPARTMENT;
                        checkRow["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                        checkRow["USER_SYS"] = Consts.USER_INFO.Id;
                        checkRow["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        checkRow["STATUS"] = cboStatus.EditValue.NullString();

                        checkRow["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        checkRow["QUANTITY"] = txtQuantity.EditValue.NullString();
                        checkRow["UNIT"] = stlUnit.EditValue.NullString();

                        checkRow["CAUSE"] = mmCause.EditValue.NullString();
                        checkRow["NOTE"] = mmNote.EditValue.NullString();
                        checkRow["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        checkRow["RETURN_TIME"] = dateReturnTime.EditValue.NullString();

                        string location = string.Empty;
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        checkRow["LOCATION"] = location.Remove(location.Length - 1, 1); // remove ,

                        checkRow["NAME"] = stlSparePartCode.Text;
                    }
                    else
                    {
                        DataRow row = Data.NewRow();
                        row["RECEIPT_ISSUE_CODE"] = Mode == Consts.MODE_NEW ? "N" : ReceiptCode;
                        row["INT_OUT"] = INOUT;
                        row["CREATE_DATE"] = dateInput.EditValue;
                        row["STOCK_CODE"] = stlKho.EditValue.NullString();
                        row["DEPT_CODE"] = Consts.DEPARTMENT;
                        row["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                        row["USER_SYS"] = Consts.USER_INFO.Id;
                        row["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        row["STATUS"] = cboStatus.EditValue.NullString();

                        row["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        row["QUANTITY"] = txtQuantity.EditValue.NullString();
                        row["UNIT"] = stlUnit.EditValue.NullString();
                        row["CAUSE"] = mmCause.EditValue.NullString();
                        row["NOTE"] = mmNote.EditValue.NullString();
                        row["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        row["RETURN_TIME"] = dateReturnTime.EditValue.NullString();

                        string location = string.Empty;
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        row["LOCATION"] = location.Remove(location.Length - 1, 1);

                        row["NAME"] = stlSparePartCode.Text;

                        Data.Rows.Add(row);
                    }


                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn(true);
                }
                else // xuat kho
                {
                    if (gvLocation.GetSelectedRows().Length == 0)
                    {
                        MsgBox.Show("CHỌN VỊ TRÍ CỦA THIẾT BỊ".Translation(), MsgType.Warning);
                        return false;
                    }

                    // find new unit and quanity
                    DataRow checkRow = Data.Rows.Count > 0 ? Data.Select().FirstOrDefault(x => x["SPARE_PART_CODE"].NullString() == stlSparePartCode.EditValue.NullString()) : null;
                    float rateUnit = 1;
                    string newUnit = stlUnit.EditValue.NullString();
                    float newQuantity = float.Parse(gvLocation.Columns["QUANTITY_GET"].SummaryItem.SummaryValue.NullString());

                    if (checkRow != null)
                    {
                        rateUnit = ConvertUnit(checkRow["UNIT"].NullString(), stlUnit.EditValue.NullString(), stlSparePartCode.EditValue.NullString());
                        //rateUnit * float.Parse(checkRow["QUANTITY"].NullString()) + float.Parse(txtQuantity.EditValue.NullString());
                        if (!(newQuantity - (int)newQuantity == 0 || newQuantity * 2 - (int)(newQuantity * 2) == 0)) // quantiy is int number , or .5 : 1; 1.5
                        {
                            rateUnit = ConvertUnit(stlUnit.EditValue.NullString(), checkRow["UNIT"].NullString(), stlSparePartCode.EditValue.NullString());
                            newUnit = checkRow["UNIT"].NullString();
                            newQuantity = rateUnit * newQuantity;//float.Parse(checkRow["QUANTITY"].NullString()) + rateUnit * float.Parse(txtQuantity.EditValue.NullString());
                        }
                    }

                    foreach (int i in gvLocation.GetSelectedRows())
                    {
                        var location = gvLocation.GetRowCellValue(i, "LOCATION").NullString();
                        var condition = gvLocation.GetRowCellValue(i, "CONDITION_CODE").NullString();
                        string quantity = gvLocation.GetRowCellValue(i, "QUANTITY_GET").NullString();
                        string expiredDate = gvLocation.GetRowCellValue(i, "EXPIRED_DATE").NullString();
                        string dateInWareHouse = gvLocation.GetRowCellValue(i, "TIME_IN").NullString();
                        string unit = gvLocation.GetRowCellValue(i, "UNIT").NullString();
                        string poNo = gvLocation.GetRowCellValue(i, "PO_NO").NullString();

                        if (string.IsNullOrEmpty(location))
                        {
                            location = "W";
                        }

                        if (quantity == Consts.ZERO)
                        {
                            MsgBox.Show("MSG_QUANTITY_INVALID".Translation(), MsgType.Warning);
                            return false;
                        }

                        DateTime exDate;
                        string valueDicItem;
                        float Fquantity = float.Parse(quantity) * ConvertUnit(unit, newUnit, stlSparePartCode.EditValue.NullString());
                        if (expiredDate.Contains("2199") || expiredDate == string.Empty || !DateTime.TryParse(expiredDate, out exDate)) // no expired date
                        {
                            valueDicItem = Fquantity + "_" + condition + "_" + "2199-01-01";
                        }
                        else
                        {
                            valueDicItem = Fquantity + "_" + condition + "_" + exDate.ToString("yyyy-MM-dd");
                        }

                        DateTime inTime;
                        if (DateTime.TryParse(dateInWareHouse, out inTime)) // in time
                        {
                            valueDicItem += "_" + inTime.ToString("yyyy-MM-dd") + "_" + newUnit;
                        }
                        else
                        {
                            valueDicItem += "_" + DateTime.Now.ToString("yyyy-MM-dd") + "_" + newUnit;
                        }

                        if (poNo != "")
                        {
                            valueDicItem += "_" + poNo;
                        }

                        float quantityUpdate = 0;
                        if (LocationDic.ContainsKey(location))
                        {
                            string[] ArrItem = LocationDic[location].Split(',');

                            string ItemUpdate = "";
                            int k = 0;
                            foreach (string item in ArrItem)
                            {
                                string[] arr = item.Split('_');

                                if (arr.Length == 5 && k == 0) // quantity_condition_expired date_in time_unit
                                {
                                    quantityUpdate = float.Parse(arr[0]) * ConvertUnit(arr[4], newUnit, stlSparePartCode.EditValue.NullString());
                                    arr[0] = quantityUpdate.NullString();
                                    arr[4] = newUnit;

                                    ItemUpdate += arr[0] + "_" + arr[1] + "_" + arr[2] + "_" + arr[3] + "_" + arr[4] + ",";
                                }
                                else
                                if (arr.Length == 6 && k == 0) // quantity_condition_expired date_in time_unit_poNo
                                {
                                    quantityUpdate = float.Parse(arr[0]) * ConvertUnit(arr[4], newUnit, stlSparePartCode.EditValue.NullString());
                                    arr[0] = quantityUpdate.NullString();
                                    arr[4] = newUnit;

                                    ItemUpdate += arr[0] + "_" + arr[1] + "_" + arr[2] + "_" + arr[3] + "_" + arr[4] + "_" + arr[5] + ",";
                                }
                                else if (arr.Length == 6 && k > 0) // location_quantity_condition_expired date_in time_unit
                                {
                                    quantityUpdate = float.Parse(arr[1]) * ConvertUnit(arr[5], newUnit, stlSparePartCode.EditValue.NullString());
                                    arr[1] = quantityUpdate.NullString();
                                    arr[5] = newUnit;

                                    ItemUpdate += arr[0] + "_" + arr[1] + "_" + arr[2] + "_" + arr[3] + "_" + arr[4] + "_" + arr[5] + ",";
                                }
                                else if (arr.Length == 7) // location_quantity_condition_expired date_in time_unit_poNo
                                {
                                    quantityUpdate = float.Parse(arr[1]) * ConvertUnit(arr[5], newUnit, stlSparePartCode.EditValue.NullString());
                                    arr[1] = quantityUpdate.NullString();
                                    arr[5] = newUnit;

                                    ItemUpdate += arr[0] + "_" + arr[1] + "_" + arr[2] + "_" + arr[3] + "_" + arr[4] + "_" + arr[5] + "_" + arr[6] + ",";
                                }
                                k += 1;
                            }

                            LocationDic[location] = ItemUpdate + location + "_" + valueDicItem;   // location_quantity_condition_expired date_in time_unit_poNo
                        }
                        else
                        {
                            LocationDic.Add(location, valueDicItem);
                        }
                    }

                    if (checkRow != null)
                    {
                        DataRow row = Data.NewRow();

                        row["RECEIPT_ISSUE_CODE"] = Mode == Consts.MODE_NEW ? "N" : ReceiptCode;
                        row["INT_OUT"] = INOUT;
                        row["CREATE_DATE"] = dateInput.EditValue;
                        row["STOCK_CODE"] = stlKho.EditValue.NullString();
                        row["DEPT_CODE"] = Consts.DEPARTMENT;
                        row["USER_CREATE"] = txtUserCreate.EditValue.NullString() == string.Empty ? Consts.USER_INFO.Id : txtUserCreate.EditValue.NullString();
                        row["USER_SYS"] = Consts.USER_INFO.Id;
                        row["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        row["STATUS"] = cboStatus.EditValue.NullString();
                        row["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        row["UNIT"] = newUnit;
                        row["CAUSE"] = mmCause.EditValue.NullString();
                        row["NOTE"] = mmNote.EditValue.NullString();
                        row["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        row["RETURN_TIME"] = dateReturnTime.EditValue.NullString();

                        string location = string.Empty;
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        row["LOCATION"] = location.Remove(location.Length - 1, 1); // remove ,
                        row["NAME"] = stlSparePartCode.Text;
                        row["QUANTITY"] = Math.Round(newQuantity, 3);

                        Data.Rows.Remove(checkRow);
                        Data.Rows.Add(row);
                    }
                    else
                    {
                        DataRow row = Data.NewRow();
                        row["RECEIPT_ISSUE_CODE"] = Mode == Consts.MODE_NEW ? "N" : ReceiptCode;
                        row["INT_OUT"] = INOUT;
                        row["CREATE_DATE"] = dateInput.EditValue;
                        row["STOCK_CODE"] = stlKho.EditValue.NullString();
                        row["DEPT_CODE"] = Consts.DEPARTMENT;
                        row["USER_CREATE"] = txtUserCreate.EditValue.NullString() == string.Empty ? Consts.USER_INFO.Id : txtUserCreate.EditValue.NullString();
                        row["USER_SYS"] = Consts.USER_INFO.Id;
                        row["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                        row["STATUS"] = cboStatus.EditValue.NullString();
                        row["SPARE_PART_CODE"] = stlSparePartCode.EditValue.NullString();
                        row["QUANTITY"] = newQuantity.NullString();//txtQuantity.EditValue.NullString();
                        row["UNIT"] = stlUnit.EditValue.NullString();
                        row["CAUSE"] = mmCause.EditValue.NullString();
                        row["NOTE"] = mmNote.EditValue.NullString();
                        row["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        row["RETURN_TIME"] = dateReturnTime.EditValue.NullString();

                        string location = string.Empty;
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        row["LOCATION"] = location.Remove(location.Length - 1, 1);
                        row["NAME"] = stlSparePartCode.Text;

                        Data.Rows.Add(row);
                    }

                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn(true);
                }

                return true;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            return false;
        }

        private void FormatGridColumn(bool isExport = false)
        {
            gvList.Columns["RECEIPT_ISSUE_CODE"].Visible = false;
            gvList.Columns["STOCK_CODE"].Visible = false;
            gvList.Columns["DEPT_CODE"].Visible = false;
            gvList.Columns["INT_OUT"].Visible = false;
            gvList.Columns["USER_CREATE"].Visible = false;
            gvList.Columns["CREATE_DATE"].Visible = false;
            gvList.Columns["USER_SYS"].Visible = false;
            gvList.Columns["ORDER_CODE"].Visible = false;
            gvList.Columns["STATUS"].Visible = false;
            gvList.Columns["TYPE_IN_OUT_CODE"].Visible = false;

            gvList.Columns["PRICE_VN"].Visible = false;
            gvList.Columns["PRICE_US"].Visible = false;
            gvList.Columns["AMOUNT_VN"].Visible = false;
            gvList.Columns["AMOUNT_US"].Visible = false;
            gvList.Columns["IS_INTEGRATED"].Visible = false;

            #region format column
            //gvList.Columns["PRICE_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            //gvList.Columns["PRICE_VN"].DisplayFormat.FormatString = "c2";

            //gvList.Columns["PRICE_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            //gvList.Columns["PRICE_US"].DisplayFormat.FormatString = "c2";

            //gvList.Columns["AMOUNT_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            //gvList.Columns["AMOUNT_VN"].DisplayFormat.FormatString = "c2";

            //gvList.Columns["AMOUNT_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            //gvList.Columns["AMOUNT_US"].DisplayFormat.FormatString = "c2";
            #endregion

            if (isExport)
            {
                gvList.Columns["QUANTITY_NG"].Visible = false;
                gvList.Columns["EXPRIRED_DATE"].Visible = false;
                gvList.Columns["LOCATION"].Width = 100;
            }
            else
            {
                gvList.Columns["RETURN_TIME"].Visible = false;
                gvList.Columns["LOCATION"].Visible = false;
            }

            this.gvList.OptionsView.ColumnAutoWidth = true;
            //this.gvList.BestFitColumns();
        }

        private void txtQuantity_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
                {
                    if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && !hasFillData)
                    {
                        AutoFillQuantityByLocationSparepart();
                    }
                }

                if (INOUT == Consts.IN && !string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
                {
                    txtQuantity_NG.EditValue = 0;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private bool recheckOk = true;
        private bool hasFillData = false;
        private void gvList_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0 || string.IsNullOrEmpty(stlKho.EditValue.NullString()))
                {
                    return;
                }
                else
                {
                    gvRowClick(e.RowHandle);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvRowClick(int RowHandle)
        {
            hasFillData = false;
            stlSparePartCode.EditValue = gvList.GetDataRow(RowHandle)["SPARE_PART_CODE"].NullString();
            stlUnit.EditValue = gvList.GetDataRow(RowHandle)["UNIT"].NullString();

            stlType.EditValue = gvList.GetDataRow(RowHandle)["TYPE_IN_OUT_CODE"].NullString();
            if (stlType.EditValue.NullString() == "3") // xuat tra lai
            {
                dateReturnTime.EditValue = gvList.GetDataRow(RowHandle)["RETURN_TIME"].NullString();
            }

            if (INOUT == Consts.OUT) // xuat kho
            {
                recheckOk = true;
                conditionFindLocation = string.Empty;

                string[] arrLocation = gvList.GetDataRow(RowHandle)["LOCATION"].NullString().Split(',');
                for (int i = 0; i < arrLocation.Length; i++)
                {
                    conditionFindLocation += GetConditionFromLocation(stlSparePartCode.EditValue.NullString(), arrLocation[i]) + ",";
                }

                conditionFindLocation = conditionFindLocation.Remove(conditionFindLocation.Length - 1, 1);

                string[] arr = gvList.GetDataRow(RowHandle)["LOCATION"].NullString().Split(','); // location_quantity_condition_expired date_in time_unit_poNo,...

                for (int i = 0; i < arr.Length; i++)
                {
                    string[] item = arr[i].Split('_');
                    for (int j = 0; j < gvLocation.DataRowCount; j++)
                    {
                        string expiredDate = gvLocation.GetRowCellValue(j, "EXPIRED_DATE").NullString() == string.Empty ? "2199-01-01" : gvLocation.GetRowCellValue(j, "EXPIRED_DATE").NullString();
                        string inTimeDate = gvLocation.GetRowCellValue(j, "TIME_IN").NullString();
                        string poNo = gvLocation.GetRowCellValue(j, "PO_NO").NullString(); // ad PO NO 29-8-2021

                        bool isCheckPoNo = true;
                        if (item.Length == 7) // have poNo
                        {
                            isCheckPoNo = item[6].NullString() == poNo;
                        }

                        DateTime exDate;
                        DateTime inDate;

                        if (DateTime.TryParse(expiredDate, out exDate) && DateTime.TryParse(inTimeDate, out inDate) &&
                              (
                                gvLocation.GetRowCellValue(j, "LOCATION").NullString() == item[0] &&
                                gvLocation.GetRowCellValue(j, "CONDITION_CODE").NullString() == item[2] &&
                                exDate.ToString("yyyy-MM-dd") == item[3] &&
                                inDate.ToString("yyyy-MM-dd") == item[4] &&
                                isCheckPoNo
                              ) ||
                              (
                                item[0] == "W" &&
                                string.IsNullOrEmpty(gvLocation.GetRowCellValue(j, "LOCATION").NullString()) &&
                                gvLocation.GetRowCellValue(j, "CONDITION_CODE").NullString() == item[2] &&
                                exDate.ToString("yyyy-MM-dd") == item[3] && DateTime.Parse(inTimeDate).ToString("yyyy-MM-dd") == item[4] &&
                                isCheckPoNo
                               )
                            )
                        {
                            if (item[1] == string.Empty) item[1] = "0";

                            gvLocation.SetRowCellValue(j, "QUANTITY_GET", item[1]);

                            if (float.Parse(gvLocation.GetRowCellValue(j, "QUANTITY").NullString()) >= float.Parse(item[1]))
                            {
                                gvLocation.SelectRow(j);
                            }
                            else
                            {
                                recheckOk = false;
                            }
                        }
                    }
                }

                hasFillData = true;
                cheMoreLoaction.Checked = true;
            }

            txtQuantity.EditValue = gvList.GetDataRow(RowHandle)["QUANTITY"].NullString();
            mmCause.EditValue = gvList.GetDataRow(RowHandle)["CAUSE"].NullString();
            mmNote.EditValue = gvList.GetDataRow(RowHandle)["NOTE"].NullString();
            txtQuantity_NG.EditValue = gvList.GetDataRow(RowHandle)["QUANTITY_NG"].NullString() == string.Empty ? "0" : gvList.GetDataRow(RowHandle)["QUANTITY_NG"].NullString();
            cheIsIntegrated.Checked = gvList.GetDataRow(RowHandle)["IS_INTEGRATED"].NullString() == "True" ? true : false;

            string dateEx = gvList.GetDataRow(RowHandle)["EXPRIRED_DATE"].NullString();

            if (dateEx != string.Empty)
            {
                string ymd = DateTime.Parse(dateEx).ToString("yyyy-MM-dd");
                dateExpired.EditValue = ymd == "2199-01-01" ? string.Empty : ymd;
            }
            else
            {
                dateExpired.EditValue = null;
            }

            if ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && cboStatus.EditValue.NullString() == Consts.STATUS_COMPLETE)
            {
                gcLocation.Enabled = false;
            }

            if (Mode == Consts.MODE_VIEW)
            {
                cheMoreLoaction.Checked = false;
                cheMoreLoaction.Enabled = false;
            }

            gvLocation.UpdateSummary();
        }

        private void btnDeleteRow_Click(object sender, EventArgs e)
        {
            try
            {
                DataRow checkRow = Data.Rows.Count > 0 ? Data.Select().FirstOrDefault(x => x["SPARE_PART_CODE"].NullString() == stlSparePartCode.EditValue.NullString()) : null;
                if (checkRow != null)
                {
                    Data.Rows.Remove(checkRow);
                    base.mBindData.BindGridView(gcList, Data);

                    FormatGridColumn(INOUT == Consts.OUT);
                    ClearInputItemAdd();
                    hasFillData = false;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearRow_Click(object sender, EventArgs e)
        {
            ClearItemAdd();
        }

        private void ClearInputItemAdd()
        {
            txtScanbarcode.EditValue = null;
            stlSparePartCode.EditValue = null;
            txtQuantity.EditValue = 0;
            stlUnit.EditValue = null;
            txtQuantity_NG.EditValue = 0;
            mmCause.EditValue = null;
            mmNote.EditValue = null;
            dateReturnTime.EditValue = null;

            if (INOUT == Consts.IN)
            {
                stlType.EditValue = "1";
            }
            else
            {
                stlType.EditValue = "4";
            }

            LocationDic.Clear();
            base.mBindData.BindGridView(gcLocation, new DataTable());
        }

        private void ClearItemAdd()
        {
            try
            {
                hasFillData = false;
                txtScanbarcode.EditValue = null;
                stlSparePartCode.EditValue = null;
                txtQuantity.EditValue = 0;
                stlUnit.EditValue = null;
                txtQuantity_NG.EditValue = 0;
                mmCause.EditValue = null;
                mmNote.EditValue = null;
                dateReturnTime.EditValue = null;
                if (INOUT == Consts.IN)
                {
                    stlType.EditValue = "1";
                }
                else
                {
                    stlType.EditValue = "4";
                }
                Data.Clear();
                LocationDic.Clear();
                base.mBindData.BindGridView(gcList, Data);
                base.mBindData.BindGridView(gcLocation, new DataTable());

                FormatGridColumn(INOUT == "OUT");
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
                if (INOUT == Consts.OUT && Mode == Consts.MODE_UPDATE)
                {
                    for (int i = 0; i < gvList.RowCount; i++)
                    {
                        gvRowClick(i);
                        if (!recheckOk)
                        {
                            break;
                        }
                    }

                    if (recheckOk == false)
                    {
                        MsgBox.Show("DỮ LIỆU KHÔNG HỢP LỆ", MsgType.Warning);
                        return;
                    }
                }

                if (Data.Rows.Count == 0 ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInput.EditValue.NullString()) ||
                    string.IsNullOrEmpty(cboStatus.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (cboStatus.EditValue.NullString() != Consts.STATUS_COMPLETE)
                {
                    DialogResult dialogResult = MsgBox.Show("TRẠNG THÁI ĐANG LÀ '" + cboStatus.EditValue.NullString()+"', ĐỂ XÁC NHẬN TỒN KHO HÃY CHỌN TRẠNG THÁI HOÀN THÀNH, NHẤN OKE ĐỂ CHỈNH SỬA, NHẤN CANCEL ĐỂ TIẾP TỤC".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        return;
                    }
                }

                foreach (DataRow item in Data.Rows)
                {
                    item["STOCK_CODE"] = stlKho.EditValue.NullString();
                    item["DEPT_CODE"] = Consts.DEPARTMENT;
                    item["INT_OUT"] = INOUT;
                    item["ORDER_CODE"] = stlOrderCode.EditValue.NullString(); // PO_NO
                    item["USER_CREATE"] = txtUserCreate.EditValue.NullString() == string.Empty ? Consts.USER_INFO.Id : txtUserCreate.EditValue.NullString();
                    item["CREATE_DATE"] = dateInput.EditValue.NullString();
                    item["STATUS"] = cboStatus.EditValue.NullString();
                    item["USER_SYS"] = Consts.USER_INFO.Id;
                }

                base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.PUT",
                    new string[] { "A_USER", "A_DELIVER_RECEIVER", "A_RETURN_SPARE_PART_ID","A_DEPARMENT" }, "A_DATA",
                    new string[] { Consts.USER_INFO.Id, txtDelivererAndReceiver.EditValue.NullString(), txtPAY_CODE.EditValue.NullString(),Consts.DEPARTMENT }, Data);

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                    if (txtPAY_CODE.EditValue.NullString() != string.Empty)
                    {
                        GetLabelTemplate();
                        PrintLendCode(Data.Rows[0]["SPARE_PART_CODE"].NullString(), txtPAY_CODE.EditValue.NullString(), Math.Ceiling(decimal.Parse(Data.Rows[0]["QUANTITY"].NullString())));
                    }
                    ClearRight();
                    ClearItemAdd();
                }
                else
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearRight();
        }

        private void ClearRight()
        {
            txtDelivererAndReceiver.EditValue = null;
            stlOrderCode.EditValue = null;
            txtUserCreate.EditValue = null;
            dateInput.EditValue = DateTime.Now;
            cboStatus.EditValue = Consts.STATUS_NEW;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (Mode == Consts.MODE_NEW)
                {
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, Components.DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (string.IsNullOrEmpty(ReceiptCode))
                    {
                        return;
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.DELETE", new string[] { "A_RECEIPT_ISSUE_CODE", "A_INOUT", "A_USER", "A_STATUS", "A_DEPARTMENT_INPUT" }, new string[] { ReceiptCode, INOUT, Consts.USER_INFO.Id, cboStatus.EditValue.NullString(),Consts.DEPARTMENT });
                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                        ClearRight();
                        ClearItemAdd();
                        this.Close();
                    }
                    else
                    {
                        MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private bool isScanbarcode = false;
        private string conditionFindLocation;
        private void txtScanbarcode_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                #region check get location is right
                //if (INOUT == Consts.OUT)
                //{
                //    if (e.KeyCode == Keys.Enter)
                //    {
                //        string barcode = txtScanbarcode.EditValue.NullString().ToUpper(); // barcode = ma code + '.' + location + '.' + condition 
                //        if (!string.IsNullOrEmpty(barcode))
                //        {
                //            string[] arr = barcode.Split('.');

                //            bool isSuccess = false;
                //            foreach (DataRow row in Data.Rows) // SP-0009.NG    W_10_OK,W_2_NG
                //            {
                //                if (arr.Length > 0)
                //                {
                //                    if (row["SPARE_PART_CODE"].NullString() == arr[0])
                //                    {
                //                        isSuccess = true;
                //                    }
                //                    else
                //                    {
                //                        continue;
                //                    }
                //                }

                //                string locationSum = row["LOCATION"].NullString();//vi tri_soluong_NG,vitri_soluong_OK
                //                string[] locations = locationSum.Split(',');

                //                for (int i = 0; i < locations.Length; i++)
                //                {
                //                    string condition = locations[i].Split('_')[2];
                //                    string location = locations[i].Split('_')[0];
                //                    if (arr.Length == 2)
                //                    {
                //                        if (arr[1] == Consts.NG)
                //                        {
                //                            isSuccess = arr[1] == condition && location == "W";
                //                        }
                //                        else // arr[1] = location
                //                        {

                //                            isSuccess = (location == arr[1] && condition != Consts.NG);
                //                        }
                //                    }

                //                    if (arr.Length == 3)
                //                    {
                //                        isSuccess = location == arr[1] && condition == arr[2];
                //                    }

                //                    if (isSuccess)
                //                    {
                //                        break;
                //                    }
                //                }
                //            }

                //            if (isSuccess)
                //            {
                //                SoundPlayer soundPlayer = new SoundPlayer(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "OK.wav"));
                //                soundPlayer.Play();
                //            }
                //            else
                //            {
                //                SoundPlayer soundPlayer = new SoundPlayer(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "NG.wav"));
                //                soundPlayer.Play();
                //            }

                //            txtScanbarcode.EditValue = null;
                //        }
                //    }
                //}
                #endregion


                InputLanguage originalInputLang = InputLanguage.CurrentInputLanguage;
                var lang = InputLanguage.InstalledInputLanguages.OfType<InputLanguage>().Where(l => l.Culture.Name.StartsWith("en")).FirstOrDefault();
                if (lang != null)
                {
                    InputLanguage.CurrentInputLanguage = lang;
                }

                if (cheIsScanbarcode.Checked)
                {
                    // new barcode is : MA SAN PHAM$VI TRI$TINH TRANG$NGAY NHAP KHO$NGAY HET HAN$SO LUONG$DON VI$PO_NO
                    // SP-0001$01-01$OK$2021-06-30$2021-06-30$100$PACK$1234
                    if (INOUT == Consts.OUT)
                    {
                        conditionFindLocation = string.Empty;
                        if (e.KeyCode == Keys.Enter)
                        {
                            isScanbarcode = true;
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

                                string poNo = "";
                                if (items.Length > 7)
                                {
                                    poNo = Consts.STR_SPILIT_ON_BARCODE + items[7].NullString();
                                }

                                if (Consts.lstUnicodeUnitErr.Contains(unit))
                                {
                                    unit = Consts.lstUnicodeUnitOK[Consts.lstUnicodeUnitErr.FindIndex(x => x == unit)];
                                }

                                DataRow findRow = Data.Select().FirstOrDefault(x => x["SPARE_PART_CODE"].NullString() == sparepartCode);
                                if (findRow != null)
                                {
                                    string[] arr = findRow["LOCATION"].NullString().Split(',');
                                    for (int i = 0; i < arr.Length; i++)
                                    {
                                        conditionFindLocation += GetConditionFromLocation(sparepartCode, arr[i]) + ",";
                                    }
                                }

                                conditionFindLocation +=
                                    sparepartCode + Consts.STR_SPILIT_ON_BARCODE +
                                    location + Consts.STR_SPILIT_ON_BARCODE +
                                    condition + Consts.STR_SPILIT_ON_BARCODE +
                                    dateInWarehouse + Consts.STR_SPILIT_ON_BARCODE +
                                    dateExpiried + poNo +
                                    Consts.STR_SPILIT_WITH_QUANTITY + quantity + Consts.STR_SPILIT_WITH_QUANTITY + unit;

                                stlSparePartCode.EditValue = sparepartCode;
                                stlUnit.EditValue = unit;
                                txtQuantity.EditValue = quantity;
                            }

                            isScanbarcode = false;
                        }
                    }
                }
                else
                {
                    conditionFindLocation = string.Empty;
                    return;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
                txtScanbarcode.EditValue = null;
            }
        }

        private string GetConditionFromLocation(string sparepartCode, string location)
        {
            if (location != string.Empty)
            {
                //NEW: location_quantity_condition_expired date_in time_unit_poNo,...
                string[] arr = location.Split('_'); //OLD: location_quantity_condition_expired date_in time_unit

                string poNo = "";
                if (arr.Length > 6)
                {
                    poNo = Consts.STR_SPILIT_ON_BARCODE + arr[6];
                }

                string condtion = sparepartCode + Consts.STR_SPILIT_ON_BARCODE +
                                    arr[0] + Consts.STR_SPILIT_ON_BARCODE +
                                    arr[2] + Consts.STR_SPILIT_ON_BARCODE +
                                    arr[4] + Consts.STR_SPILIT_ON_BARCODE +
                                    arr[3] + poNo +
                                    Consts.STR_SPILIT_WITH_QUANTITY + arr[1] + Consts.STR_SPILIT_WITH_QUANTITY + arr[5];
                return condtion;
            }
            return string.Empty;
        }

        private void txtScanbarcode_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void stlSparePartCode_EditValueChanged(object sender, EventArgs e)
        {
            hasFillData = false;
            GetUnitBySparePart();

            if (INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
            {
                GetLocationForSparePart();

                if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && !cheIsScanbarcode.Checked)
                {
                    AutoFillQuantityByLocationSparepart();
                }
            }
        }

        private void GetUnitBySparePart()
        {
            try
            {
                picImg.EditValue = null;

                if (!string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()))
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_UNIT_SPAREPART.GET_UNIT_BY_SPAREPART",
                        new string[] { "A_DEPT_CODE", "A_SPARE_PART_CODE" },
                        new string[] { Consts.DEPARTMENT, stlSparePartCode.EditValue.NullString() });

                    if (mResultDB.ReturnInt == 0)
                    {
                        DataTable data = base.mResultDB.ReturnDataSet.Tables[0];
                        base.mBindData.BindGridLookEdit(stlUnit, data, "CODE", "NAME");

                        if (data.Rows.Count > 0)
                        {
                            stlUnit.EditValue = data.Rows[0]["CODE"].NullString();

                            string image = data.Rows[0]["IMAGE"].NullString();
                            ShowImge(image);
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

        private void AutoFillQuantityByLocationSparepart()
        {
            try
            {
                if (!float.TryParse(txtQuantity.EditValue.NullString(), out _) || float.Parse(txtQuantity.EditValue.NullString()) <= 0)
                {
                    for (int i = 0; i < gvLocation.RowCount; i++)
                    {
                        gvLocation.UnselectRow(i);
                        gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], 0);
                    }
                    return;
                }

                float quantityInput = float.Parse(txtQuantity.EditValue.NullString());

                if (cheIsScanbarcode.Checked)
                {
                    for (int i = 0; i < gvLocation.RowCount; i++)
                    {
                        gvLocation.UnselectRow(i);
                        gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], 0);
                    }

                    bool checkExist = false;
                    string[] arr = conditionFindLocation?.Split(',');

                    if (arr == null) return;

                    for (int k = 0; k < arr.Length; k++)
                    {
                        for (int i = 0; i < gvLocation.RowCount; i++)
                        {
                            float quantity = float.Parse(gvLocation.GetRowCellValue(i, gvLocation.Columns["QUANTITY"]).NullString());
                            string location = gvLocation.GetRowCellValue(i, gvLocation.Columns["LOCATION"]).NullString();
                            string condition = gvLocation.GetRowCellValue(i, gvLocation.Columns["CONDITION_CODE"]).NullString();
                            string dateExpiried = gvLocation.GetRowCellValue(i, gvLocation.Columns["EXPIRED_DATE"]).NullString();
                            string dateInWarehouse = gvLocation.GetRowCellValue(i, gvLocation.Columns["TIME_IN"]).NullString();
                            string poNo = gvLocation.GetRowCellValue(i, "PO_NO").NullString();

                            DateTime dateTimeInWareHouse;
                            if (dateInWarehouse != string.Empty || DateTime.TryParse(dateInWarehouse, out dateTimeInWareHouse))
                            {
                                dateInWarehouse = DateTime.Parse(dateInWarehouse).ToString("yyyy-MM-dd");
                            }
                            else
                            {
                                dateInWarehouse = string.Empty;
                            }

                            dateExpiried = dateExpiried.NullString() == string.Empty ? "2199-01-01" : DateTime.Parse(dateExpiried).ToString("yyyy-MM-dd");

                            string str =
                                  stlSparePartCode.EditValue.NullString() + Consts.STR_SPILIT_ON_BARCODE +
                                  location + Consts.STR_SPILIT_ON_BARCODE +
                                  condition + Consts.STR_SPILIT_ON_BARCODE +
                                  dateInWarehouse + Consts.STR_SPILIT_ON_BARCODE +
                                  dateExpiried;

                            string lo = arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[0].Split(Consts.CHARACTER_SPILIT_ON_BARCODE)[1];// location
                            if (lo == string.Empty || lo == "W")
                            {
                                if (location == string.Empty)
                                {
                                    str =
                                  stlSparePartCode.EditValue.NullString() + Consts.STR_SPILIT_ON_BARCODE +
                                  lo + Consts.STR_SPILIT_ON_BARCODE +
                                  condition + Consts.STR_SPILIT_ON_BARCODE +
                                  dateInWarehouse + Consts.STR_SPILIT_ON_BARCODE +
                                  dateExpiried;
                                }
                            }

                            if (poNo != "")
                            {
                                str += Consts.STR_SPILIT_ON_BARCODE + poNo;
                            }

                            if (str.Equals(arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[0]))
                            {
                                string quantity_get = gvLocation.GetRowCellValue(i, "QUANTITY_GET").NullString();
                                float newQuantity = 0;

                                if (quantity_get != string.Empty)
                                {
                                    newQuantity = ConvertUnit(arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[2], stlUnit.EditValue.NullString(), stlSparePartCode.EditValue.NullString()) * float.Parse(arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[1]) + float.Parse(quantity_get);
                                }
                                else
                                {
                                    newQuantity = ConvertUnit(arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[2], stlUnit.EditValue.NullString(), stlSparePartCode.EditValue.NullString()) * float.Parse(arr[k].Split(Consts.CHAR_SPILIT_WITH_QUANTITY)[1]);
                                }

                                if (newQuantity <= quantity)
                                {
                                    gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], newQuantity);
                                    gvLocation.SelectRow(i);
                                    gvLocation.UpdateCurrentRow();
                                    checkExist = true;
                                }
                                else
                                {
                                    MsgBox.Show("MSG_QUANTITY_INVALID".Translation(), MsgType.Warning);
                                    txtScanbarcode.Text = string.Empty;
                                    txtQuantity.Text = "0";
                                    isScanbarcode = false;
                                }
                                break;
                            }
                        }
                    }
                    if (!checkExist)
                    {
                        // MsgBox.Show("NOT FOUND!", MsgType.Warning);
                        txtScanbarcode.Text = string.Empty;
                        txtQuantity.Text = "0";
                    }
                    else
                    {
                        if (isScanbarcode)
                        {
                            AddItemWoodIssue();
                            txtScanbarcode.Text = null;
                            txtQuantity.EditValue = 0;
                            //ClearInputItemAdd();
                        }
                    }
                }
                else
                {
                    for (int i = 0; i < gvLocation.RowCount; i++)
                    {
                        gvLocation.UnselectRow(i);
                        gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], 0);
                    }

                    float tmpQuantity = 0;
                    for (int i = 0; i < gvLocation.RowCount; i++)
                    {
                        float quantity = float.Parse(gvLocation.GetRowCellValue(i, gvLocation.Columns["QUANTITY"]).NullString());
                        if (tmpQuantity < quantityInput)
                        {
                            if (tmpQuantity + quantity <= quantityInput)
                            {
                                tmpQuantity += quantity;

                                gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], quantity);
                                gvLocation.SelectRow(i);
                            }
                            else
                            {
                                gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], (quantityInput - tmpQuantity));
                                tmpQuantity += (quantityInput - tmpQuantity);
                                gvLocation.SelectRow(i);
                                break;
                            }
                        }
                    }
                }

                gvLocation.UpdateSummary();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private DataTable LocationData;
        private void GetLocationForSparePart()
        {
            try
            {
                if (!string.IsNullOrEmpty(stlKho.EditValue.NullString()) &&
                    !string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()) &&
                    !string.IsNullOrEmpty(stlUnit.EditValue.NullString()))
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.GET_LOCATION_BY_SPAREPART",
                        new string[] { "A_STOCK_CODE", "A_DEPT_CODE", "A_SPARE_PART_CODE", "A_UNIT" },
                        new string[] { stlKho.EditValue.NullString(), Consts.DEPARTMENT, stlSparePartCode.EditValue.NullString(), stlUnit.EditValue.NullString() });

                    if (mResultDB.ReturnInt == 0)
                    {
                        LocationData = mResultDB.ReturnDataSet.Tables[0];
                        base.mBindData.BindGridView(gcLocation, LocationData);

                        gvLocation.OptionsSelection.MultiSelect = true;
                        gvLocation.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                        gvLocation.OptionsBehavior.Editable = true;
                        gvLocation.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["CONDITION_CODE"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["UNIT"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["EXPIRED_DATE"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["PO_NO"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["QUANTITY_GET"].OptionsColumn.AllowEdit = true;
                        gvLocation.Columns["QUANTITY"].SummaryItem.DisplayFormat = "{0:n3}";
                        gvLocation.Columns["QUANTITY_GET"].SummaryItem.DisplayFormat = "{0:n3}";
                        gvLocation.OptionsView.ColumnAutoWidth = true;
                    }
                    else
                    {
                        LocationData = new DataTable();
                        base.mBindData.BindGridView(gcLocation, new DataTable());
                    }

                    if (INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
                    {
                        if (!cheIsScanbarcode.Checked)
                        {
                            AutoFillQuantityByLocationSparepart();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlUnit_EditValueChanged(object sender, EventArgs e)
        {
            GetLocationForSparePart();
        }

        private void stlKho_EditValueChanged(object sender, EventArgs e)
        {
            GetLocationForSparePart();
        }

        private void gvLocation_CellValueChanged(object sender, CellValueChangedEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }

                if (e.Column.FieldName == "QUANTITY_GET" && CurrentStatus != Consts.STATUS_COMPLETE)
                {
                    var quantity_get = gvLocation.GetDataRow(e.RowHandle)["QUANTITY_GET"].NullString();
                    var quantity = gvLocation.GetDataRow(e.RowHandle)["QUANTITY"].NullString();

                    if (float.Parse(quantity_get) > float.Parse(quantity))
                    {
                        gvLocation.UnselectRow(e.RowHandle);
                        gvLocation.GetDataRow(e.RowHandle)["QUANTITY_GET"] = 0.0;
                        MsgBox.Show("MSG_QUANTITY_INVALID".Translation(), MsgType.Warning);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }


        private void gvLocation_RowCellClick(object sender, RowCellClickEventArgs e)
        {

        }

        private void stlType_EditValueChanged(object sender, EventArgs e)
        {
            if (stlType.EditValue.NullString() == "3")// xuat tra lai
            {
                dateReturnTime.Enabled = true;
            }
            else
            {
                dateReturnTime.Enabled = false;
                dateReturnTime.EditValue = null;
            }
        }

        private void gvLocation_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            try
            {
                if (e.Column.FieldName != "QUANTITY_GET")
                {
                    e.Appearance.BackColor = Color.LightGoldenrodYellow;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearInput_Click(object sender, EventArgs e)
        {
            ClearInputItemAdd();
        }

        private void btnPrintReport_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
            Print();
        }

        private void Print()
        {
            try
            {
                if (INOUT == Consts.IN)
                    return;

                if (Data.Rows.Count == 0 ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInput.EditValue.NullString()) ||
                    string.IsNullOrEmpty(cboStatus.EditValue.NullString()) ||
                    Data.Rows.Count == 0)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                STOCK_OUT_DATA_SOURCE source = new STOCK_OUT_DATA_SOURCE();
                source.lstReport = new List<STOCK_OUT_REPORT>();

                foreach (DataRow row in Data.Rows)
                {
                    string locations = row["LOCATION"].NullString();
                    foreach (var item in locations.Split(','))
                    {
                        STOCK_OUT_REPORT reportModel = new STOCK_OUT_REPORT();
                        reportModel.Day = DateTime.Parse(dateInput.EditValue.NullString()).Day.NullString();
                        reportModel.Month = DateTime.Parse(dateInput.EditValue.NullString()).Month.NullString();
                        reportModel.Year = DateTime.Parse(dateInput.EditValue.NullString()).Year.NullString();
                        reportModel.UserReive = txtDelivererAndReceiver.EditValue.NullString();
                        reportModel.UserCreate = txtUserCreate.EditValue.NullString();

                        reportModel.ID = row["SPARE_PART_CODE"].NullString();
                        reportModel.Name = SparePartData.Select("CODE = '" + reportModel.ID + "'").FirstOrDefault()["NAME_VI"].NullString();
                        reportModel.Unit = row["UNIT"].NullString();

                        reportModel.Quantity = Math.Round(float.Parse(item.Split('_')[1].NullString()), 3).NullString();
                        reportModel.Location = item.Split('_')[0].NullString();
                        reportModel.Condition = item.Split('_')[2].NullString();

                        source.lstReport.Add(reportModel);
                    }
                }

                StockOutReport report = new StockOutReport();
                report.DataSource = source.GetReport();
                ReportPrintTool tool = new ReportPrintTool(report);
                tool.ShowPreview();
                //tool.Print();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_CustomColumnDisplayText(object sender, CustomColumnDisplayTextEventArgs e)
        {
            #region format money
            //if (e.Column.FieldName == "PRICE_VN" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            //{
            //    float price = float.Parse(e.Value.NullString());
            //    e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            //}
            //else
            //if (e.Column.FieldName == "PRICE_US" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            //{
            //    float price = float.Parse(e.Value.NullString());
            //    e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            //}
            //else
            //if (e.Column.FieldName == "AMOUNT_VN" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            //{
            //    float price = float.Parse(e.Value.NullString());
            //    e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            //}
            //else
            //if (e.Column.FieldName == "AMOUNT_US" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            //{
            //    float price = float.Parse(e.Value.NullString());
            //    e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            //}
            #endregion
        }

        private void cheMoreLoaction_CheckedChanged(object sender, EventArgs e)
        {
            gvLocation.ActiveFilter.Clear();
            if (!cheMoreLoaction.Checked) // LOAD LESS DATA
            {
                gvLocation.ActiveFilterString = "[QUANTITY_GET] > 0";
            }
        }

        private void ShowImge(string image)
        {
            if (!string.IsNullOrWhiteSpace(image))
            {
                byte[] imagebytes = Convert.FromBase64String(image);
                using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                {
                    picImg.Image = Image.FromStream(ms, true);
                }
                picImg.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                picImg.Size = picImg.Image.Size;
            }
        }

        private void cheIsScanbarcode_CheckedChanged(object sender, EventArgs e)
        {
            txtScanbarcode.Enabled = cheIsScanbarcode.Checked;
            stlSparePartCode.Enabled = !cheIsScanbarcode.Checked;
            stlMemoryData.Enabled = !cheIsScanbarcode.Checked;

            if (!cheIsScanbarcode.Checked)
            {
                hasFillData = false;
            }
            ClearInputItemAdd();
        }

        private float ConvertUnit(string unitFrom, string unitTo, string spareCode)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_ALL.CONVERT_UNIT",
                      new string[] { "A_UNIT_FROM", "A_UNIT_TO", "A_SPARE_PART_CODE", "A_DEPT_CODE" },
                      new string[] { unitFrom, unitTo, spareCode, Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    if (mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        return float.Parse(mResultDB.ReturnDataSet.Tables[0].Rows[0]["RESULT"].NullString());
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            return 1;
        }

        private void btnClearMemory_Click(object sender, EventArgs e)
        {
            try
            {
                Consts.GetDataMemory().Rows.Clear();
                mBindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");
                MsgBox.Show("MSG_COM_004".Translation(), MsgType.Information);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlMemoryData_EditValueChanged(object sender, EventArgs e)
        {
            stlSparePartCode.EditValue = stlMemoryData.EditValue;
        }

        private void cheIsIntegrated_CheckedChanged(object sender, EventArgs e)
        {
            txtQuantity_NG.Enabled = !cheIsIntegrated.Checked;
        }

        private void cheIsReturn_CheckedChanged(object sender, EventArgs e)
        {
            if (cheIsReturn.Checked && INOUT == "IN")
            {
                dateReturnTime.EditValue = DateTime.Now;
                btnListSparepartPay.Enabled = true;
            }
            else
            {
                btnListSparepartPay.Enabled = false;
            }
        }

        private void btnListSparepartPay_Click(object sender, EventArgs e)
        {
            if (stlSparePartCode.EditValue.NullString() == string.Empty)
                return;

            POP.SPAREPART_LEND pop = new SPAREPART_LEND();
            pop.sparepartCode = stlSparePartCode.EditValue.NullString();
            pop.ShowDialog();
            txtPAY_CODE.Text = SPAREPART_LEND.PAY_CODE;
        }

        /// <summary>
        /// Tạo mã mượn
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void simpleButton1_Click(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_MRP.CREATE_LEND_CODE",
                     new string[] { "A_DEPARTMENT" },
                     new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    if (mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        txtPAY_CODE.EditValue = mResultDB.ReturnDataSet.Tables[0].Rows[0]["CODE"].NullString();
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        #region print LEND CODE
        private void PrintLendCode(string spareCode, string lendCode, decimal numberLabel)
        {
            #region print
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

                for (int j = 0; j < numberLabel; j++)
                {
                    xml_content = label;

                    xml_content = xml_content.Replace("$BARCODE$", lendCode).Replace("$CODE$", spareCode).Replace("$POSITION$", lendCode).Replace("$EXP_DATE$", "IN TIME:" + DateTime.Now.ToString("yyyy-MM-dd"));

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

        private PrinterSettings prnSettings;
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
                PrinterSettings settings = new PrinterSettings();
                label = string.Empty;
                string LabelCode = "QRCODE_" + settings.PrinterName;
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET_TEMP", new string[] { "A_CODE_TEMP" }, new string[] { LabelCode });//QRCODE
                if (mResultDB.ReturnInt == 0)
                {
                    if (base.mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        label = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["LABEL"].NullString();
                    }
                    else
                    {
                        MsgBox.Show("Không có File label cho printer " + settings.PrinterName, MsgType.Warning);
                    }
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        #endregion
    }
}
