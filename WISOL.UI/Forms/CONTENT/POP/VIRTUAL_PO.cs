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
    public partial class VIRTUAL_PO : FormType
    {
        public string Mode;
        public VIRTUAL_PO()
        {
            InitializeComponent();
        }

        private DataTable DATA;

        private void VIRTUAL_PO_Load(object sender, EventArgs e)
        {
            try
            {
                DATA = new DataTable();
                DATA.Columns.Add("TITLE");
                DATA.Columns.Add("SPAREPART_CODE");
                DATA.Columns.Add("NAME_VI");
                DATA.Columns.Add("UNIT");
                DATA.Columns.Add("QUANTITY_NEED_BUY");
                DATA.Columns.Add("VENDOR");
                DATA.Columns.Add("PRICE_VN");
                DATA.Columns.Add("PRICE_US");
                gcList.DataSource = DATA;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_VIRTUAL_PO.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = mResultDB.ReturnDataSet.Tables;
                    if (datas.Count > 0)
                    {
                        mBindData.BindGridLookEdit(stlSparepart, datas[1], "CODE", "NAME_VI");
                        mBindData.BindGridLookEdit(stlVendor, datas[2], "VENDER_ID", "NAME");
                    }
                }

                Classes.Common.SetFormIdToButton(null, "VIRTUAL_PO", this);
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
                if(Mode != Consts.MODE_NEW)
                {
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_VIRTUAL_PO.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = mResultDB.ReturnDataSet.Tables;

                    if (datas.Count > 0)
                    {
                        txtMrp.Text = datas[0].Rows[0]["MRP"].NullString();
                        txtPRNumber.Text = datas[0].Rows[0]["PRCODE"].NullString();
                        txtPoNumber.Text = datas[0].Rows[0]["POCODE"].NullString();
                    }
                    else
                    {
                        txtMrp.Text = "";
                        txtPRNumber.Text = "";
                        txtPoNumber.Text = "";
                    }
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

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepart.EditValue.NullString(), stlUnit, mBindData);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlSparepart.EditValue.NullString() == "" || txtQuantity.EditValue.NullString() == "" ||
                    stlUnit.EditValue.NullString() == "" || stlVendor.EditValue.NullString() == "" ||
                    txtPriceVN.EditValue.NullString() == "" || txtPriceUS.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                gvList.BeginSort();
                bool isExist = false;

                for (int i = 0; i < gvList.RowCount; i++)
                {
                    if (gvList.GetRowCellValue(i, "SPAREPART_CODE").NullString() == stlSparepart.EditValue.NullString())
                    {
                        gvList.SetRowCellValue(i, "TITLE", "VIRTUAL PO");
                        gvList.SetRowCellValue(i, "UNIT", stlUnit.EditValue.NullString());
                        gvList.SetRowCellValue(i, "QUANTITY_NEED_BUY", txtQuantity.EditValue.NullString());
                        gvList.SetRowCellValue(i, "VENDOR", stlVendor.EditValue.NullString());
                        gvList.SetRowCellValue(i, "PRICE_VN", txtPriceVN.EditValue.NullString());
                        gvList.SetRowCellValue(i, "PRICE_US", txtPriceUS.EditValue.NullString());
                        isExist = true;
                        break;
                    }
                }

                if (!isExist)
                {

                    DataRowView newRow = (gvList.DataSource as DataView).AddNew();
                    newRow["TITLE"] = "VIRTUAL PO";
                    newRow["SPAREPART_CODE"] = stlSparepart.EditValue.NullString();
                    newRow["NAME_VI"] = stlSparepart.Text.NullString();
                    newRow["UNIT"] = stlUnit.EditValue.NullString();
                    newRow["QUANTITY_NEED_BUY"] = txtQuantity.EditValue.NullString();
                    newRow["VENDOR"] = stlVendor.EditValue.NullString();
                    newRow["PRICE_VN"] = txtPriceVN.EditValue.NullString();
                    newRow["PRICE_US"] = txtPriceUS.EditValue.NullString();
                }

                gvList.EndSort();
                btnClear.PerformClick();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            stlSparepart.EditValue = "";
            stlUnit.EditValue = "";
            txtQuantity.EditValue = "";
            stlVendor.EditValue = "";
            txtPriceVN.EditValue = "";
            txtPriceUS.EditValue = "";
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < gvList.RowCount; i++)
            {
                if (gvList.GetRowCellValue(i, "SPAREPART_CODE").NullString() == stlSparepart.EditValue.NullString())
                {
                    gvList.DeleteRow(i);
                    break;
                }
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0) return;

            stlSparepart.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPAREPART_CODE").NullString();
            stlUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
            txtQuantity.EditValue = gvList.GetRowCellValue(e.RowHandle, "QUANTITY_NEED_BUY").NullString();
            stlVendor.EditValue = gvList.GetRowCellValue(e.RowHandle, "VENDOR").NullString();
            txtPriceVN.EditValue = gvList.GetRowCellValue(e.RowHandle, "PRICE_VN").NullString();
            txtPriceUS.EditValue = gvList.GetRowCellValue(e.RowHandle, "PRICE_US").NullString();
        }

        private void btnSaveALL_Click(object sender, EventArgs e)
        {
            try
            {
                if (Mode == Consts.MODE_NEW)
                {
                    btnCreateCode.PerformClick();
                }

                if (txtPoNumber.Text.NullString() == "" || txtPRNumber.Text.NullString() == "" || txtMrp.Text.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                DataTable data = Wisol.MES.Classes.Common.GetDataTable(gvList, new string[] { });

                base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_VIRTUAL_PO.PUT",
                    new string[] { "A_DEPARTMENT", "A_PO_ID", "A_PR_ID", "A_MRP_ID", "A_USER", "A_DELETE" }, "A_DATA",
                    new string[] { Consts.DEPARTMENT, txtPoNumber.Text.NullString(), txtPRNumber.Text.NullString(), txtMrp.Text.NullString(), Consts.USER_INFO.Id, "False" },
                    data);

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                    this.Close();
                }
                else
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDeletePO_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable data = Wisol.MES.Classes.Common.GetDataTable(gvList, new string[] { });
                if (txtPoNumber.Text.NullString() == "" || txtPRNumber.Text.NullString() == "" || txtMrp.Text.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_VIRTUAL_PO.PUT",
                    new string[] { "A_DEPARTMENT", "A_PO_ID", "A_PR_ID", "A_MRP_ID", "A_USER", "A_DELETE" }, "A_DATA",
                    new string[] { Consts.DEPARTMENT, txtPoNumber.Text.NullString(), txtPRNumber.Text.NullString(), txtMrp.Text.NullString(), Consts.USER_INFO.Id, "True" },
                    data);

                if (mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Information);
                    this.Close();
                }
                else
                {
                    MsgBox.Show(base.mResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
