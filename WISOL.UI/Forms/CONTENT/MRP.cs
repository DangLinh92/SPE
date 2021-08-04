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
            CREAT_EWIP_MRP_TYPE();
            InitData();
        }

        private void InitData()
        {
            try
            {
                // Init combobox data
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridLookEdit(stlMrpCode, data[0], "MRP_CODE", "TITLE");
                    base.m_BindData.BindGridLookEdit(stlMRP_CODE, data[0], "MRP_CODE", "TITLE");
                    base.m_BindData.BindGridLookEdit(stlUnit, data[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlSparepart, data[2], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlStatus, data[3], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlStatus, data[3], "CODE", "NAME");
                    base.m_BindData.BindGridView(gcList, data[4]);

                    gvList.OptionsSelection.MultiSelect = true;
                    gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;
                    gvList.Columns["ID"].Visible = false;
                    gvList.OptionsView.ColumnAutoWidth = true;
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
                DataRow row;
                MRP_TYPE.Rows.Clear();

                foreach (int i in gvList.GetSelectedRows())
                {
                    row = MRP_TYPE.NewRow();
                    row["ID"] = gvList.GetRowCellValue(i, "ID").NullString();
                    row["SPAREPART_CODE"] = gvList.GetRowCellValue(i, "SPAREPART_CODE").NullString();
                    row["QUANTITY_NEED_BUY"] = gvList.GetRowCellValue(i, "QUANTITY_NEED_BUY").NullString();
                    row["UNIT"] = gvList.GetRowCellValue(i, "UNIT").NullString();
                    row["STATUS"] = gvList.GetRowCellValue(i, "STATUS").NullString();

                    if (gvList.GetRowCellValue(i, "DATE_NEED_BUY").NullString() != "")
                    {
                        row["DATE_NEED_BUY"] = gvList.GetRowCellValue(i, "DATE_NEED_BUY").NullString();
                    }

                    if (gvList.GetRowCellValue(i, "DATE_NEED_FINISH").NullString() != "")
                    {
                        row["DATE_NEED_FINISH"] = gvList.GetRowCellValue(i, "DATE_NEED_FINISH").NullString();
                    }

                    if (gvList.GetRowCellValue(i, "DATE_END_ACTUAL").NullString() != "")
                    {
                        row["DATE_END_ACTUAL"] = gvList.GetRowCellValue(i, "DATE_END_ACTUAL").NullString();
                    }

                    row["USER_UPDATE"] = gvList.GetRowCellValue(i, "USER_UPDATE").NullString();

                    if (gvList.GetRowCellValue(i, "DATE_UPDATE").NullString() != "")
                    {
                        row["DATE_UPDATE"] = gvList.GetRowCellValue(i, "DATE_UPDATE").NullString();
                    }

                    row["OFF_NOTI]"] = gvList.GetRowCellValue(i, "OFF_NOTI").NullString();

                    if (gvList.GetRowCellValue(i, "DATE_NEED_REQUIRED").NullString() != "")
                    {
                        row["DATE_NEED_REQUIRED"] = gvList.GetRowCellValue(i, "DATE_NEED_REQUIRED").NullString();
                    }

                    row["DEPT_CODE"] = gvList.GetRowCellValue(i, "DEPT_CODE").NullString();
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
                        gvList.ClearSelection();
                        InitData();
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
                else
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellClick(object sender, RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.GET_SINGLE", new string[] { "A_ID" }, new string[] { gvList.GetRowCellValue(e.RowHandle, "ID").NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = m_ResultDB.ReturnDataSet.Tables;
                    if (data[0].Rows.Count > 0)
                    {
                        txtID.EditValue = gvList.GetRowCellValue(e.RowHandle, "ID").NullString();
                        stlMRP_CODE.EditValue = data[0].Rows[0]["MRP_CODE"].NullString();
                        stlSparepart.EditValue = data[0].Rows[0]["SPAREPART_CODE"].NullString();
                        txtQuantityNeedBuy.EditValue = data[0].Rows[0]["QUANTITY_NEED_BUY"].NullString();
                        stlUnit.EditValue = data[0].Rows[0]["UNIT"].NullString();
                        stlStatus.EditValue = data[0].Rows[0]["STATUS"].NullString() == "" ? "NEW" : data[0].Rows[0]["STATUS"].NullString();
                        dateNeedRequired.EditValue = data[0].Rows[0]["DATE_NEED_REQUIRED"].NullString();
                        dateNeedBuy.EditValue = data[0].Rows[0]["DATE_NEED_BUY"].NullString();
                        dateNeedFinish.EditValue = data[0].Rows[0]["DATE_NEED_FINISH"].NullString();
                        dateEndActual.EditValue = data[0].Rows[0]["DATE_END_ACTUAL"].NullString();
                        checkOffNoti.Checked = bool.Parse(data[0].Rows[0]["OFF_NOTI"].NullString() == "" ? "False" : data[0].Rows[0]["OFF_NOTI"].NullString());
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
                    InitData();
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
                    else if(string.IsNullOrEmpty(dateNeedRequest))
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
            InitData();
        }
    }
}
