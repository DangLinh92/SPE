using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Views.Grid.ViewInfo;
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
        public string Model;
        public DataTable DATA;
        public DataTable DATA_MODEL;
        public SPARE_PARTS()
        {
            InitializeComponent();
            this.Load += SPARE_PARTS_Load;
        }

        private void SPARE_PARTS_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(null, "SPARE_PARTS", this);
            txtModels.EditValue = Model;
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
                            if (item["CODE"].NullString() == gvList.GetRowCellValue(i, "CODE").NullString())
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

                if (txtModels.EditValue.NullString() != "")
                {
                    if (DATA_MODEL == null)
                    {
                        DATA_MODEL = new DataTable();
                        DATA_MODEL.Columns.Add("SPARE_PART_CODE");
                        DATA_MODEL.Columns.Add("MODEL");
                        DATA_MODEL.Columns.Add("DEPT_CODE");
                    }
                    else
                    {
                        DATA_MODEL.Rows.Clear();
                    }
                }

                //else
                //{
                //    DATA.Rows.Clear();
                //}

                gvList.ClearColumnsFilter();

                //foreach (int index in gvList.GetSelectedRows())
                //{
                //    DataRow row = DATA.NewRow();
                //    row["CODE"] = gvList.GetRowCellValue(index, "CODE").NullString();
                //    row["NAME_VI"] = gvList.GetRowCellValue(index, "NAME_VI").NullString();
                //    DATA.Rows.Add(row);
                //}

                for (int i = 0; i < gvList.RowCount; i++)
                {
                    foreach (DataRow item in DATA.Rows)
                    {
                        if (item["CODE"].NullString() == gvList.GetRowCellValue(i, "CODE").NullString())
                        {
                            gvList.SelectRow(i);
                        }
                    }
                }

                if (txtModels.EditValue.NullString() != "")
                {
                    DataRow newRow;
                    foreach (DataRow item in DATA.Rows)
                    {
                        newRow = DATA_MODEL.NewRow();
                        newRow["SPARE_PART_CODE"] = item["CODE"].NullString();
                        newRow["MODEL"] = txtModels.EditValue.NullString();
                        newRow["DEPT_CODE"] = Consts.DEPARTMENT;
                        DATA_MODEL.Rows.Add(newRow);
                    }

                    base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_SP.PUT_MODEL_BOM",
                    new string[] { "MODEL", "DEPT_CODE" }, "A_DATA", new string[] { txtModels.EditValue.NullString(), Consts.DEPARTMENT }, DATA_MODEL);

                    if (mResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
                    }
                    else
                    {
                        MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Error);
                        return;
                    }
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

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (gvList.IsRowSelected(e.RowHandle))
            {
                e.Appearance.BackColor = Color.FromArgb(125, 206, 160);
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                if (e.Column.Caption == "Selection")
                {
                    string Ischecked = e.CellValue.NullString();

                    if (DATA == null)
                    {
                        DATA = new DataTable();
                        DATA.Columns.Add("CODE");
                        DATA.Columns.Add("NAME_VI");
                    }

                    if (Ischecked == "True")
                    {
                        DataRow row = DATA.NewRow();
                        row["CODE"] = gvList.GetRowCellValue(e.RowHandle, "CODE").NullString();
                        row["NAME_VI"] = gvList.GetRowCellValue(e.RowHandle, "NAME_VI").NullString();
                        DATA.Rows.Add(row);
                    }
                    else
                    {
                        DataRow row = gvList.GetDataRow(e.RowHandle);
                        foreach (DataRow item in DATA.Rows)
                        {
                            if (item["CODE"].NullString() == row["CODE"].NullString())
                            {
                                DATA.Rows.Remove(item);
                                break;
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

        bool isSelectAll = false;
        private void gvList_MouseDown(object sender, MouseEventArgs e)
        {
            GridHitInfo info = gvList.CalcHitInfo(e.Location);
            Console.WriteLine(info.HitTest);
            if (info.Column != null && info.HitTest == GridHitTest.Column && info.Column.FieldName == DevExpress.XtraGrid.Views.Grid.GridView.CheckBoxSelectorColumnName)
            {
                isSelectAll = true;
            }
        }

        private void gvList_SelectionChanged(object sender, DevExpress.Data.SelectionChangedEventArgs e)
        {
            int controllerRow = e.ControllerRow;
            if (controllerRow == GridControl.InvalidRowHandle && isSelectAll)
            {
                if (gvList.GetSelectedRows().Length == 0)
                {
                    DATA.Rows.Clear();
                    return;
                }

                string code = "";
                bool isOke = false;
                foreach (int i in gvList.GetSelectedRows())
                {
                    code = gvList.GetRowCellValue(i, "CODE").NullString();
                    foreach (DataRow item in DATA.Rows)
                    {
                        if (item["CODE"].NullString() == code)
                        {
                            isOke = true;
                            break;
                        }
                    }

                    if (!isOke)
                    {
                        DataRow slRow = gvList.GetDataRow(i);
                        DataRow row = DATA.NewRow();
                        row["CODE"] = slRow["CODE"];
                        row["NAME_VI"] = slRow["NAME_VI"];
                        DATA.Rows.Add(row);
                    }
                }

                isSelectAll = false;
            }
        }
    }
}
