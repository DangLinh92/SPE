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

        private void SPAREPART_INVENTORY_Load(object sender, EventArgs e)
        {
            try
            {
                Init_Control();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void Init_Control()
        {
            try
            {
                //  Init data
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    base.m_BindData.BindGridLookEdit(stlSpare, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlKho, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlUnit, base.m_ResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlSparePartForReal, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlUnitReal, base.m_ResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");

                    string firstValue = base.m_ResultDB.ReturnDataSet.Tables[2].Rows[0]["CODE"].NullString();
                    stlKho.EditValue = firstValue;
                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["RATE_ALARM"].Visible = false;
                }

                radioInputType.SelectedIndex = 0;
                cboReportType.SelectedIndex = 0;
                dateInputReal.EditValue = DateTime.Now;

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
                txtMinStock.Enabled = true;
                txtRateAlarm.Enabled = true;
            }
        }

        private void searchCode_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Mã") args.IsSearchColumn = false;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearData();
        }

        private void ClearData()
        {
            radioInputType.SelectedIndex = 0;
            stlSpare.EditValue = null;
            txtQuantity.EditValue = null;
            txtQuantityReal.EditValue = null;
            stlUnit.EditValue = null;
            txtMinStock.EditValue = null;
            txtRateAlarm.EditValue = null;
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
                                   new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_UNIT", "A_MIN_STOCK","A_RATE_ALARM" },
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

                stlKho.EditValue = KHO;
                stlSpare.EditValue = sparepart;
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

                DateTime date = (DateTime)dateInputReal.EditValue;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_BY_TIME.PUT_QUANTITY_REAL",
                            new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_QUANTITY_REAL", "A_UNIT", "A_DATE", "A_YEAR", "A_MONTH" },
                            new string[] {
                                Consts.DEPARTMENT, stlKho.EditValue.NullString(),
                                stlSparePartForReal.EditValue.NullString(), txtQuantityRealByTime.EditValue.NullString(),
                                stlUnitReal.EditValue.NullString(),date.ToString(),date.Year.NullString(),date.Month.NullString() });
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
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlSparePartForReal.EditValue.NullString()) ||
                    string.IsNullOrEmpty(dateInputReal.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DateTime date = (DateTime)dateInputReal.EditValue;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_BY_TIME.DELETE_QUANTITY_REAL",
                           new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPARE_PART_CODE", "A_YEAR", "A_MONTH" },
                           new string[] {
                                Consts.DEPARTMENT, stlKho.EditValue.NullString(),
                                stlSparePartForReal.EditValue.NullString(),
                               date.Year.NullString(),date.Month.NullString() });

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
                    if(quantity <= minStock)
                    {
                        e.Appearance.BackColor = Color.LightSalmon;
                    }
                    else if (quantity <= minStock*(rate/100 + 1) && quantity > minStock)
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

                if(cboReportType.SelectedIndex == 1)
                {
                    if(string.IsNullOrEmpty(dateFrom.EditValue.NullString()) || string.IsNullOrEmpty(dateTo.EditValue.NullString()))
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        dateFrom.Focus();
                        return;
                    }
                    DateTime datefrom = (DateTime)dateFrom.EditValue;
                    DateTime dateto = (DateTime)dateTo.EditValue;
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
            if(cboReportType.SelectedIndex == 0)
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
    }
}
