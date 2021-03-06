using DevExpress.XtraCharts;
using DevExpress.XtraReports.UI;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Forms.CONTENT.POP;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class STOCK_IN : PageType
    {
        DataTable dtChart = new DataTable();
        DataTable lot = new DataTable();
        string label = string.Empty;
        //private bool firstLoad = true;
        public STOCK_IN()
        {
            InitializeComponent();
            this.Load += STOCK_IN_Load;
        }

        private void STOCK_IN_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "STOCK_IN");
            Init_Control();
            LoadData();
            //firstLoad = false;
        }

        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
        }
        public override void InitializePage()
        {
            base.InitializePage();
        }

        public override void ReloadData()
        {
            //if (firstLoad)
            //{
            //    Init_Control();
            //    LoadData();
            //}
            //firstLoad = true;
        }

        private void Init_Control()
        {
            try
            {
                cboPhieu.SelectedIndex = 0;
                cboTrangThai.SelectedIndex = 0;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_KHO.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable kho = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridLookEdit(stlKho, kho, "CODE", "NAME");
                    stlKho.EditValue = kho.Rows[0]["CODE"].NullString();
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

        private void LoadData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING.GET", new string[] { "A_DEPT_CODE", "A_STOCK_CODE" }, new string[] { Consts.DEPARTMENT,stlKho.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    //base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gcList.DataSource = base.m_ResultDB.ReturnDataSet.Tables[0];
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

        private void btnAddNewReceive_Click(object sender, EventArgs e)
        {
            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
            popup.Mode = Consts.MODE_NEW;
            popup.ReceiptCode = "";
            popup.StockCode = stlKho.EditValue.NullString();
            popup.INOUT = Consts.IN;
            popup.CurrentStatus = "";
            popup.ShowDialog();
            LoadData();
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            string intOut = gvList.GetRowCellValue(e.RowHandle, "IN_OUT").NullString();
            string status = gvList.GetRowCellValue(e.RowHandle, "STATUS").NullString();


            if(e.Column.Name == "col_View")
            {
                e.Appearance.BackColor = Color.CornflowerBlue;
            }

            if (e.Column.FieldName == "IN_OUT")
            {
                if (intOut == Consts.IN)
                {
                    e.Appearance.ForeColor = Color.Green;
                }
                else
                {
                    e.Appearance.ForeColor = Color.Red;
                }
            }

            if (e.Column.FieldName == "STATUS")
            {
                if (status == Consts.STATUS_COMPLETE)
                {
                    e.Appearance.BackColor = Color.LightGreen;
                }
                else if (status == Consts.STATUS_NEW)
                {
                    e.Appearance.BackColor = Color.LightGray;
                }
                else
                {
                    e.Appearance.BackColor = Color.LightSalmon;
                }
            }

            if (e.Column.Name == "col_Edit" || e.Column.Name == "col_delete")
            {
                string dateCreate = gvList.GetRowCellValue(e.RowHandle, "CREATE_DATE").NullString();

                if (DateTime.TryParse(dateCreate, out DateTime dateOut))
                {
                    
                    if (dateOut.AddMonths(1) < DateTime.Now && status == Consts.STATUS_COMPLETE)
                    {
                        e.Appearance.BackColor = Color.LightGray;
                    }

                    if (status == Consts.STATUS_COMPLETE && intOut == Consts.OUT && e.Column.Name == "col_Edit")
                    {
                        e.Appearance.BackColor = Color.LightGray;
                    }
                }
                else
                {
                    e.Appearance.BackColor = Color.LightGray;
                }
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                string status = gvList.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                string dateCreate = gvList.GetDataRow(e.RowHandle)["CREATE_DATE"].NullString();

                if (status == Consts.STATUS_COMPLETE && gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString() == Consts.OUT && e.Column.Name == "col_Edit")
                {
                    return;
                }

                if(e.Column.Name == "col_View")
                {
                    POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
                    popup.Mode = Consts.MODE_VIEW;
                    popup.ReceiptCode = gvList.GetDataRow(e.RowHandle)["STOCK_IN_OUT_CODE"].NullString();
                    popup.INOUT = gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString();
                    popup.StockCode = gvList.GetDataRow(e.RowHandle)["STOCK_CODE"].NullString();
                    popup.CurrentStatus = gvList.GetDataRow(e.RowHandle)["STATUS"].NullString();
                    popup.ShowDialog();
                    LoadData();
                    return;
                }

                if (DateTime.TryParse(dateCreate, out DateTime dateOut))
                {
                    if (dateOut.AddMonths(1) >= DateTime.Now)
                    {
                        if (e.Column.Name == "col_Edit")
                        {
                            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
                            popup.Mode = Consts.MODE_UPDATE;
                            popup.ReceiptCode = gvList.GetDataRow(e.RowHandle)["STOCK_IN_OUT_CODE"].NullString();
                            popup.INOUT = gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString();
                            popup.StockCode = gvList.GetDataRow(e.RowHandle)["STOCK_CODE"].NullString();
                            popup.CurrentStatus = gvList.GetDataRow(e.RowHandle)["STATUS"].NullString();
                            popup.ShowDialog();
                            LoadData();
                        }
                        else if (e.Column.Name == "col_delete")
                        {
                            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
                            popup.Mode = Consts.MODE_DELETE;
                            popup.ReceiptCode = gvList.GetDataRow(e.RowHandle)["STOCK_IN_OUT_CODE"].NullString();
                            popup.INOUT = gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString();
                            popup.StockCode = gvList.GetDataRow(e.RowHandle)["STOCK_CODE"].NullString();
                            popup.CurrentStatus = gvList.GetDataRow(e.RowHandle)["STATUS"].NullString();
                            popup.ShowDialog();
                            LoadData();
                        }
                    }
                    else
                    {
                        if(status != Consts.STATUS_COMPLETE && e.Column.Name == "col_delete")
                        {
                            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
                            popup.Mode = Consts.MODE_DELETE;
                            popup.ReceiptCode = gvList.GetDataRow(e.RowHandle)["STOCK_IN_OUT_CODE"].NullString();
                            popup.INOUT = gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString();
                            popup.StockCode = gvList.GetDataRow(e.RowHandle)["STOCK_CODE"].NullString();
                            popup.CurrentStatus = gvList.GetDataRow(e.RowHandle)["STATUS"].NullString();
                            popup.ShowDialog();
                            LoadData();
                        }
                        else if (status != Consts.STATUS_COMPLETE && e.Column.Name == "col_Edit")
                        {
                            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
                            popup.Mode = Consts.MODE_UPDATE;
                            popup.ReceiptCode = gvList.GetDataRow(e.RowHandle)["STOCK_IN_OUT_CODE"].NullString();
                            popup.INOUT = gvList.GetDataRow(e.RowHandle)["IN_OUT"].NullString();
                            popup.StockCode = gvList.GetDataRow(e.RowHandle)["STOCK_CODE"].NullString();
                            popup.CurrentStatus = gvList.GetDataRow(e.RowHandle)["STATUS"].NullString();
                            popup.ShowDialog();
                            LoadData();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {

        }

        private void cboPhieu_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cboPhieu.SelectedIndex == 0) // all
            {
                StatusSelectChange("");
            }
            else if(cboPhieu.SelectedIndex == 1)
            {
                StatusSelectChange("[IN_OUT] = 'IN'");
            }
            else if(cboPhieu.SelectedIndex == 2)
            {
                StatusSelectChange("[IN_OUT] = 'OUT'");
            }
        }

        private void cboTrangThai_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboTrangThai.SelectedIndex == 0) // all
            {
                PhieuSelectChange("");
            }
            else if (cboTrangThai.SelectedIndex == 1)
            {
                PhieuSelectChange("[STATUS] = 'NEW'");
            }
            else if (cboTrangThai.SelectedIndex == 2)
            {
                PhieuSelectChange("[STATUS] = 'INPROGRESS'");
            }
            else if (cboTrangThai.SelectedIndex == 3)
            {
                PhieuSelectChange("[STATUS] = 'COMPLETE'");
            }
        }

        private void PhieuSelectChange(string condition)
        {
            if (cboPhieu.SelectedIndex == 0) // all
            {
                if (string.IsNullOrEmpty(condition))
                    gvList.ActiveFilter.Clear();
                else
                {
                    gvList.ActiveFilterString = condition;
                }
            }
            else if (cboPhieu.SelectedIndex == 1)
            {
                gvList.ActiveFilterString = "[IN_OUT] = 'IN'" + (string.IsNullOrEmpty(condition) ? "" : " AND " + condition);
            }
            else if (cboPhieu.SelectedIndex == 2)
            {
                gvList.ActiveFilterString = "[IN_OUT] = 'OUT'" + (string.IsNullOrEmpty(condition) ? "" : " AND " + condition);
            }
        }

        private void StatusSelectChange(string condition)
        {
            if (cboTrangThai.SelectedIndex == 0) // all
            {
                if(string.IsNullOrEmpty(condition))
                    gvList.ActiveFilter.Clear();
                else
                {
                    gvList.ActiveFilterString = condition;
                }
            }
            else if (cboTrangThai.SelectedIndex == 1)
            {
                gvList.ActiveFilterString = "[STATUS] = 'NEW'" + (string.IsNullOrEmpty(condition) ? "":" AND " + condition);
            }
            else if (cboTrangThai.SelectedIndex == 2)
            {
                gvList.ActiveFilterString = "[STATUS] = 'INPROGRESS'" + (string.IsNullOrEmpty(condition) ? "" : " AND " + condition);
            }
            else if (cboTrangThai.SelectedIndex == 3)
            {
                gvList.ActiveFilterString = "[STATUS] = 'COMPLETE'" + (string.IsNullOrEmpty(condition) ? "" : " AND " + condition);
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if(string.IsNullOrEmpty(dateFrom.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);

                    dateFrom.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(dateTo.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    dateTo.Focus();
                    return;
                }

                if(DateTime.Parse(dateFrom.EditValue.NullString()) > DateTime.Parse(dateTo.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_TIME_INVALID".Translation(), MsgType.Warning);
                    dateFrom.Focus();
                    return;
                }

                string phieu = (cboPhieu.SelectedIndex == 0 ? "'IN','OUT'" : cboPhieu.SelectedIndex == 1 ? "'IN'" : "'OUT'");
                string status = cboTrangThai.SelectedIndex == 0 ? "'NEW','INPROGRESS','COMPLETE'" : (cboTrangThai.SelectedIndex == 1 ? "'NEW'" : cboTrangThai.SelectedIndex == 2 ? "'INPROGRESS'" : "'COMPLETE'");

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_INVENTORY_DELIVERY_RECEIVING.GET_BY_TIME", 
                    new string[] { "A_DEPT_CODE", "A_TIME_FROM", "A_TIME_TO", "A_PHIEU", "A_STATUS", "A_STOCK_CODE" }, 
                    new string[] { Consts.DEPARTMENT,dateFrom.EditValue.NullString(),dateTo.EditValue.NullString(), phieu,status,stlKho.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    //base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gcList.DataSource = base.m_ResultDB.ReturnDataSet.Tables[0];
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

        private void dateFrom_EditValueChanged(object sender, EventArgs e)
        {
            //gvList.ActiveFilterString = "[CREATE_DATE] >= #" + dateFrom.EditValue.ToString() + "#";
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            dateFrom.EditValue = null;
            dateTo.EditValue = null;
            cboPhieu.SelectedIndex = 0;
            cboTrangThai.SelectedIndex = 0;

            LoadData();
        }

        private void btnAddNewDelivery_Click(object sender, EventArgs e)
        {
            POP.GOODS_RECEIPT popup = new POP.GOODS_RECEIPT();
            popup.Mode = Consts.MODE_NEW;
            popup.ReceiptCode = "";
            popup.StockCode = stlKho.EditValue.NullString();
            popup.INOUT = Consts.OUT;
            popup.CurrentStatus = "";
            popup.ShowDialog();
            LoadData();
        }

        private void stlKho_EditValueChanged(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnReloadData_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnHistory_Click(object sender, EventArgs e)
        {
            POP.HISTORY_GOOD_RE_ISS popup = new POP.HISTORY_GOOD_RE_ISS();
            popup.Kho = stlKho.EditValue.NullString();
            popup.ShowDialog();
        }

        private void btnListSparepartLend_Click(object sender, EventArgs e)
        {
            POP.SPAREPART_LEND pop = new SPAREPART_LEND();
            pop.sparepartCode = "";
            pop.ShowDialog();
        }
    }
}
