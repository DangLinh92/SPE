using System;
using System.Data;
using System.Drawing;
using System.Linq;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class PO_CREATE : FormType
    {
        public string PO_CODE_TEMP = string.Empty;
        public string PO_ID = string.Empty;
        public string Mode = string.Empty;

        public PO_CREATE()
        {
            InitializeComponent();
            this.Load += PO_CREATE_Load;
        }

        private void PO_CREATE_Load(object sender, EventArgs e)
        {
            InitData();
        }

        DataTable PR_TYPE;
        private void CREAT_PO_TYPE()
        {
            PR_TYPE = new DataTable();
            PR_TYPE.Columns.Add("ID");
            PR_TYPE.Columns.Add("PR_CODE");
            PR_TYPE.Columns.Add("MRP_CODE");
            PR_TYPE.Columns.Add("TOTAL_VALUE");
            PR_TYPE.Columns.Add("TOTAL_VALUE_US");
            PR_TYPE.Columns.Add("DATE_CREATE");
            PR_TYPE.Columns.Add("DATE_NEED_FINISH");
            PR_TYPE.Columns.Add("DEPT_CODE");
            PR_TYPE.Columns.Add("STATUS");
        }

        private void InitData()
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_ALL_DEPT", new string[] { }, new string[] { });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.mResultDB.ReturnDataSet.Tables;

                    mBindData.BindGridLookEdit(stlPO, data[1], "PO_ID", "PO_ID");

                    DataRow newRowUp = data[0].NewRow();
                    data[0].Rows.InsertAt(newRowUp, 0);

                    DataRow newRowBelow = data[2].NewRow();
                    data[2].Rows.InsertAt(newRowBelow, 0);

                    gcListPr.DataSource = data[0];
                    gvListPr.Columns["ID"].Visible = false;
                    gvListPr.OptionsView.ColumnAutoWidth = true;

                    gcListPr_PO.DataSource = data[2];
                    gvListPr_PO.OptionsView.ColumnAutoWidth = true;
                    gvListPr_PO.Columns["ID"].Visible = false;

                    if (PO_ID != string.Empty)
                    {
                        stlPO.EditValue = PO_ID;
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvListPr_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle <= 0)
                    return;

                if (e.Column.FieldName == "ADD")
                {
                    gvListPr_PO.BeginSort();
                    DataRow oldRow = gvListPr.GetDataRow(e.RowHandle);
                    int newRowHandle = gvListPr_PO.RowCount - 1;
                    DataRowView newRow = (gvListPr_PO.DataSource as DataView).AddNew();

                    for (int i = 0; i < gvListPr_PO.Columns.Count - 1; i++)
                    {
                        string value = oldRow[i].NullString();

                        if (gvListPr_PO.Columns[i].FieldName.ToString().StartsWith("DATE"))
                        {
                            if (value != string.Empty)
                            {
                                newRow[gvListPr_PO.Columns[i].FieldName] = DateTime.Parse(value);
                            }
                            else
                            {
                                newRow[gvListPr_PO.Columns[i].FieldName] = DBNull.Value;
                            }
                        }
                        else
                        if (gvListPr_PO.Columns[i].FieldName.ToString() == "STATUS")
                        {
                            newRow[gvListPr_PO.Columns[i].FieldName] = "PUR_RECEIPT";
                        }
                        else
                        {
                            newRow[gvListPr_PO.Columns[i].FieldName] = value;
                        }
                    }

                    PutOderPR(stlPO.EditValue.NullString(), oldRow["PR_CODE"].NullString(), "PUR_RECEIPT", oldRow["DATE_NEED_FINISH"].NullString(), oldRow["DEPT_CODE"].NullString(),"False");
                    gvListPr_PO.EndSort();
                    gvListPr.DeleteRow(e.RowHandle);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvListPr_PO_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle <= 0)
            {
                return;
            }

            if (e.Column.FieldName == "SUB")
            {
                try
                {
                    string status = gvListPr_PO.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                    string[] arrStatus = { string.Empty, "ACCEPT", "NEW", "WAIT_ACCEPT", "PUR_RECEIPT", "ORDER" };
                    if (!arrStatus.Contains(status))
                    {
                        return;
                    }

                    DataRow oldRow = gvListPr_PO.GetDataRow(e.RowHandle);
                    gvListPr.BeginSort();
                    DataRowView newRow = (gvListPr.DataSource as DataView).AddNew();
                    for (int i = 0; i < gvListPr.Columns.Count - 1; i++)
                    {
                        string value = oldRow[i].NullString();
                        if (gvListPr.Columns[i].FieldName.ToString().StartsWith("DATE"))
                        {
                            if (value != string.Empty)
                            {
                                newRow[gvListPr.Columns[i].FieldName] = DateTime.Parse(value);
                            }
                            else
                            {
                                newRow[gvListPr.Columns[i].FieldName] = DBNull.Value;
                            }
                        }
                        else
                        if (gvListPr.Columns[i].FieldName.ToString() == "STATUS")
                        {
                            newRow[gvListPr.Columns[i].FieldName] = "ACCEPT";
                        }
                        else
                        {
                            newRow[gvListPr.Columns[i].FieldName] = value;
                        }
                    }

                    PutOderPR(string.Empty, oldRow["PR_CODE"].NullString(), "ACCEPT", oldRow["DATE_NEED_FINISH"].NullString(), oldRow["DEPT_CODE"].NullString(),"True");
                    gvListPr.EndSort();
                    gvListPr_PO.DeleteRow(e.RowHandle);
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
        }

        private void PutOderPR(string po_id, string prCode, string status, string dateFinish, string deptCode,string isDetack)
        {
            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_ORDER_PR.PUT",
                new string[] { "A_USER", "A_PO_ID", "A_PR_CODE", "A_STATUS", "A_DATE_NEED_FINISH", "A_DEPT_CODE_PR", "A_PO_ID_TEMP", "A_IS_DETACK" },
                new string[] { Consts.USER_INFO.Id, po_id, prCode, status, dateFinish, deptCode, PO_CODE_TEMP,isDetack });
            if (mResultDB.ReturnInt != 0)
            {
                throw new Exception(mResultDB.ReturnString);
            }
        }

        private void btnCreatePO_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvListPr_PO.RowCount <= 1)
                {
                    MsgBox.Show("KHÔNG CÓ YÊU CẦU MUA HÀNG ĐƯỢC TẠO CHO PO!!!", MsgType.Warning);
                    return;
                }

                splashScreenManager1.ShowWaitForm();
                string PR_LIST = string.Empty;
                for (int i = 1; i < gvListPr_PO.RowCount; i++)
                {
                    if (gvListPr_PO.GetRowCellValue(i, "PR_CODE").NullString() != string.Empty)
                    {
                        PR_LIST += gvListPr_PO.GetRowCellValue(i, "PR_CODE").NullString() + "^";
                    }
                }

                PR_LIST += "$" + PO_CODE_TEMP + "$" + stlPO.EditValue.NullString() + "$" + Mode;

                Consts.mainForm.NewPageFromOtherPage("PO_EXPORT", "PO FILE", "W", "Y", PR_LIST);
                splashScreenManager1.CloseWaitForm();
                this.Close();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvListPr_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0) return;

            if (e.RowHandle == 0)
            {
                e.Appearance.BackColor = Color.FromArgb(229, 231, 233);
                return;
            }
        }

        private void gvListPr_PO_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0) return;

            if (e.RowHandle == 0)
            {
                e.Appearance.BackColor = Color.FromArgb(229, 231, 233);
                return;
            }
        }

        private void stlPO_ID_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PO.GET_PO_BY_ID", new string[] { "A_PO_ID" }, new string[] { stlPO.EditValue.NullString() });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.mResultDB.ReturnDataSet.Tables;

                    DataRow newRowBelow = data[0].NewRow();
                    data[0].Rows.InsertAt(newRowBelow, 0);

                    gcListPr_PO.DataSource = data[0];
                    gvListPr_PO.OptionsView.ColumnAutoWidth = true;
                    gvListPr_PO.Columns["ID"].Visible = false;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnReload_Click(object sender, EventArgs e)
        {
            InitData();
        }
    }
}
