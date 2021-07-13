using DevExpress.XtraEditors.Repository;
using DevExpress.XtraGrid.Views.Base;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Media;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
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
            InitData();

        }

        public DataTable Data { get; set; }
        private List<string> Status = new List<string>() { "NEW", "INPROGRESS", "COMPLETE" };
        private DataTable STATUS = new DataTable();

        public string Mode { get; set; }
        public string ReceiptCode { get; set; }
        public string INOUT { get; set; }

        private float ExchangeRate;
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

                base.mBindData.BindGridLookEdit(cboStatus, STATUS, "CODE", "NAME");

                dateInput.EditValue = DateTime.Now;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (mResultDB.ReturnInt == 0)
                {
                    SparePartData = base.mResultDB.ReturnDataSet.Tables[1];
                    base.mBindData.BindGridLookEdit(stlSparePartCode, base.mResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.mBindData.BindGridLookEdit(stlKho, base.mResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.mBindData.BindGridLookEdit(stlOrderCode, base.mResultDB.ReturnDataSet.Tables[4], "ORDER_ID", "TITLE");

                    DataTable tmp = new DataTable();
                    tmp.Columns.Add("CODE");
                    tmp.Columns.Add("NAME");
                    string selectedValueFirt = "";
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

                    stlKho.EditValue = base.mResultDB.ReturnDataSet.Tables[2].Rows[0]["CODE"].NullString();

                    if (float.TryParse(base.mResultDB.ReturnDataSet.Tables[6].Rows[0]["RATE"].NullString(), out float rate))
                    {
                        lbRate.Text = "Exchange Rate (USD/VN): " + rate.ToString("C2", CultureInfo.CurrentCulture);
                        ExchangeRate = rate;
                    }
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

                if(Mode == Consts.MODE_NEW)
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
                            "",
                            "",
                            "",
                            item["CREATE_DATE"].NullString(), "", "", "", "",
                            item["TYPE_IN_OUT_CODE"].NullString(),
                            item["RETURN_TIME"].NullString(),
                            item["LOCATION"].NullString()
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
                    txtPriceVN.Enabled = true;
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
                    txtPriceVN.Enabled = false;
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
                            string.IsNullOrEmpty(txtPriceVN.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtPriceUS.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtAmountVN.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtAmountUS.EditValue.NullString()) ||
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
                        checkRow["PRICE_VN"] = txtPriceVN.EditValue.NullString();
                        checkRow["PRICE_US"] = txtPriceUS.EditValue.NullString();
                        checkRow["AMOUNT_VN"] = txtAmountVN.EditValue.NullString();
                        checkRow["AMOUNT_US"] = txtAmountUS.EditValue.NullString();
                        checkRow["CAUSE"] = mmCause.EditValue.NullString();
                        checkRow["NOTE"] = mmNote.EditValue.NullString();
                        checkRow["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        checkRow["NAME"] = stlSparePartCode.SelectedText;
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
                        row["PRICE_VN"] = txtPriceVN.EditValue.NullString();
                        row["PRICE_US"] = txtPriceUS.EditValue.NullString();
                        row["AMOUNT_VN"] = txtAmountVN.EditValue.NullString();
                        row["AMOUNT_US"] = txtAmountUS.EditValue.NullString();
                        row["CAUSE"] = mmCause.EditValue.NullString();
                        row["NOTE"] = mmNote.EditValue.NullString();
                        row["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        row["NAME"] = stlSparePartCode.SelectedText;

                        Data.Rows.Add(row);
                    }
                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn();
                }
                else // XUAT KHO
                {
                    if (string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()) ||
                        string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) ||
                        string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                        string.IsNullOrEmpty(stlType.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    if (stlType.EditValue.NullString() == "3") // xuat tra lai
                    {
                        if (string.IsNullOrEmpty(dateReturnTime.EditValue.NullString()))
                        {
                            MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                            return;
                        }
                    }

                    LocationDic.Clear();

                    // Get location
                    float quantitySum = 0;
                    foreach (int i in gvLocation.GetSelectedRows())
                    {
                        var location = gvLocation.GetRowCellValue(i, "LOCATION").NullString();
                        var condition = gvLocation.GetRowCellValue(i, "CONDITION_CODE").NullString();
                        string quantity = gvLocation.GetRowCellValue(i, "QUANTITY_GET").NullString();
                        string expiredDate = gvLocation.GetRowCellValue(i, "EXPIRED_DATE").NullString();

                        if (string.IsNullOrEmpty(location))
                        {
                            location = "W";
                        }

                        DateTime exDate;
                        string valueDicItem;
                        if (expiredDate.Contains("2199") || expiredDate == "" || !DateTime.TryParse(expiredDate, out exDate)) // no expired date
                        {
                            valueDicItem = quantity + "_" + condition + "_" + "2199-01-01";
                        }
                        else
                        {
                            valueDicItem = quantity + "_" + condition + "_" + exDate.ToString("yyyy-MM-dd");
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

                        checkRow["CAUSE"] = mmCause.EditValue.NullString();
                        checkRow["NOTE"] = mmNote.EditValue.NullString();
                        checkRow["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                        checkRow["RETURN_TIME"] = dateReturnTime.EditValue.NullString();

                        string location = "";
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        checkRow["LOCATION"] = location.Remove(location.Length - 1, 1); // remove ,

                        checkRow["NAME"] = stlSparePartCode.SelectedText;
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

                        string location = "";
                        foreach (var item in LocationDic)
                        {
                            location += item.Key + "_" + item.Value + ",";
                        }

                        row["LOCATION"] = location.Remove(location.Length - 1, 1);

                        row["NAME"] = stlSparePartCode.SelectedText;

                        Data.Rows.Add(row);
                    }


                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn(true);
                }

                ClearInputItemAdd();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
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
                gvList.Columns["PRICE_VN"].Visible = false;
                gvList.Columns["PRICE_US"].Visible = false;
                gvList.Columns["AMOUNT_VN"].Visible = false;
                gvList.Columns["AMOUNT_US"].Visible = false;
            }
            else
            {
                gvList.Columns["RETURN_TIME"].Visible = false;
                gvList.Columns["LOCATION"].Visible = false;
            }

            this.gvList.OptionsView.ColumnAutoWidth = true;
            //this.gvList.BestFitColumns();
        }

        private void txtPriceVN_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                float priceVN = float.Parse(txtPriceVN.EditValue.NullString());
                txtPriceUS.EditValue = Math.Round(priceVN / ExchangeRate, 3);

                if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
                {
                    txtAmountVN.EditValue = priceVN * float.Parse(txtQuantity.EditValue.NullString());
                    txtAmountUS.EditValue = Math.Round(priceVN / ExchangeRate, 3) * float.Parse(txtQuantity.EditValue.NullString());
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtQuantity_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
                {
                    if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
                    {
                        AutoFillQuantityByLocationSparepart();
                    }
                }

                if (INOUT == Consts.IN && !string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && !string.IsNullOrEmpty(txtPriceVN.EditValue.NullString()))
                {
                    float priceVN = float.Parse(txtPriceVN.EditValue.NullString());

                    txtAmountVN.EditValue = priceVN * float.Parse(txtQuantity.EditValue.NullString());
                    txtAmountUS.EditValue = Math.Round(priceVN / ExchangeRate, 3) * float.Parse(txtQuantity.EditValue.NullString());
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtAmountVN_Leave(object sender, EventArgs e)
        {
        }

        private void txtPriceVN_Leave(object sender, EventArgs e)
        {
            txtPriceVN.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            txtPriceVN.Properties.DisplayFormat.FormatString = "c2";
        }

        private void txtPriceUS_EditValueChanged(object sender, EventArgs e)
        {
            txtPriceUS.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            txtPriceUS.Properties.DisplayFormat.FormatString = "c2";
        }

        private void txtAmountVN_EditValueChanged(object sender, EventArgs e)
        {
            txtAmountVN.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            txtAmountVN.Properties.DisplayFormat.FormatString = "c2";
        }

        private void txtAmountUS_EditValueChanged(object sender, EventArgs e)
        {
            txtAmountUS.Properties.DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            txtAmountUS.Properties.DisplayFormat.FormatString = "c2";
        }

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
                    stlSparePartCode.EditValue = gvList.GetDataRow(e.RowHandle)["SPARE_PART_CODE"].NullString();
                    txtQuantity.EditValue = gvList.GetDataRow(e.RowHandle)["QUANTITY"].NullString();
                    stlUnit.EditValue = gvList.GetDataRow(e.RowHandle)["UNIT"].NullString();

                    if (INOUT == Consts.IN)
                    {
                        txtPriceVN.EditValue = gvList.GetDataRow(e.RowHandle)["PRICE_VN"].NullString();
                    }

                    stlType.EditValue = gvList.GetDataRow(e.RowHandle)["TYPE_IN_OUT_CODE"].NullString();
                    if (stlType.EditValue.NullString() == "3") // xuat tra lai
                    {
                        dateReturnTime.EditValue = gvList.GetDataRow(e.RowHandle)["RETURN_TIME"].NullString();
                    }

                    if (INOUT == Consts.OUT)
                    {
                        string[] arr = gvList.GetDataRow(e.RowHandle)["LOCATION"].NullString().Split(',');

                        for (int i = 0; i < arr.Length; i++)
                        {
                            string[] item = arr[i].Split('_');
                            for (int j = 0; j < gvLocation.DataRowCount; j++)
                            {
                                string expiredDate = gvLocation.GetRowCellValue(j, "EXPIRED_DATE").NullString();
                                DateTime exDate;

                                if (DateTime.TryParse(expiredDate, out exDate) &&
                                      (
                                        gvLocation.GetRowCellValue(j, "LOCATION").NullString() == item[0] &&
                                        gvLocation.GetRowCellValue(j, "CONDITION_CODE").NullString() == item[2] &&
                                        exDate.ToString("yyyy-MM-dd") == item[3]
                                      ) ||
                                      (
                                        item[0] == "W" &&
                                        string.IsNullOrEmpty(gvLocation.GetRowCellValue(j, "LOCATION").NullString()) &&
                                        gvLocation.GetRowCellValue(j, "CONDITION_CODE").NullString() == item[2] &&
                                        exDate.ToString("yyyy-MM-dd") == item[3])
                                    )
                                {
                                    gvLocation.SetRowCellValue(j, "QUANTITY_GET", item[1]);
                                    gvLocation.SelectRow(j);
                                }
                            }
                        }

                        cheMoreLoaction.Checked = true;
                    }

                    mmCause.EditValue = gvList.GetDataRow(e.RowHandle)["CAUSE"].NullString();
                    mmNote.EditValue = gvList.GetDataRow(e.RowHandle)["NOTE"].NullString();

                    if ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && cboStatus.EditValue.NullString() == Consts.STATUS_COMPLETE)
                    {
                        gcLocation.Enabled = false;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
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
                    FormatGridColumn();
                    ClearInputItemAdd();
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
            txtPriceVN.EditValue = 0;
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
                txtScanbarcode.EditValue = null;
                stlSparePartCode.EditValue = null;
                txtQuantity.EditValue = 0;
                stlUnit.EditValue = null;
                txtPriceVN.EditValue = 0;
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
                if (Data.Rows.Count == 0 ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInput.EditValue.NullString()) ||
                    string.IsNullOrEmpty(cboStatus.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                foreach (DataRow item in Data.Rows)
                {
                    item["STOCK_CODE"] = stlKho.EditValue.NullString();
                    item["DEPT_CODE"] = Consts.DEPARTMENT;
                    item["INT_OUT"] = INOUT;
                    item["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                    item["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                    item["CREATE_DATE"] = dateInput.EditValue.NullString();
                    item["STATUS"] = cboStatus.EditValue.NullString();
                    item["USER_SYS"] = Consts.USER_INFO.Id;
                }

                base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.PUT",
                    new string[] { "A_USER", "A_DELIVER_RECEIVER", "A_MODE" }, "A_DATA",
                    new string[] { Consts.USER_INFO.Id, txtDelivererAndReceiver.EditValue.NullString(), Mode }, Data);

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
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

                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.DELETE", new string[] { "A_RECEIPT_ISSUE_CODE", "A_INOUT", "A_USER", "A_STATUS" }, new string[] { ReceiptCode, INOUT, Consts.USER_INFO.Id, cboStatus.EditValue.NullString() });
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

        private void stlSparePartCode_Enter(object sender, EventArgs e)
        {

        }

        private void txtScanbarcode_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (INOUT == Consts.OUT)
                {
                    if (e.KeyCode == Keys.Enter)
                    {
                        string barcode = txtScanbarcode.EditValue.NullString().ToUpper(); // barcode = ma code + '.' + location + '.' + condition 
                        if (!string.IsNullOrEmpty(barcode))
                        {
                            string[] arr = barcode.Split('.');

                            bool isSuccess = false;
                            foreach (DataRow row in Data.Rows) // SP-0009.NG    W_10_OK,W_2_NG
                            {
                                if (arr.Length > 0)
                                {
                                    if (row["SPARE_PART_CODE"].NullString() == arr[0])
                                    {
                                        isSuccess = true;
                                    }
                                    else
                                    {
                                        continue;
                                    }
                                }

                                string locationSum = row["LOCATION"].NullString();//vi tri_soluong_NG,vitri_soluong_OK
                                string[] locations = locationSum.Split(',');

                                for (int i = 0; i < locations.Length; i++)
                                {
                                    string condition = locations[i].Split('_')[2];
                                    string location = locations[i].Split('_')[0];
                                    if (arr.Length == 2)
                                    {
                                        if (arr[1] == Consts.NG)
                                        {
                                            isSuccess = arr[1] == condition && location == "W";
                                        }
                                        else // arr[1] = location
                                        {

                                            isSuccess = (location == arr[1] && condition != Consts.NG);
                                        }
                                    }

                                    if (arr.Length == 3)
                                    {
                                        isSuccess = location == arr[1] && condition == arr[2];
                                    }

                                    if (isSuccess)
                                    {
                                        break;
                                    }
                                }
                            }

                            if (isSuccess)
                            {
                                SoundPlayer soundPlayer = new SoundPlayer(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "OK.wav"));
                                soundPlayer.Play();
                            }
                            else
                            {
                                SoundPlayer soundPlayer = new SoundPlayer(Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "NG.wav"));
                                soundPlayer.Play();
                            }

                            txtScanbarcode.EditValue = null;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtScanbarcode_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void stlSparePartCode_EditValueChanged(object sender, EventArgs e)
        {
            GetUnitBySparePart();

            if(INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode== Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
            {
                GetLocationForSparePart();

                if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
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
                for (int i = 0; i < gvLocation.RowCount; i++)
                {
                    gvLocation.UnselectRow(i);
                    gvLocation.SetRowCellValue(i, gvLocation.Columns["QUANTITY_GET"], 0);
                }

                if (!float.TryParse(txtQuantity.EditValue.NullString(), out _) || float.Parse(txtQuantity.EditValue.NullString()) <= 0)
                {
                    return;
                }

                float quantityInput = float.Parse(txtQuantity.EditValue.NullString());
                float tmpQuantity = 0;
                for (int i = 0; i < gvLocation.RowCount; i++)
                {
                    float quantity = float.Parse(gvLocation.GetRowCellValue(i, gvLocation.Columns["QUANTITY"]).NullString());
                    if (tmpQuantity < quantityInput)
                    {
                        if(tmpQuantity + quantity <= quantityInput)
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
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

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
                        //gcLocation.DataSource = mResultDB.ReturnDataSet.Tables[0];
                        base.mBindData.BindGridView(gcLocation, mResultDB.ReturnDataSet.Tables[0]);

                        gvLocation.OptionsSelection.MultiSelect = true;
                        gvLocation.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                        gvLocation.OptionsBehavior.Editable = true;
                        gvLocation.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["CONDITION_CODE"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["UNIT"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["EXPIRED_DATE"].OptionsColumn.AllowEdit = false;
                        gvLocation.Columns["QUANTITY_GET"].OptionsColumn.AllowEdit = true;
                        //gvLocation.AutoFillColumn = gvLocation.Columns["QUANTITY_GET"];
                        gvLocation.OptionsView.ColumnAutoWidth = true;
                    }
                    else
                    {
                        base.mBindData.BindGridView(gcLocation, new DataTable());
                    }


                    if (INOUT == Consts.OUT && (Mode == Consts.MODE_NEW || ((Mode == Consts.MODE_UPDATE || Mode == Consts.MODE_DELETE) && CurrentStatus != Consts.STATUS_COMPLETE)))
                    {
                        AutoFillQuantityByLocationSparepart();
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
                        MsgBox.Show("MSG_QUANTITY_INVALID".Translation(), MsgType.Warning);
                        gvLocation.GetDataRow(e.RowHandle)["QUANTITY_GET"] = 0.0;
                        gvLocation.UnselectRow(e.RowHandle);
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

                        reportModel.Quantity = item.Split('_')[1].NullString();
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
            if (e.Column.FieldName == "PRICE_VN" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            {
                float price = float.Parse(e.Value.NullString());
                e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            }
            else
            if (e.Column.FieldName == "PRICE_US" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            {
                float price = float.Parse(e.Value.NullString());
                e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            }
            else
            if (e.Column.FieldName == "AMOUNT_VN" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            {
                float price = float.Parse(e.Value.NullString());
                e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            }
            else
            if (e.Column.FieldName == "AMOUNT_US" && e.ListSourceRowIndex != DevExpress.XtraGrid.GridControl.InvalidRowHandle)
            {
                float price = float.Parse(e.Value.NullString());
                e.DisplayText = string.Format(new CultureInfo("en-US"), "{0:c}", price);

            }
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
    }
}
