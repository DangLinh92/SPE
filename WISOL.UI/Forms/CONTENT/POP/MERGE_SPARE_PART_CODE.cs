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

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class MERGE_SPARE_PART_CODE : FormType
    {
        public string PR_LIST { get; set; }

        private DataTable DATA;
        public MERGE_SPARE_PART_CODE()
        {
            InitializeComponent();
            this.Load += MERGE_SPARE_PART_CODE_Load;

            DATA = new DataTable();
            DATA.Columns.Add("SPARE_PART_CODE");
            DATA.Columns.Add("CODE_MERGED");
            DATA.Columns.Add("DEPT_CODE");
        }

        private void MERGE_SPARE_PART_CODE_Load(object sender, EventArgs e)
        {
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PO.MERGE_CODE", new string[] { "A_PR_LIST" }, new string[] { PR_LIST });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    mBindData.BindGridView(gcList, data);
                   
                    gvList.OptionsSelection.MultiSelect = true;
                    gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;
                    //gvList.OptionsView.ColumnAutoWidth = true;
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
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

            string sparepartCode = gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
            string deptCode = gvList.GetRowCellValue(e.RowHandle, "DEPT_CODE").NullString();
            string newCode = gvList.GetRowCellValue(e.RowHandle, "CODE_MERGED").NullString();

            string newItem = sparepartCode + "^" + deptCode;
            if (gvList.IsRowSelected(e.RowHandle) && !lstCode.Items.Contains(newItem))
            {
                lstCode.Items.Add(newItem);
                if (newCode != "")
                {
                    txtNewCode.Text = newCode;
                }
            }
            else if (!gvList.IsRowSelected(e.RowHandle) && lstCode.Items.Contains(newItem))
            {
                lstCode.Items.Remove(newItem);

                if (newCode != "" && txtNewCode.Text.NullString() == newCode)
                {
                    txtNewCode.Text = "";
                }
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            lstCode.Items.Clear();
        }

        private void btnMergeCode_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtNewCode.Text.NullString() == "")
                {
                    MsgBox.Show("HÃY NHẬP MÃ CODE MỚI!", MsgType.Warning);
                    txtNewCode.Focus();
                    return;
                }
                DialogResult dialogResult = MsgBox.Show("NHẤN OK ĐỂ XÁC NHẬN MERGE CODE!", MsgType.Information, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    DATA.Rows.Clear();
                    foreach (string item in lstCode.Items)
                    {
                        DataRow row = DATA.NewRow();
                        row["SPARE_PART_CODE"] = item.Split('^')[0].NullString();
                        row["DEPT_CODE"] = item.Split('^')[1].NullString();
                        row["CODE_MERGED"] = txtNewCode.Text.NullString();
                        DATA.Rows.Add(row);
                    }

                    if (DATA.Rows.Count == 0)
                    {
                        MsgBox.Show("HÃY CHỌN THIẾT BỊ ĐỂ TẠO MÃ MỚI!!", MsgType.Warning);
                        return;
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_PO.MERGED_CODE_PUT", new string[] { "A_USER" }, "A_DATA", new string[] { Consts.USER_INFO.Id }, DATA);
                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                        txtNewCode.Text = "";
                    }
                    else
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCreateCode_Click(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PO.CREATE_MERGED_CODE", new string[] { }, new string[] { });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    txtNewCode.Text = data.Rows[0]["CODE"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCancelMerge_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("NHẤN OK ĐỂ XÁC NHẬN CANCEL MERGE CODE!", MsgType.Information, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    DATA.Rows.Clear();
                    foreach (string item in lstCode.Items)
                    {
                        DataRow row = DATA.NewRow();
                        row["SPARE_PART_CODE"] = item.Split('^')[0].NullString();
                        row["DEPT_CODE"] = item.Split('^')[1].NullString();
                        row["CODE_MERGED"] = txtNewCode.Text.NullString();
                        DATA.Rows.Add(row);
                    }

                    if (DATA.Rows.Count == 0)
                    {
                        MsgBox.Show("HÃY CHỌN THIẾT BỊ ĐỂ HỦY MÃ MỚI!!", MsgType.Warning);
                        return;
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_PO.CANCEL_MERGE_CODE", new string[] { }, "A_DATA", new string[] { }, DATA);
                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                        txtNewCode.Text = "";
                    }
                    else
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
