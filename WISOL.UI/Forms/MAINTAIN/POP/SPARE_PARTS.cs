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

namespace Wisol.MES.Forms.MAINTAIN.POP
{
    public partial class SPARE_PARTS : FormType
    {
        public DataTable DATA;
        public SPARE_PARTS()
        {
            InitializeComponent();
            this.Load += SPARE_PARTS_Load;
        }

        private void SPARE_PARTS_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "SPARE_PARTS", this);

            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET",
                    new string[] { "A_DEPARTMENT" },
                    new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    mBindData.BindGridView(gcList, data, false, "CODE_MERGED,UNIT");
                    gvList.OptionsView.ColumnAutoWidth = true;
                    gvList.OptionsSelection.MultiSelect = true;
                    gvList.OptionsSelection.MultiSelectMode = DevExpress.XtraGrid.Views.Grid.GridMultiSelectMode.CheckBoxRowSelect;
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                }

                if (DATA != null)
                {
                    for (int i = 0; i < gvList.RowCount; i++)
                    {
                        foreach (DataRow item in DATA.Rows)
                        {
                            if(item["CODE"].NullString() == gvList.GetRowCellValue(i, "CODE").NullString())
                            {
                                gvList.SelectRow(i);
                            }
                        }
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
                if (DATA == null)
                {
                    DATA = new DataTable();
                    DATA.Columns.Add("CODE");
                    DATA.Columns.Add("NAME_VI");
                }
                else
                {
                    DATA.Rows.Clear();
                }

                foreach (int index in gvList.GetSelectedRows())
                {
                    DataRow row = DATA.NewRow();
                    row["CODE"] = gvList.GetRowCellValue(index, "CODE").NullString();
                    row["NAME_VI"] = gvList.GetRowCellValue(index, "NAME_VI").NullString();
                    DATA.Rows.Add(row);
                }

                this.Close();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            try
            {
                this.Close();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
