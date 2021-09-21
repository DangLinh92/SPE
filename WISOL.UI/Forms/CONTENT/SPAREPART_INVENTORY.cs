using DevExpress.Utils;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class SPAREPART_INVENTORY : PageType
    {
        public SPAREPART_INVENTORY()
        {
            InitializeComponent();
            this.Load += SPAREPART_INVENTORY_Load;
        }

        //private bool firstLoad = true;
        private void SPAREPART_INVENTORY_Load(object sender, EventArgs e)
        {
            try
            {
                Init_Control();
                //firstLoad = false;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        public override void ReloadData()
        {
            //if (firstLoad)
            //{
            //    Init_Control();
            //}

            //firstLoad = true;
        }

        private void Init_Control()
        {
            try
            {
                //  Init data
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridView(gcList, data[0]);
                    base.m_BindData.BindGridLookEdit(stlSpare, data[1], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlKho, data[2], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlUnit, data[3], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlSparePartForReal, data[1], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlUnitReal, data[3], "CODE", "NAME");

                    string firstValue = data[2].Rows[0]["CODE"].NullString();
                    stlKho.EditValue = firstValue;
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["RATE_ALARM"].Visible = false;
                    gvList.Columns["QUANTITY"].Caption = "Tồn kho hệ thống/시스템 재고";
                    gvList.Columns["QUANTITY_REAL"].Caption = "Tồn kho sau kiểm kê/재고 실사후 파악한 재고";
                    gvList.Columns["DIFFERENCE_QUANTITY"].Caption = "Chênh lệch/차이 수량";
                    gvList.Columns["MIN_STOCK"].Caption = "Tồn tối thiểu/최소 재고";
                    gvList.Columns["SPECIFICATION"].Width = 150;
                    gvList.Columns["NAME_KR"].Width = 150;

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_SHEET.GET",
                        new string[] { "A_DEPARTMENT", "A_STOCK_CODE" },
                        new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable kiemkeData = m_ResultDB.ReturnDataSet.Tables[0];
                        if(kiemkeData.Rows.Count > 0)
                        {
                            string dateUpdate = kiemkeData.Rows[0]["DATE_UPDATE"].NullString() == "" ? kiemkeData.Rows[0]["DATE_END"].NullString() : kiemkeData.Rows[0]["DATE_UPDATE"].NullString();
                            lblKiemKeDate.Text = "Ngày kiểm kê(기말제품재고액): " + DateTime.Parse(kiemkeData.Rows[0]["DATE_UPDATE"].NullString()).ToString("yyyy-MM-dd") + " ";
                        }
                    }
                }

                radioInputType.SelectedIndex = 1;
                cboReportType.SelectedIndex = 0;
                cboFilter.SelectedIndex = 0;
                dateInputReal.EditValue = DateTime.Now;
                radioInputType.Enabled = false;
                txtRateAlarm.EditValue = 20;
                gvList.OptionsView.ColumnAutoWidth = true;

            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public void GetData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["RATE_ALARM"].Visible = false;
                    gvList.Columns["QUANTITY"].Caption = "Tồn kho hệ thống/시스템 재고";
                    gvList.Columns["QUANTITY_REAL"].Caption = "Tồn kho sau kiểm kê/재고 실사후 파악한 재고";
                    gvList.Columns["DIFFERENCE_QUANTITY"].Caption = "Chênh lệch/차이 수량";
                    gvList.Columns["MIN_STOCK"].Caption = "Tồn tối thiểu/최소 재고";
                    gvList.Columns["SPECIFICATION"].Width = 150;
                    gvList.Columns["NAME_KR"].Width = 150;
                    gvList.OptionsView.ColumnAutoWidth = true;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void radioInputType_SelectedIndexChanged(object sender, EventArgs e)
        {
            stlSpare.EditValue = null;

            if ("1".Equals(radioInputType.EditValue.NullString())) // inventory
            {
                txtMinStock.Enabled = false;
                txtMinStock.EditValue = null;

                txtRateAlarm.Enabled = false;
                txtRateAlarm.EditValue = null;

                txtQuantity.Enabled = true;
                txtQuantityReal.Enabled = true;
            }
            else // min stock
            {
                txtQuantity.EditValue = null;
                txtQuantityReal.EditValue = null;
                txtQuantity.Enabled = false;
                txtQuantityReal.Enabled = false;
                txtQuantity.Visible = false;
                txtQuantityReal.Visible = false;
                loQuantityReal.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                loQuantity.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;

                txtMinStock.Enabled = true;
                txtRateAlarm.Enabled = true;
            }
        }

        private void searchCode_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Mã[상품]" && s != "Tên tiếng việt[Sparepart의 이름]") args.IsSearchColumn = false;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearData();
        }

        private void ClearData()
        {
            radioInputType.SelectedIndex = 1;
            stlSpare.EditValue = null;
            txtQuantity.EditValue = null;
            txtQuantityReal.EditValue = null;
            stlUnit.EditValue = null;
            txtMinStock.EditValue = null;
            txtRateAlarm.EditValue = 20;
            img.EditValue = null;
        }

        private void btnClearReal_Click(object sender, EventArgs e)
        {
            ClearDataReal();
        }

        private void ClearDataReal()
        {
            stlSparePartForReal.EditValue = 0;
            txtQuantityReal.EditValue = null;
            stlUnitReal.EditValue = null;
            dateInputReal.EditValue = null;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if ("1".Equals(radioInputType.EditValue.NullString())) // inventory
            {
                if (string.IsNullOrEmpty(stlSpare.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlUnit.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                int quantityReal = -1;
                if (!string.IsNullOrEmpty(txtQuantityReal.EditValue.NullString()))
                {
                    quantityReal = int.Parse(txtQuantityReal.EditValue.NullString());
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.PUT",
                                    new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_QUANTITY", "A_QUANTITY_REAL", "A_UNIT", "A_USER" },
                                    new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), stlSpare.EditValue.NullString(), txtQuantity.EditValue.NullString(), quantityReal.NullString(), stlUnit.EditValue.NullString(), Consts.USER_INFO.Id });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    GetData();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) || string.IsNullOrEmpty(stlSpare.EditValue.NullString()) || string.IsNullOrEmpty(txtMinStock.EditValue.NullString()) || string.IsNullOrEmpty(txtRateAlarm.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_MIN_STOCK.PUT",
                                   new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_UNIT", "A_MIN_STOCK", "A_RATE_ALARM" },
                                   new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), stlSpare.EditValue.NullString(), stlUnit.EditValue.NullString(), txtMinStock.EditValue.NullString(), txtRateAlarm.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    GetData();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
        }

        private void stlSpare_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET_BY_SPARE_CODE",
                                   new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE" },
                                   new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), stlSpare.EditValue.NullString() });

                img.Image = null;

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    if ("1".Equals(radioInputType.EditValue.NullString()))
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                        {
                            txtQuantity.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["QUANTITY"].NullString();
                            txtQuantityReal.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["QUANTITY_REAL"].NullString();
                            stlUnit.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["UNIT"].NullString();


                            string image = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["IMAGE"].NullString();
                            ShowImge(image);
                        }
                    }
                    else
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[1].Rows.Count > 0)
                        {
                            txtMinStock.EditValue = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["MIN_STOCK"].NullString();
                            stlUnit.EditValue = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["UNIT"].NullString();
                            txtRateAlarm.EditValue = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["RATE_ALARM"].NullString();

                            string image = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["IMAGE"].NullString();
                            ShowImge(image);
                        }
                        else
                        {
                            txtMinStock.EditValue = null;
                            stlUnit.EditValue = null;
                            txtRateAlarm.EditValue = 20;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void ShowImge(string image)
        {
            if (!string.IsNullOrWhiteSpace(image))
            {
                byte[] imagebytes = Convert.FromBase64String(image);
                using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                {
                    img.Image = Image.FromStream(ms, true);
                }
                img.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                img.Size = img.Image.Size;
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (string.IsNullOrEmpty(stlSpare.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    string IsInventory = "1".Equals(radioInputType.EditValue.NullString()) ? "1" : "0";

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.DELETE",
                                   new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_IS_INVENTORY" },
                                   new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString(), stlSpare.EditValue.NullString(), IsInventory });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        GetData();
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
            finally
            {
                ClearData();
            }
        }

        private void gvList_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            if (e.RowHandle < 0)
            {
                return;
            }
            else
            {
                string KHO = gvList.GetDataRow(e.RowHandle)["KHO"].NullString();
                string sparepart = gvList.GetDataRow(e.RowHandle)["CODE"].NullString();
                string UnitId = gvList.GetDataRow(e.RowHandle)["UNIT"].NullString();

                stlKho.EditValue = KHO;
                stlSpare.EditValue = sparepart;
                stlSparePartForReal.EditValue = sparepart;
                stlUnitReal.EditValue = UnitId;
            }
        }

        private void btnSaveReal_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlSparePartForReal.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtQuantityRealByTime.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlUnitReal.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInputReal.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (txtQuantityByTime.Visible == true && txtQuantityByTime.Enabled == true && string.IsNullOrEmpty(txtQuantityByTime.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DateTime date = (DateTime)dateInputReal.EditValue;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_BY_TIME.PUT_QUANTITY_REAL",
                            new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_QUANTITY_REAL", "A_UNIT", "A_DATE", "A_YEAR", "A_MONTH", "A_QUANTITY", "A_USER" },
                            new string[] {
                                Consts.DEPARTMENT, stlKho.EditValue.NullString(),
                                stlSparePartForReal.EditValue.NullString(), txtQuantityRealByTime.EditValue.NullString(),
                                stlUnitReal.EditValue.NullString(),date.ToString(),date.Year.NullString(),date.Month.NullString(),txtQuantityByTime.EditValue.NullString(),Consts.USER_INFO.Id });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    GetData();
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

        private void btnDeleteReal_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                        string.IsNullOrEmpty(stlSparePartForReal.EditValue.NullString()) ||
                        string.IsNullOrEmpty(dateInputReal.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    DateTime date = (DateTime)dateInputReal.EditValue;

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_BY_TIME.DELETE_QUANTITY_REAL",
                               new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_YEAR", "A_MONTH", "A_USER" },
                               new string[] {
                                Consts.DEPARTMENT, stlKho.EditValue.NullString(),
                                stlSparePartForReal.EditValue.NullString(),
                               date.Year.NullString(),date.Month.NullString(),Consts.USER_INFO.Id });

                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        GetData();
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

        private void stlSparePartForReal_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) || string.IsNullOrEmpty(dateInputReal.EditValue.NullString()))
                {
                    return;
                }

                DateTime date = (DateTime)dateInputReal.EditValue;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_BY_TIME.GET_QUANTITY_REAL",
                         new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_YEAR", "A_MONTH" },
                         new string[] {
                                Consts.DEPARTMENT, stlKho.EditValue.NullString(),
                                stlSparePartForReal.EditValue.NullString(),
                               date.Year.NullString(),date.Month.NullString() });

                if (base.m_ResultDB.ReturnInt == 0 && base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                {
                    txtQuantityReal.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["QUANTITY_REAL"].NullString();
                    stlUnitReal.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["UNIT"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowStyleEventArgs e)
        {

        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            try
            {
                string sQuantity = gvList.GetRowCellValue(e.RowHandle, "QUANTITY").NullString();
                string sMinStock = gvList.GetRowCellValue(e.RowHandle, "MIN_STOCK").NullString();
                string rateAlarm = gvList.GetRowCellValue(e.RowHandle, "RATE_ALARM").NullString();
                string sQuantityDiff = gvList.GetRowCellValue(e.RowHandle, "DIFFERENCE_QUANTITY").NullString();

                if (e.Column.FieldName == "DIFFERENCE_QUANTITY")
                {
                    if (sQuantityDiff == "") sQuantityDiff = "0";

                    if (float.Parse(sQuantityDiff) < 0)
                    {
                        e.Appearance.BackColor = Color.LightSalmon;
                    }
                    else if (float.Parse(sQuantityDiff) == 0)
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.Yellow;
                    }
                }

                if (string.IsNullOrEmpty(sQuantity) || string.IsNullOrEmpty(sMinStock))
                {
                    return;
                }

                float rate = 0;
                if (!string.IsNullOrEmpty(rateAlarm))
                {
                    rate = float.Parse(rateAlarm);
                }

                float quantity = float.Parse(sQuantity);
                float minStock = float.Parse(sMinStock);

                if (e.Column.FieldName == "QUANTITY")
                {
                    if (quantity <= minStock && minStock > 0)
                    {
                        e.Appearance.BackColor = Color.LightSalmon;
                    }
                    else if (quantity <= minStock * (rate / 100 + 1) && quantity > minStock)
                    {
                        e.Appearance.BackColor = Color.Yellow;
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnReport_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(cboReportType.SelectedItem.NullString()))
            {
                POP.EXPORT_EXCEL popup = new POP.EXPORT_EXCEL();
                popup.ReportType = cboReportType.SelectedIndex == 0 ? "1" : "2";
                popup.ReportTitle = cboReportType.Text;
                popup.Kho = stlKho.EditValue.NullString();

                if (cboReportType.SelectedIndex == 1)
                {
                    if (string.IsNullOrEmpty(dateFrom.EditValue.NullString()) || string.IsNullOrEmpty(dateTo.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        dateFrom.Focus();
                        return;
                    }
                    DateTime datefrom = (DateTime)dateFrom.EditValue;
                    DateTime dateto = (DateTime)dateTo.EditValue;

                    if (datefrom > dateto)
                    {
                        MsgBox.Show("MSG_ERR_TIME_INVALID".Translation(), MsgType.Warning);
                        dateFrom.Focus();
                        return;
                    }

                    popup.TimeFrom = datefrom.ToString();
                    popup.TimeTo = dateto.ToString();
                }

                popup.ShowDialog();
            }
            else
            {
                MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                cboReportType.Focus();
                return;
            }
        }

        private void cboReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboReportType.SelectedIndex == 0)
            {
                dateFrom.Enabled = false;
                dateTo.Enabled = false;
                dateFrom.EditValue = null;
                dateTo.EditValue = null;
            }
            else
            {
                dateFrom.Enabled = true;
                dateTo.Enabled = true;
            }
        }

        private void cboFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboFilter.SelectedIndex == 0) //show all
            {
                gvList.ActiveFilter.Clear();
            }
            else if (cboFilter.SelectedIndex == 1) //duoi dinh muc
            {
                gvList.ActiveFilterString = "[QUANTITY] <= [MIN_STOCK]";
            }
            else if (cboFilter.SelectedIndex == 2) // vuot dinh muc
            {
                gvList.ActiveFilterString = "[QUANTITY] > [MIN_STOCK]";
            }
            else if (cboFilter.SelectedIndex == 3) // con hang
            {
                gvList.ActiveFilterString = "[QUANTITY] > 0 OR [QUANTITY_REAL] > 0";
            }
            else if (cboFilter.SelectedIndex == 4) // het hang
            {
                gvList.ActiveFilterString = "[QUANTITY] = 0 OR [QUANTITY_REAL] = 0";
            }
        }

        /// <summary>
        /// Reload data
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnBalance_Click(object sender, EventArgs e)
        {
            #region
            //try
            //{
            //    DialogResult dialogResult = MsgBox.Show("BALANCE_WAREHOUSE_MSG".Translation(), MsgType.Warning, DialogType.OkCancel);

            //    if (dialogResult == DialogResult.OK)
            //    {
            //        base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.CREATE_BALANCE_WAREHOUSE",
            //           new string[] { "A_DEPARTMENT", "A_USER", "A_STOCK_CODE" },
            //           new string[] { Consts.DEPARTMENT, Consts.USER_INFO.Id, stlKho.EditValue.NullString() });

            //        if (base.m_ResultDB.ReturnInt == 0)
            //        {
            //            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
            //            GetData();
            //        }
            //        else
            //        {
            //            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MsgBox.Show(ex.Message, MsgType.Error);
            //}
            #endregion

            GetData();
        }
        private void btnInventoryOfAssets_Click(object sender, EventArgs e)
        {
            try
            {
                // check xem can PO NO k
                POP.EXPORT_EXCEL popup = new POP.EXPORT_EXCEL();
                popup.ReportType = "0";
                popup.ReportTitle = "Inventory of assets-Kiểm kê thiết bị";
                popup.Kho = stlKho.EditValue.NullString();
                popup.ShowDialog();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
                popup.stock_code = stlKho.EditValue.NullString();
                popup.ImpportType = Consts.IMPORT_TYPE_INVENTORY_REAL;
                popup.ShowDialog();
                GetData();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnValueInventory_Click(object sender, EventArgs e)
        {
            splashScreenManager1.ShowWaitForm();
            Consts.mainForm.NewPageFromOtherPage("INVENTORY_VALUES", "재고의 현금 가치- Giá trị tồn kho", "W", "Y", stlKho.EditValue.NullString());
            splashScreenManager1.CloseWaitForm();
        }
    }
}
