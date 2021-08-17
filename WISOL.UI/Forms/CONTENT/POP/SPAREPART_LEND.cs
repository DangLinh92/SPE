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
    public partial class SPAREPART_LEND : FormType
    {
        public string sparepartCode = "";
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
                if (sparepartCode == "")
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_SPARE_PART_PAY", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                }
                else
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_SPARE_PART_PAY_BY_CODE", new string[] { "A_DEPARTMENT", "A_SPARE_PART_CODE" }, new string[] { Consts.DEPARTMENT,sparepartCode });
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
            int[] lstSelected  = gvList.GetSelectedRows();

            if(lstSelected.Length > 0)
            {
                PAY_CODE = gvList.GetRowCellValue(lstSelected[0], "LEND_CODE").NullString();
            }

            this.Close();
        }
    }
}
