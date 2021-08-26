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
    public partial class PO_CANCEL : FormType
    {
        public string PO_ID { get; set; }

        private DataTable SP_MRP_PR_PO_TYPE = new DataTable();
        public PO_CANCEL()
        {
            InitializeComponent();

            SP_MRP_PR_PO_TYPE.Columns.Add("PO_ID");
            SP_MRP_PR_PO_TYPE.Columns.Add("MRP_CODE");
            SP_MRP_PR_PO_TYPE.Columns.Add("PR_CODE");
            SP_MRP_PR_PO_TYPE.Columns.Add("SPARE_PART_CODE");
            SP_MRP_PR_PO_TYPE.Columns.Add("DEPT_CODE");
        }

        private void PO_CANCEL_Load(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_PO.GET_MRP_BY_POID", new string[] { "A_PO_ID" }, new string[] { PO_ID });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.mResultDB.ReturnDataSet.Tables;
                    base.mBindData.BindGridView(gcList, data[0]);

                    gvList.Columns["PR_CODE"].Visible = false;
                    gvList.Columns["MRP_CODE"].Visible = false;
                    gvList.OptionsSelection.MultiSelect = true;
                    gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;
                    gvList.OptionsView.ColumnAutoWidth = true;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnCancelPO_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvList.GetSelectedRows().Length <= 0)
                {
                    MsgBox.Show("HÃY CHỌN THIẾT BỊ MUỐN HỦY ORDER!!!", MsgType.Warning);
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("BẠN CÓ MUỐN HỦY ORDER , NHẤN OKE ĐỂ XÁC NHẬN ?".Translation(), MsgType.Warning, Components.DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    SP_MRP_PR_PO_TYPE.Rows.Clear();
                    DataRow row;
                    foreach (int i in gvList.GetSelectedRows())
                    {
                        row = SP_MRP_PR_PO_TYPE.NewRow();
                        row["PO_ID"] = gvList.GetRowCellValue(i, "PO_ID").NullString();
                        row["MRP_CODE"] = gvList.GetRowCellValue(i, "MRP_CODE").NullString();
                        row["PR_CODE"] = gvList.GetRowCellValue(i, "PR_CODE").NullString();
                        row["SPARE_PART_CODE"] = gvList.GetRowCellValue(i, "SPAREPART_CODE").NullString();
                        row["DEPT_CODE"] = gvList.GetRowCellValue(i, "DEPT_CODE").NullString();
                        SP_MRP_PR_PO_TYPE.Rows.Add(row);
                    }

                    string isCancelAll = "False";
                    if (gvList.GetSelectedRows().Length == gvList.RowCount)
                    {
                        isCancelAll = "True";
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_PO.CANCEL_PO",
                        new string[] { "A_CANCEL_ALL", "A_USER", "A_PO_ID" }, "A_DATA",
                        new string[] { isCancelAll, Consts.USER_INFO.Id, PO_ID }, SP_MRP_PR_PO_TYPE);

                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                        this.Close();
                    }
                    else
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
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
