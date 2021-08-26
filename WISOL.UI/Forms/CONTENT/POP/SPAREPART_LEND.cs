using DevExpress.XtraGrid.Views.Grid;
using System;
using System.Data;
using System.Drawing;
using System.Linq;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;


namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class SPAREPART_LEND : FormType
    {
        public string sparepartCode = string.Empty;
        public static string PAY_CODE { get; set; }

        public SPAREPART_LEND()
        {
            InitializeComponent();
            this.Load += SPAREPART_LEND_Load;
        }

        private void SPAREPART_LEND_Load(object sender, EventArgs e)
        {
            GetData();
        }

        private void GetData()
        {
            try
            {
                if (sparepartCode == string.Empty)
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_SPARE_PART_PAY", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                }
                else
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_SPARE_PART_PAY_BY_CODE", new string[] { "A_DEPARTMENT", "A_SPARE_PART_CODE" }, new string[] { Consts.DEPARTMENT, sparepartCode });
                }

                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.mResultDB.ReturnDataSet.Tables;
                    mBindData.BindGridView(gcList, data[0]);

                    gvList.Columns["ID"].Visible = false;
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

        private void btnSave_Click(object sender, EventArgs e)
        {
            int[] lstSelected = gvList.GetSelectedRows();

            if (lstSelected.Length > 0)
            {
                PAY_CODE = gvList.GetRowCellValue(lstSelected[0], "LEND_CODE").NullString();
            }

            this.Close();
        }

        private void gvList_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            if (e.Column.FieldName == "DATE_PAY")
            {
                string isPay = gvList.GetRowCellValue(e.RowHandle, "IS_PAY").NullString();

                if (gvList.GetRowCellValue(e.RowHandle, "DATE_PAY").NullString() != string.Empty)
                {
                    if (isPay == "False")
                    {
                        DateTime datePay = DateTime.Parse(gvList.GetRowCellValue(e.RowHandle, "DATE_PAY").NullString());
                        if (datePay.ToString("yyyyMMdd") == DateTime.Now.ToString("yyyyMMdd"))
                        {
                            e.Appearance.BackColor = Color.FromArgb(255, 204, 204);
                        }
                        else if (datePay.AddDays(-1).ToString("yyyyMMdd") == DateTime.Now.ToString("yyyyMMdd"))
                        {
                            e.Appearance.BackColor = Color.FromArgb(255, 229, 204);
                        }
                        else
                        {
                            e.Appearance.BackColor = Color.FromArgb(50, 205, 50);
                        }
                    }
                    else
                    {
                        e.Appearance.BackColor = Color.FromArgb(192, 192, 192);
                    }
                }
            }
        }
    }
}
