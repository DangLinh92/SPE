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
    public partial class GOODS_RECEIPT : FormType
    {
        public GOODS_RECEIPT()
        {
            InitializeComponent();
        }

        private void GOODS_RECEIPT_Load(object sender, EventArgs e)
        {
            grcontrolGoodReceipt.Text = INOUT == Consts.IN ? "Goods receipt-Nhập kho-입고" : "Goods Issue-Xuất kho-출고";
            InitData();
        }

        public DataTable Data { get; set; }
        private List<string> Status = new List<string>() { "NEW", "INPROGRESS", "COMPLETE" };
        public string Mode { get; set; }
        public string ReceiptCode { get; set; }
        public string INOUT { get; set; }

        private float ExchangeRate;
        public string StockCode { get; set; }

        private void InitData()
        {
            try
            {
                Data = new DataTable();
                Data.Columns.Add("RECEIPT_ISSUE_CODE", typeof(string));
                Data.Columns.Add("SPARE_PART_CODE", typeof(string));
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

                cboStatus.DataSource = Status;
                dateInput.EditValue = DateTime.Now;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (mResultDB.ReturnInt == 0)
                {
                    base.mBindData.BindGridLookEdit(stlSparePartCode, base.mResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.mBindData.BindGridLookEdit(stlKho, base.mResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.mBindData.BindGridLookEdit(stlOrderCode, base.mResultDB.ReturnDataSet.Tables[4], "ORDER_ID", "TITLE");
                    base.mBindData.BindGridLookEdit(stlType, base.mResultDB.ReturnDataSet.Tables[5], "CODE", "NAME");
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
            }

            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.INIT", new string[] { "A_STOCK_INT_OUT_CODE", "A_DEPT_CODE", "A_STOCK_CODE" }, new string[] { ReceiptCode, Consts.DEPARTMENT, StockCode });
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
                            item["QUANTITY"].NullString(),
                            item["UNIT"].NullString(),
                            item["PRICE_VN"].NullString(),
                            item["PRICE_US"].NullString(),
                            item["AMOUNT_VN"].NullString(),
                            item["AMOUNT_US"].NullString(),
                            item["CAUSE"].NullString(),
                            item["NOTE"].NullString()
                        );
                }
                base.mBindData.BindGridView(gcList, Data);
                FormatGridColumn();

                if (righttData.Rows.Count > 0)
                {
                    stlKho.EditValue = righttData.Rows[0]["STOCK_CODE"];
                    stlType.EditValue = righttData.Rows[0]["TYPE_IN_CODE"];
                    stlOrderCode.EditValue = righttData.Rows[0]["ORDER_CODE"];
                    txtUserCreate.EditValue = righttData.Rows[0]["USER_CREATE"];
                    dateInput.EditValue = DateTime.Parse(righttData.Rows[0]["DATE"].NullString());
                    cboStatus.SelectedItem = righttData.Rows[0]["STATUS"];
                    txtDelivererAndReceiver.EditValue = righttData.Rows[0]["DELIVERET_RECEIVER"].NullString();
                }

                if (INOUT == Consts.IN)
                {
                    txtLocation.Enabled = false;
                    cbIsWait.Enabled = false;
                    txtPriceVN.Enabled = true;
                    txtScanbarcode.Enabled = false;
                }
                else
                {
                    txtScanbarcode.Enabled = true;
                    txtLocation.Enabled = true;
                    cbIsWait.Enabled = true;
                    txtPriceVN.Enabled = false;
                    txtScanbarcode.Focus();
                }
            }
        }

        private void btnAddItem_Click(object sender, EventArgs e)
        {
            try
            {
                if (INOUT == Consts.IN) // NHAP KHO
                {
                    if (    string.IsNullOrEmpty(stlSparePartCode.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) ||
                            string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtPriceVN.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtPriceUS.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtAmountVN.EditValue.NullString()) ||
                            string.IsNullOrEmpty(txtAmountUS.EditValue.NullString()))
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
                        checkRow["STATUS"] = cboStatus.SelectedItem.NullString();

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
                        row["STATUS"] = cboStatus.SelectedItem.NullString();

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

                        Data.Rows.Add(row);
                    }

                    base.mBindData.BindGridView(gcList, Data);
                    FormatGridColumn();
                }
                else // XUAT KHO
                {

                }

            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void FormatGridColumn()
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

            gvList.Columns["AMOUNT_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["AMOUNT_VN"].DisplayFormat.FormatString = "c2";

            gvList.Columns["AMOUNT_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["AMOUNT_US"].DisplayFormat.FormatString = "c2";

            gvList.Columns["PRICE_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["PRICE_VN"].DisplayFormat.FormatString = "c2";

            gvList.Columns["PRICE_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
            gvList.Columns["PRICE_US"].DisplayFormat.FormatString = "c2";
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
                if (!string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && !string.IsNullOrEmpty(txtPriceVN.EditValue.NullString()))
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
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    stlSparePartCode.EditValue = gvList.GetDataRow(e.RowHandle)["SPARE_PART_CODE"].NullString();
                    txtQuantity.EditValue = gvList.GetDataRow(e.RowHandle)["QUANTITY"].NullString();
                    stlUnit.EditValue = gvList.GetDataRow(e.RowHandle)["UNIT"].NullString();
                    txtPriceVN.EditValue = gvList.GetDataRow(e.RowHandle)["PRICE_VN"].NullString();
                    mmCause.EditValue = gvList.GetDataRow(e.RowHandle)["CAUSE"].NullString();
                    mmNote.EditValue = gvList.GetDataRow(e.RowHandle)["NOTE"].NullString();
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
                    ClearItemAdd();
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

        private void ClearItemAdd()
        {
            try
            {
                stlSparePartCode.EditValue = null;
                txtQuantity.EditValue = 0;
                stlUnit.EditValue = null;
                txtPriceVN.EditValue = 0;
                mmCause.EditValue = null;
                mmNote.EditValue = null;
                Data.Clear();
                base.mBindData.BindGridView(gcList, Data);

                FormatGridColumn();
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
                    string.IsNullOrEmpty(stlType.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInput.EditValue.NullString()) ||
                    string.IsNullOrEmpty(cboStatus.SelectedItem.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                foreach (DataRow item in Data.Rows)
                {
                    item["STOCK_CODE"] = stlKho.EditValue.NullString();
                    item["DEPT_CODE"] = Consts.DEPARTMENT;
                    item["INT_OUT"] = INOUT;
                    item["TYPE_IN_OUT_CODE"] = stlType.EditValue.NullString();
                    item["ORDER_CODE"] = stlOrderCode.EditValue.NullString();
                    item["USER_CREATE"] = txtUserCreate.EditValue.NullString();
                    item["CREATE_DATE"] = dateInput.EditValue.NullString();
                    item["STATUS"] = cboStatus.SelectedItem.NullString();
                    item["USER_SYS"] = Consts.USER_INFO.Id;
                }

                base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.PUT",
                    new string[] { "A_USER", "A_DELIVER_RECEIVER" }, "A_DATA",
                    new string[] { Consts.USER_INFO.Id, txtDelivererAndReceiver.EditValue.NullString() }, Data);

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
            stlType.EditValue = null;
            stlOrderCode.EditValue = null;
            txtUserCreate.EditValue = null;
            dateInput.EditValue = DateTime.Now;
            cboStatus.SelectedIndex = 0;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (string.IsNullOrEmpty(ReceiptCode))
                    {
                        return;
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.DELETE", new string[] { "A_RECEIPT_ISSUE_CODE", "A_USER" }, new string[] { ReceiptCode, Consts.USER_INFO.Id });
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
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlSparePartCode_Enter(object sender, EventArgs e)
        {
            
        }

        private void cbIsWait_CheckedChanged(object sender, EventArgs e)
        {
            txtLocation.Enabled = !cbIsWait.Checked;
        }

        private void txtScanbarcode_KeyDown(object sender, KeyEventArgs e)
        {
            if (INOUT == Consts.OUT)
            {
                if (e.KeyCode == Keys.Enter)
                {
                    string barcode = txtScanbarcode.EditValue.NullString().ToUpper();
                    if (!string.IsNullOrEmpty(barcode))
                    {
                        string[] arr = barcode.Split('.');

                        if(arr.Length > 0)
                        {
                            stlSparePartCode.EditValue = arr[0];
                        }

                        if(arr.Length == 2)
                        {
                            if (arr[1] == Consts.NG)
                            {
                                cbIsWait.Checked = true;
                            }
                            else
                            {
                                cbIsWait.Checked = false;
                                txtLocation.EditValue = arr[1];
                            }
                        }
                        
                        if(arr.Length == 3)
                        {
                            cbIsWait.Checked = false;
                            txtLocation.EditValue = arr[1];
                        }
                    }
                }
            }
        }

        private void txtScanbarcode_EditValueChanged(object sender, EventArgs e)
        {
            //string barcode = txtScanbarcode.EditValue.NullString();
            //if (!string.IsNullOrEmpty(barcode))
            //{
            //    string[] arr = barcode.Split('.');

            //    if (arr.Length > 0)
            //    {
            //        stlSparePartCode.EditValue = arr[0];
            //    }

            //    if (arr.Length == 2)
            //    {
            //        if (arr[1] == Consts.NG)
            //        {
            //            cbIsWait.Checked = true;
            //        }
            //        else
            //        {
            //            cbIsWait.Checked = false;
            //            txtLocation.EditValue = arr[1];
            //        }
            //    }

            //    if (arr.Length == 3)
            //    {
            //        cbIsWait.Checked = false;
            //        txtLocation.EditValue = arr[1];
            //    }
            //}
        }
    }
}
