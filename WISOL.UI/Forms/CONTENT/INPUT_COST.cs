using DevExpress.XtraEditors.Repository;
using System;
using Wisol.Components;
using Wisol.MES.Inherit;
using DevExpress.XtraGrid.Columns;
using System.Data;
using Wisol.Common;
using System.Globalization;
using System.Windows.Forms;
using DevExpress.XtraPrinting;
using System.Diagnostics;
using DevExpress.Export;
using System.Drawing;
using DevExpress.XtraGrid.Views.Grid;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class INPUT_COST : PageType
    {
        DataTable dt = new DataTable();
        DataTable dtEdit = new DataTable();

        public INPUT_COST()
        {
            InitializeComponent();
            this.Load += INPUT_COST_Load;
        }

        private void INPUT_COST_Load(object sender, EventArgs e)
        {
            gcListTemp.Visible = false;
        }

        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();

        }
        public override void InitializePage()
        {
            try
            {
                m_BindData.BindGridLookEdit(stlMemory, Consts.GetDataMemory(), "CODE", "NAME_VI");
                datePrice.EditValue = DateTime.Now;
                txtPriceUS.Enabled = false;

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PRICE.INIT", new string[] { "A_DEPT_CODE" }, new string[] { Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection tableCollection = m_ResultDB.ReturnDataSet.Tables;
                    if (tableCollection[0].Rows.Count > 0)
                    {
                        txtExchangeRate.EditValue = tableCollection[0].Rows[0]["RATE"].NullString();
                    }
                    else
                    {
                        txtExchangeRate.EditValue = null;
                    }

                    m_BindData.BindGridView(gcList, tableCollection[1]);

                    if (rowHandle >= 0)
                    {
                        gvList.MakeRowVisible(rowHandle);
                    }

                    gvList.Columns["ID"].Visible = false;
                    gvList.Columns["PRICE_VN"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["PRICE_VN"].DisplayFormat.FormatString = "c3";

                    gvList.Columns["PRICE_US"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["PRICE_US"].DisplayFormat.FormatString = "c3";
                    gvList.OptionsView.ColumnAutoWidth = true;

                    m_BindData.BindGridLookEdit(stlUnit, tableCollection[3], "CODE", "NAME");
                    m_BindData.BindGridLookEdit(stlSparepartCode, tableCollection[2], "CODE", "NAME_VI");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        public override void SearchPage()
        {
            base.SearchPage();
        }

        private void gvList_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {

        }

        private void btnSaveExchangeRate_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtExchangeRate.EditValue.NullString()) || (!string.IsNullOrEmpty(txtExchangeRate.EditValue.NullString()) && !float.TryParse(txtExchangeRate.EditValue.NullString(), out _)))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    txtExchangeRate.Focus();
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EXCHANGE_RATE.PUT", new string[] { "A_RATE", "A_DATE" }, new string[] { txtExchangeRate.EditValue.NullString(), DateTime.Now.ToString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
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

        private void stlMemory_EditValueChanged(object sender, EventArgs e)
        {
            stlSparepartCode.EditValue = stlMemory.EditValue;
        }

        private void stlSparepartCode_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepartCode.EditValue.NullString(), stlUnit, m_BindData);
            GetImage(stlSparepartCode.EditValue.NullString());
        }

        private void GetImage(string sparepart)
        {
            try
            {
                imgSparepart.Image = null;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_IMG", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { Consts.DEPARTMENT, sparepart });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    if (data[0].Rows.Count > 0)
                    {
                        string strImg = data[0].Rows[0]["IMAGE"].NullString();
                        Classes.Common.ShowImge(strImg, imgSparepart);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtPriceVN_EditValueChanged(object sender, EventArgs e)
        {
            if (txtExchangeRate.EditValue.NullString() != "" && cheVN.Checked && double.TryParse(txtPriceVN.EditValue.NullString(), out _))
            {
                double priceUs = double.Parse(txtPriceVN.EditValue.NullString()) / double.Parse(txtExchangeRate.EditValue.NullString());
                txtPriceUS.EditValue = priceUs.ToString("R", CultureInfo.InvariantCulture);
            }
        }

        private void cheVN_CheckedChanged(object sender, EventArgs e)
        {
            txtPriceVN.Enabled = cheVN.Checked;
            cheUSD.Checked = !cheVN.Checked;
        }

        private void cheUSD_CheckedChanged(object sender, EventArgs e)
        {
            txtPriceUS.Enabled = cheUSD.Checked;
            cheVN.Checked = !cheUSD.Checked;
        }

        private void txtPriceUS_EditValueChanged(object sender, EventArgs e)
        {
            if (txtExchangeRate.EditValue.NullString() != "" && cheUSD.Checked && double.TryParse(txtPriceUS.EditValue.NullString(), out _))
            {
                double priceVN = double.Parse(txtPriceUS.EditValue.NullString()) * double.Parse(txtExchangeRate.EditValue.NullString());
                txtPriceVN.EditValue = (priceVN).ToString("R", CultureInfo.InvariantCulture);
            }
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            InitializePage();
        }

        /// <summary>
        /// ADD NEW
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSave_Click_1(object sender, EventArgs e)
        {

        }

        /// <summary>
        ///  Edit
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlSparepartCode.EditValue.NullString() == "" || stlUnit.EditValue.NullString() == "" || txtPriceVN.EditValue.NullString() == "" || txtPriceUS.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                string isEdit = "";
                if (txtID.EditValue.NullString() == "")
                {
                    isEdit = "False";
                }
                else
                {
                    isEdit = "True";
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PRICE.PUT",
                                 new string[] { "A_DEPT_CODE", "A_SPARE_PART_CODE", "A_IS_EDIT", "A_PRICE_VN", "A_PRICE_US", "A_DATE", "A_UNIT", "A_ID" },
                                 new string[] { Consts.DEPARTMENT,
                                     stlSparepartCode.EditValue.NullString(),
                                     isEdit,
                                     txtPriceVN.EditValue.NullString(),
                                     txtPriceUS.EditValue.NullString(),
                                     datePrice.EditValue.NullString(),
                                     stlUnit.EditValue.NullString(),
                                     txtID.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitializePage();
                    Clear();
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
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, Components.DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (stlSparepartCode.EditValue.NullString() == "" || stlUnit.EditValue.NullString() == "" || txtPriceVN.EditValue.NullString() == "" || txtPriceUS.EditValue.NullString() == "" || txtID.EditValue.NullString() == "")
                    {
                        MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                        return;
                    }

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PRICE.DELETE",
                                     new string[] { "A_ID" },
                                     new string[] { txtID.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitializePage();
                        Clear();
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
            Clear();
        }

        private void Clear()
        {
            txtID.EditValue = null;
            stlSparepartCode.EditValue = null;
            stlUnit.EditValue = null;
            txtPriceVN.EditValue = null;
            txtPriceUS.EditValue = null;
            datePrice.EditValue = DateTime.Now;
            cheVN.Checked = true;
            rowHandle = -1;
        }

        int rowHandle = -1;
        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                rowHandle = e.RowHandle;
                if (e.RowHandle < 0)
                {
                    return;
                }

                txtID.EditValue = gvList.GetRowCellValue(e.RowHandle, "ID").NullString();
                stlSparepartCode.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
                stlUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
                txtPriceVN.EditValue = gvList.GetRowCellValue(e.RowHandle, "PRICE_VN").NullString();
                txtPriceUS.EditValue = gvList.GetRowCellValue(e.RowHandle, "PRICE_US").NullString();
                datePrice.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE").NullString();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void cheEditExchange_CheckedChanged(object sender, EventArgs e)
        {
            txtExchangeRate.Enabled = cheEditExchange.Checked;
        }

        private void btnImportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                try
                {
                    POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
                    popup.stock_code = "";
                    popup.ImpportType = Consts.IMPORT_TYPE_PRICE;
                    popup.ShowDialog();
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnGetFileImport_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PRICE.GET_DATE_FOR_IMPORT",
                                    new string[] { "A_DEPT_CODE" },
                                    new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    SaveFileDialog fileDialog = new SaveFileDialog();
                    fileDialog.Filter = "Excel Files (.xls*)|*.xls*|All Files (*.*)|*.*";
                    fileDialog.FileName = "INPUT_PRICE.xlsx";
                    if (fileDialog.ShowDialog() == DialogResult.OK)
                    {
                        string path = fileDialog.FileName;

                        DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                        //m_BindData.BindGridView(gcListTemp, data);
                        gcListTemp.DataSource = data;
                        //Customize export options
                        DevExpress.Export.ExportSettings.DefaultExportType = ExportType.DataAware;
                        gvListTemp.OptionsPrint.UsePrintStyles = false;
                        gvListTemp.OptionsPrint.PrintHeader = true;
                        gvListTemp.AppearancePrint.HeaderPanel.BackColor = Color.Orange;

                        XlsxExportOptionsEx advOptions = new XlsxExportOptionsEx();
                        advOptions.ShowTotalSummaries = DevExpress.Utils.DefaultBoolean.False;
                        advOptions.SheetName = "EWIP_SPAREPART_PRICE";

                        gvListTemp.ExportToXlsx(path, advOptions);
                        // Open the created XLSX file with the default application.
                        Process.Start(path);
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
    }
}
