using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Columns;
using DevExpress.XtraGrid.Views.Grid;
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
    /// <summary>
    /// Material Requirements Planning. Hoạch định nhu cầu nguyên vật liệu (MRP)
    /// </summary>
    public partial class MRP : PageType
    {
        public MRP()
        {
            InitializeComponent();
            this.Load += MRP_Load;
        }

        private void MRP_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "MRP");
            CREAT_EWIP_MRP_TYPE();
            InitData(true);
        }

        private List<string> IDInit = new List<string>();
        private void InitData(bool isFirst = false, string mrp = "")
        {
            try
            {
                // Init combobox data
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;

                    if (isFirst)
                    {
                        base.m_BindData.BindGridLookEdit(stlMrpCode, data[0], "MRP_CODE", "TITLE");
                        base.m_BindData.BindGridLookEdit(stlMRP_CODE, data[0], "MRP_CODE", "TITLE");
                        base.m_BindData.BindGridLookEdit(stlUnit, data[1], "CODE", "NAME");
                        base.m_BindData.BindGridLookEdit(stlSparepart, data[2], "CODE", "NAME_VI");
                        base.m_BindData.BindGridLookEdit(stlStatus, data[3], "CODE", "NAME");

                        stlStatus.EditValue = "NEW";
                    }

                    DataRow newRowUp = data[4].NewRow();
                    data[4].Rows.InsertAt(newRowUp, 0);

                    DataRow newRowBelow = data[5].NewRow();
                    data[5].Rows.InsertAt(newRowBelow, 0);

                    gcList.DataSource = data[4];
                    gcListBelow.DataSource = data[5];

                    gvList.OptionsBehavior.Editable = true;

                    foreach (GridColumn item in gvList.Columns)
                    {
                        if(item.FieldName != "OFF_NOTI")
                        {
                            item.OptionsColumn.AllowEdit = false;
                        }
                    }

                    gvList.Columns["ID"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;
                    gvListBelow.Columns["ID"].Visible = false;
                    gvListBelow.OptionsView.ColumnAutoWidth = true;
                    //gvListBelow.OptionsSelection.MultiSelect = true;
                    //gvListBelow.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                    stlMrpCode.EditValue = "";
                    if (mrp != "")
                    {
                        stlMrpCode.EditValue = mrp;

                        IDInit.Clear();
                        for (int i = 0; i < gvListBelow.RowCount; i++)
                        {
                            IDInit.Add(gvListBelow.GetRowCellValue(i, "ID").NullString());
                        }
                    }
                    else
                    {
                        GetMRPbyCode("");
                    }
                }

                ControlState();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        DataTable MRP_TYPE;
        private void CREAT_EWIP_MRP_TYPE()
        {
            MRP_TYPE = new DataTable();
            MRP_TYPE.Columns.Add("ID");
            MRP_TYPE.Columns.Add("SPAREPART_CODE");
            MRP_TYPE.Columns.Add("QUANTITY_NEED_BUY");
            MRP_TYPE.Columns.Add("UNIT");
            MRP_TYPE.Columns.Add("STATUS");
            MRP_TYPE.Columns.Add("DATE_NEED_BUY");
            MRP_TYPE.Columns.Add("DATE_NEED_FINISH");
            MRP_TYPE.Columns.Add("DATE_END_ACTUAL");
            MRP_TYPE.Columns.Add("USER_UPDATE");
            MRP_TYPE.Columns.Add("DATE_UPDATE");
            MRP_TYPE.Columns.Add("OFF_NOTI]");
            MRP_TYPE.Columns.Add("DATE_NEED_REQUIRED");
            MRP_TYPE.Columns.Add("DEPT_CODE");
            MRP_TYPE.Columns.Add("MRP_CODE");
        }

        private void GetMRP_LIST()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP_LIST.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridLookEdit(stlMrpCode, data[0], "MRP_CODE", "TITLE", "ID,DATE_CREATE,STATUS,DEPT_CODE,DATE_END_ACTUAL,DATE_NEED_FINISH,USER_CREATE,USER_UPDATE,DATE_UPDATE");
                    base.m_BindData.BindGridLookEdit(stlMRP_CODE, data[0], "MRP_CODE", "TITLE", "ID,DATE_CREATE,STATUS,DEPT_CODE,DATE_END_ACTUAL,DATE_NEED_FINISH,USER_CREATE,USER_UPDATE,DATE_UPDATE");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void GetImage(string sparepart)
        {
            try
            {
                img.Image = null;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_IMG", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { Consts.DEPARTMENT, sparepart });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    if (data[0].Rows.Count > 0)
                    {
                        string strImg = data[0].Rows[0]["IMAGE"].NullString();
                        Classes.Common.ShowImge(strImg, img);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void ControlState()
        {
            dateNeedRequired.Enabled = false;
            dateNeedBuy.Enabled = false;
            dateEndActual.Enabled = false;
        }

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepart.EditValue.NullString(), stlUnit, m_BindData);
            GetImage(stlSparepart.EditValue.NullString());
        }

        private void btnMrpCode_Click(object sender, EventArgs e)
        {
            POP.CREATE_MRP_CODE popup = new POP.CREATE_MRP_CODE();
            popup.ShowDialog();
            GetMRP_LIST();
        }

        private void btnCreateMRP_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlMrpCode.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("CONFIRM_UPDATE".Translation(), MsgType.Information, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    DataRow row;
                    MRP_TYPE.Rows.Clear();

                    for (int i = 1; i < gvListBelow.RowCount; i++)
                    {
                        row = MRP_TYPE.NewRow();
                        row["ID"] = gvListBelow.GetRowCellValue(i, "ID").NullString();
                        row["SPAREPART_CODE"] = gvListBelow.GetRowCellValue(i, "SPAREPART_CODE").NullString();
                        row["QUANTITY_NEED_BUY"] = gvListBelow.GetRowCellValue(i, "QUANTITY_NEED_BUY").NullString();
                        row["UNIT"] = gvListBelow.GetRowCellValue(i, "UNIT").NullString();
                        row["STATUS"] = gvListBelow.GetRowCellValue(i, "STATUS").NullString();

                        if (gvListBelow.GetRowCellValue(i, "DATE_NEED_BUY").NullString() != "")
                        {
                            row["DATE_NEED_BUY"] = gvListBelow.GetRowCellValue(i, "DATE_NEED_BUY").NullString();
                        }

                        if (gvListBelow.GetRowCellValue(i, "DATE_NEED_FINISH").NullString() != "")
                        {
                            row["DATE_NEED_FINISH"] = gvListBelow.GetRowCellValue(i, "DATE_NEED_FINISH").NullString();
                        }

                        if (gvListBelow.GetRowCellValue(i, "DATE_END_ACTUAL").NullString() != "")
                        {
                            row["DATE_END_ACTUAL"] = gvListBelow.GetRowCellValue(i, "DATE_END_ACTUAL").NullString();
                        }

                        row["USER_UPDATE"] = gvListBelow.GetRowCellValue(i, "USER_UPDATE").NullString();

                        if (gvListBelow.GetRowCellValue(i, "DATE_UPDATE").NullString() != "")
                        {
                            row["DATE_UPDATE"] = gvListBelow.GetRowCellValue(i, "DATE_UPDATE").NullString();
                        }

                        row["OFF_NOTI]"] = gvListBelow.GetRowCellValue(i, "OFF_NOTI").NullString();

                        if (gvListBelow.GetRowCellValue(i, "DATE_NEED_REQUIRED").NullString() != "")
                        {
                            row["DATE_NEED_REQUIRED"] = gvListBelow.GetRowCellValue(i, "DATE_NEED_REQUIRED").NullString();
                        }

                        row["DEPT_CODE"] = gvListBelow.GetRowCellValue(i, "DEPT_CODE").NullString();
                        row["MRP_CODE"] = stlMrpCode.EditValue.NullString();
                        MRP_TYPE.Rows.Add(row);
                    }

                    if (MRP_TYPE.Rows.Count > 0)
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_MRP_PLAN.PUT", new string[] { "A_DEPARTMENT", "A_MRP_CODE", "A_USER" }, "A_DATA", new string[] { Consts.DEPARTMENT, stlMrpCode.EditValue.NullString(), Consts.USER_INFO.Id }, MRP_TYPE);

                        if (m_ResultDB.ReturnInt == 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                            MRP_TYPE.Rows.Clear();
                            InitData(false, stlMrpCode.EditValue.NullString());
                        }
                        else
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                    }
                    else
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.DETACK_ALL_MRP", new string[] { "A_DEPT_CODE", "A_USER", "A_MRP" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.Id, stlMrpCode.EditValue.NullString() });

                        if (m_ResultDB.ReturnInt == 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                            MRP_TYPE.Rows.Clear();
                            InitData(false, stlMrpCode.EditValue.NullString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellClick(object sender, RowCellClickEventArgs e)
        {
            if (e.RowHandle <= 0)
                return;

            if (e.Column.FieldName == "ADD")
            {
                try
                {
                    if (stlMrpCode.EditValue.NullString() == "")
                    {
                        MsgBox.Show("HÃY CHỌN MÃ YÊU CẦU THIẾT BỊ MRP", MsgType.Warning);
                        return;
                    }

                    gvListBelow.BeginSort();
                    DataRow oldRow = gvList.GetDataRow(e.RowHandle);
                    int newRowHandle = gvListBelow.RowCount - 1;
                    DataRowView newRow = (gvListBelow.DataSource as DataView).AddNew();

                    for (int i = 0; i < gvListBelow.Columns.Count - 1; i++)
                    {
                        string value = oldRow[i].NullString();

                        if (gvListBelow.Columns[i].FieldName.ToString().StartsWith("DATE"))
                        {
                            if (value != "")
                            {
                                newRow[gvListBelow.Columns[i].FieldName] = DateTime.Parse(value);
                            }
                            else
                            {
                                newRow[gvListBelow.Columns[i].FieldName] = DBNull.Value;
                            }
                        }
                        else
                        {
                            newRow[gvListBelow.Columns[i].FieldName] = value;
                        }
                    }
                    gvListBelow.EndSort();
                    gvList.DeleteRow(e.RowHandle);
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
            else
            {
                GetSingleMrp(e.RowHandle, gvList);
            }
        }

        private void GetSingleMrp(int rowHanle, XGridView gvlst)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.GET_SINGLE", new string[] { "A_ID" }, new string[] { gvlst.GetRowCellValue(rowHanle, "ID").NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = m_ResultDB.ReturnDataSet.Tables;
                    if (data[0].Rows.Count > 0)
                    {
                        string isOff = gvlst.GetRowCellValue(rowHanle, "OFF_NOTI").NullString();

                        if(!bool.TryParse(isOff,out _))
                        {
                            isOff = "False";
                        }

                        txtID.EditValue = gvlst.GetRowCellValue(rowHanle, "ID").NullString();
                        stlMRP_CODE.EditValue = data[0].Rows[0]["MRP_CODE"].NullString();
                        stlSparepart.EditValue = data[0].Rows[0]["SPAREPART_CODE"].NullString();
                        txtQuantityNeedBuy.EditValue = data[0].Rows[0]["QUANTITY_NEED_BUY"].NullString();
                        stlUnit.EditValue = data[0].Rows[0]["UNIT"].NullString();
                        stlStatus.EditValue = data[0].Rows[0]["STATUS"].NullString() == "" ? "NEW" : data[0].Rows[0]["STATUS"].NullString();
                        dateNeedRequired.EditValue = data[0].Rows[0]["DATE_NEED_REQUIRED"].NullString();
                        dateNeedBuy.EditValue = data[0].Rows[0]["DATE_NEED_BUY"].NullString();
                        dateNeedFinish.EditValue = data[0].Rows[0]["DATE_NEED_FINISH"].NullString();
                        dateEndActual.EditValue = data[0].Rows[0]["DATE_END_ACTUAL"].NullString();
                        checkOffNoti.Checked = bool.Parse(isOff); // == bool.Parse(data[0].Rows[0]["OFF_NOTI"].NullString() == "" ? "False" : data[0].Rows[0]["OFF_NOTI"].NullString());
                    }
                }
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
                for (int i = 0; i < gvListBelow.RowCount; i++)
                {
                    if (!IDInit.Contains(gvListBelow.GetRowCellValue(i, "ID").NullString()))
                    {
                        MsgBox.Show("HÃY LƯU THÔNG TIN DANH SÁCH THIẾT BỊ ĐỂ TẠO YÊU CẦU NGUYÊN VẬT LIỆU", MsgType.Warning);
                        btnCreateMRP.Focus();
                        return;
                    }
                }

                if (stlSparepart.EditValue.NullString() == "" ||
                    txtQuantityNeedBuy.EditValue.NullString() == "" ||
                    stlUnit.EditValue.NullString() == "" ||
                    stlStatus.EditValue.NullString() == "" ||
                    dateNeedFinish.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                string isOffNoti = checkOffNoti.Checked == true ? "True" : "False";
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.PUT",
                                    new string[] {
                                                   "A_ID",
                                                   "A_DEPARTMENT",
                                                   "A_MRP_CODE",
                                                   "A_SPAREPART_CODE",
                                                   "A_QUANTITY_NEED_BUY",
                                                   "A_UNIT",
                                                   "A_DATE_NEED_BUY",
                                                   "A_DATE_NEED_FINISH",
                                                   "A_DATE_END_ACTUAL",
                                                   "A_USER","A_OFF_NOTI",
                                                   "A_STATUS",
                                                   "A_DATE_NEED_REQUIRED"
                                                },
                                    new string[] { txtID.EditValue.NullString(),
                                        Consts.DEPARTMENT,
                                        stlMRP_CODE.EditValue.NullString(),
                                        stlSparepart.EditValue.NullString(),
                                        txtQuantityNeedBuy.EditValue.NullString(),
                                        stlUnit.EditValue.NullString(),
                                        dateNeedBuy.EditValue.NullString(),
                                        dateNeedFinish.EditValue.NullString(),
                                        dateEndActual.EditValue.NullString(),
                                        Consts.USER_INFO.Id,isOffNoti,stlStatus.EditValue.NullString(),dateNeedRequired.EditValue.NullString()});

                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData(false, stlMRP_CODE.EditValue.NullString());
                    ClearData();
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

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearData();
        }

        private void ClearData()
        {
            stlSparepart.EditValue = null;
            txtID.EditValue = null;
            stlMRP_CODE.EditValue = null;
            txtQuantityNeedBuy.EditValue = null;
            stlUnit.EditValue = null;
            stlStatus.EditValue = "NEW";
            dateNeedRequired.EditValue = null;
            dateNeedBuy.EditValue = null;
            dateNeedFinish.EditValue = null;
            dateEndActual.EditValue = null;
            checkOffNoti.Checked = false;
            img.Image = null;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtID.EditValue.NullString() != "")
                {
                    DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                    if (dialogResult == DialogResult.OK)
                    {
                        base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.DELETE", new string[] { "A_ID" }, new string[] { txtID.EditValue.NullString() });
                        if (m_ResultDB.ReturnInt == 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                            InitData();
                            ClearData();
                        }
                        else
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            try
            {
                if (e.RowHandle == 0)
                {
                    e.Appearance.BackColor = Color.FromArgb(229, 231, 233);
                    return;
                }

                string status = gvList.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                string isOff = gvList.GetRowCellValue(e.RowHandle, "OFF_NOTI").NullString();
                string dateNeedRequest = gvList.GetRowCellValue(e.RowHandle, "DATE_NEED_REQUIRED").NullString();
                string dateNeedOrder = gvList.GetRowCellValue(e.RowHandle, "DATE_NEED_BUY").NullString();
                string dateNeedFinish = gvList.GetRowCellValue(e.RowHandle, "DATE_NEED_FINISH").NullString();

                if (e.Column.FieldName == "STATUS")
                {
                    if (status == "")
                        return;

                    if (status == Consts.STATUS_NEW)
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightSalmon;
                    }
                }

                if (e.Column.FieldName == "DATE_NEED_REQUIRED")
                {
                    if (!string.IsNullOrEmpty(dateNeedRequest) && DateTime.Now >= DateTime.Parse(dateNeedRequest) && status == Consts.STATUS_NEW)
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 204, 204);
                    }
                    else if (string.IsNullOrEmpty(dateNeedRequest))
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 252, 226);
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                }

                if (e.Column.FieldName == "DATE_NEED_BUY")
                {
                    if (!string.IsNullOrEmpty(dateNeedOrder) && DateTime.Now >= DateTime.Parse(dateNeedOrder) && (status == Consts.STATUS_ACCEPT || status == Consts.STATUS_NEW || status == Consts.STATUS_WAIT_ACCEPT || status == Consts.STATUS_PUR_RECEIPT))
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 204, 204);
                    }
                    else if (string.IsNullOrEmpty(dateNeedOrder))
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 252, 226);
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                }

                if (e.Column.FieldName == "DATE_NEED_FINISH")
                {
                    if (!string.IsNullOrEmpty(dateNeedFinish) && DateTime.Now >= DateTime.Parse(dateNeedFinish) && (status != Consts.STATUS_RECEIVE && status == Consts.STATUS_COMPLETE))
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 204, 204);
                    }
                    else if (string.IsNullOrEmpty(dateNeedFinish))
                    {
                        e.Appearance.BackColor = Color.FromArgb(255, 252, 226);
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.LightGreen;
                    }
                }

                if (status == Consts.STATUS_COMPLETE || isOff == "True")
                {
                    e.Appearance.BackColor = Color.FromArgb(224, 224, 224);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnMRP_List_Click(object sender, EventArgs e)
        {
            POP.MRP_LIST pop = new POP.MRP_LIST();
            pop.ShowDialog();
            InitData(true);
        }

        private void stlMrpCode_EditValueChanged(object sender, EventArgs e)
        {
            GetMRPbyCode(stlMrpCode.EditValue.NullString());
        }

        private void GetMRPbyCode(string mrp)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.GET_MRP_BY_CODE", new string[] { "A_DEPARTMENT", "A_MRP_CODE" }, new string[] { Consts.DEPARTMENT, mrp });
                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    gcListBelow.DataSource = data;

                    DataRow newRowBelow = data.NewRow();
                    data.Rows.InsertAt(newRowBelow, 0);

                    gvListBelow.Columns["ID"].Visible = false;
                    gvListBelow.OptionsView.ColumnAutoWidth = true;
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }

                IDInit.Clear();
                for (int i = 0; i < gvListBelow.RowCount; i++)
                {
                    IDInit.Add(gvListBelow.GetRowCellValue(i, "ID").NullString());
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvListBelow_RowCellClick(object sender, RowCellClickEventArgs e)
        {
            if (e.RowHandle <= 0)
            {
                return;
            }

            if (e.Column.FieldName == "SUB")
            {
                try
                {
                    string status = gvListBelow.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                    if (status != "NEW" && status != "WAIT_ACCEPT" && status != "")
                    {
                        return;
                    }

                    if (stlMrpCode.EditValue.NullString() == "")
                    {
                        MsgBox.Show("HÃY CHỌN MÃ YÊU CẦU THIẾT BỊ MRP", MsgType.Warning);
                        return;
                    }

                    DataRow oldRow = gvListBelow.GetDataRow(e.RowHandle);
                    gvList.BeginSort();
                    DataRowView newRow = (gvList.DataSource as DataView).AddNew();
                    for (int i = 0; i < gvList.Columns.Count - 1; i++)
                    {
                        string value = oldRow[i].NullString();
                        if (gvList.Columns[i].FieldName.ToString().StartsWith("DATE"))
                        {
                            if (value != "")
                            {
                                newRow[gvList.Columns[i].FieldName] = DateTime.Parse(value);
                            }
                            else
                            {
                                newRow[gvList.Columns[i].FieldName] = DBNull.Value;
                            }
                        }
                        else
                        {
                            newRow[gvList.Columns[i].FieldName] = value;
                        }
                    }
                    gvList.EndSort();
                    gvListBelow.DeleteRow(e.RowHandle);
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
            else
            {
                GetSingleMrp(e.RowHandle, gvListBelow);
            }
        }

        private void gvListBelow_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            if (e.RowHandle <= 0)
            {
                e.Appearance.BackColor = Color.FromArgb(229, 231, 233);
                return;
            }

            string status = gvListBelow.GetRowCellValue(e.RowHandle, "STATUS").NullString();
            if (status != "NEW" && status != "WAIT_ACCEPT" && status != "")
            {
                e.Appearance.BackColor = Color.FromArgb(229, 231, 233);
            }
        }

        private void btnNextPagePR_Click(object sender, EventArgs e)
        {
            Consts.mainForm.NewPageFromOtherPage("PURCHASE_REQUEST", "Yêu cầu mua hàng-구매 요청", "W", "Y", "");
        }

        private void btnReloadData_Click(object sender, EventArgs e)
        {
            InitData(true);
        }

        private void gvList_CustomColumnDisplayText(object sender, DevExpress.XtraGrid.Views.Base.CustomColumnDisplayTextEventArgs e)
        {
        }
    }
}
