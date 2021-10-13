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
    public partial class SAP_PO_ADD : FormType
    {
        public string PO_ID { get; set; }
        public string PR_LIST { get; set; }

        public SAP_PO_ADD()
        {
            InitializeComponent();
            this.Load += SAP_PO_ADD_Load;
        }

        private void SAP_PO_ADD_Load(object sender, EventArgs e)
        {
            InitData();
        }

        private void InitData()
        {
            try
            {
                txtPO_SYS.EditValue = PO_ID;

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SAP_PO.INIT", new string[] { "A_PR_LIST" }, new string[] { PR_LIST });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    mBindData.BindGridView(gcList, data);
                    //gcList.DataSource = data;
                    mBindData.BindGridLookEdit(stlVendor, data, "VENDER_ID", "NAME", "SAP_PO");

                    //gvList.OptionsSelection.MultiSelect = true;
                    //gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                    //gvList.OptionsBehavior.Editable = true;
                    //gvList.Columns["VENDER_ID"].OptionsColumn.AllowEdit = false;
                    //gvList.Columns["NAME"].OptionsColumn.AllowEdit = false;
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
            try
            {
                if (txtPO_SYS.EditValue.NullString() == "" || txtSapPO.EditValue.NullString() == "" || stlVendor.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SAP_PO.PUT",
                    new string[] { "A_VENDOR_ID", "A_PO_ID", "A_SAP_PO_ID", "A_USER" },
                    new string[] { stlVendor.EditValue.NullString(), txtPO_SYS.EditValue.NullString(), txtSapPO.EditValue.NullString(), txtUser.EditValue.NullString() });

                if (base.mResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Information);
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

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                txtSapPO.EditValue = gvList.GetRowCellValue(e.RowHandle, "SAP_PO").NullString();
                stlVendor.EditValue = gvList.GetRowCellValue(e.RowHandle, "VENDER_ID").NullString();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void stlVendor_EditValueChanged(object sender, EventArgs e)
        {
            //gvList.ActiveFilterString = "[VENDER_ID] = '" + stlVendor.EditValue.NullString() + "'";
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            txtSapPO.EditValue = "";
            stlVendor.EditValue = "";
            txtUser.EditValue = "";
        }

        private void gvList_RowCellStyle(object sender, RowCellStyleEventArgs e)
        {
            if (e.RowHandle < 0) 
                return;

            if(e.Column.FieldName == "SAP_PO")
            {
                if(e.CellValue.NullString() != "")
                {
                    e.Appearance.BackColor = Color.FromArgb(125, 206, 160);
                }
                else
                {
                    e.Appearance.BackColor = Color.FromArgb(242, 243, 244);
                }
            }
        }
    }
}
