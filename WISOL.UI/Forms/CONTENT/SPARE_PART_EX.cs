using DevExpress.XtraEditors;
using DevExpress.XtraGrid.Views.Grid;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class SPARE_PART_EX : PageType
    {
        public string code = string.Empty;
        public string image = string.Empty;
        private string b64 = string.Empty;
        //private bool firstLoad = true;
        public SPARE_PART_EX()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            //firstLoad = false;
        }

        public override void ReloadData()
        {

        }

        public override void InitializePage()
        {
            try
            {
                // get list spare part
                GetData();

                // Init combobox data
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.INIT_PUT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                    base.m_BindData.BindGridLookEdit(sltVender, data[0], "VENDER_ID", "NAME");
                    base.m_BindData.BindGridLookEdit(sltUnit, data[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(sltCostCtr, data[2], "COST_CTR", "COST_CTR");
                    base.m_BindData.BindGridLookEdit(sltGlaccount, data[3], "GL_ACCOUNT", "GL_ACCOUNT");
                    base.m_BindData.BindGridLookEdit(sltSparePartType, data[4], "CODE", "NAME");

                    base.m_BindData.BindGridLookEdit(sltUnit1, data[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(sltUnit2, data[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(sltUnit3, data[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(sltUnit4, data[1], "CODE", "NAME");
                }

                sltUnit1.EditValue = Consts.PACK_UNIT;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void Init_Control()
        {
            try
            {
                txtCode.EditValue = string.Empty;
                txtNameKr.EditValue = string.Empty;
                txtNameVi.EditValue = string.Empty;
                sltCostCtr.EditValue = string.Empty;
                sltVender.EditValue = string.Empty;
                sltGlaccount.EditValue = string.Empty;
                sltSparePartType.EditValue = string.Empty;
                txtMaterial.EditValue = string.Empty;
                txtSize.EditValue = string.Empty;
                txtWeight.EditValue = string.Empty;
                txtUses.EditValue = string.Empty;
                txtEquipment.EditValue = string.Empty;
                txtSpecification.EditValue = string.Empty;
                //txtDesc.EditValue = string.Empty;
                sltUnit.EditValue = string.Empty;
                cbGenCode.Checked = false;
                cbGenCode.Enabled = true;
                sltUnit1.EditValue = Consts.PACK_UNIT;
                sltUnit2.EditValue = string.Empty;
                sltUnit3.EditValue = string.Empty;
                sltUnit4.EditValue = string.Empty;

                txtRate1.EditValue = 1;
                txtRate2.EditValue = 1;
                txtRate3.EditValue = 1;
                txtRate4.EditValue = 1;

                txtMinOrder.EditValue = 0;
                txtLeadTime.EditValue = 0;
                txtLeadTimeWeek.EditValue = 0;

                picImage.Image = null;
                txtCode.Enabled = true;
                txtCode.ResetBackColor();
                txtCode.Focus();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public override void SearchPage()
        {
            try
            {
                GetData();
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
                {
                    return;
                }
                else
                {
                    ShowSparepart(gvList.GetDataRow(e.RowHandle)["CODE"].NullString(), e.RowHandle);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void GetData()
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_EX", new string[] { }, new string[] { });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                gvList.Columns["DEPT_CODE"].Visible = false;
                gvList.OptionsSelection.MultiSelect = true;
                gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;
            }
        }

        private void picImage_ImageChanged(object sender, EventArgs e)
        {
            try
            {
                b64 = Convert.ToBase64String(ImageToByte(picImage.Image));
                image = b64;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public static byte[] ImageToByte(Image img)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(img, typeof(byte[]));
        }

        private void ShowASparepart(DataTable table, DataTable unitTable)
        {
            txtCode.EditValue = table.Rows[0]["CODE"].NullString();
            txtNameVi.EditValue = table.Rows[0]["NAME_VI"].NullString();
            txtNameKr.EditValue = table.Rows[0]["NAME_KR"].NullString();
            sltVender.EditValue = table.Rows[0]["VENDER_ID"].NullString();
            sltGlaccount.EditValue = table.Rows[0]["GL_ACCOUNT"].NullString();
            sltSparePartType.EditValue = table.Rows[0]["TYPE"].NullString();
            txtMaterial.EditValue = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["MATERIAL"].NullString();
            txtSize.EditValue = table.Rows[0]["SIZE"].NullString();
            txtWeight.EditValue = table.Rows[0]["WEIGHT"].NullString();
            txtUses.EditValue = table.Rows[0]["USES"].NullString();
            txtEquipment.EditValue = table.Rows[0]["EQUIPMENT_USED"].NullString();
            txtSpecification.EditValue = table.Rows[0]["SPECIFICATION"].NullString();
            sltUnit.EditValue = table.Rows[0]["UNIT_ID"].NullString();
            //txtDesc.EditValue = table.Rows[0]["DESCRIPTION"].NullString();
            sltCostCtr.EditValue = table.Rows[0]["COST_CTR"].NullString();
            txtMinOrder.EditValue = table.Rows[0]["MIN_ORDER"].NullString();

            txtLeadTime.EditValue = table.Rows[0]["LEAD_TIME"].NullString().IfNullIsZero();
            txtLeadTimeWeek.EditValue = Math.Round(float.Parse(txtLeadTime.EditValue.IfNullIsZero()) / 7);


            image = table.Rows[0]["IMAGE"].NullString();

            if (!string.IsNullOrWhiteSpace(image))
            {
                byte[] imagebytes = Convert.FromBase64String(image);
                using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                {
                    picImage.Image = Image.FromStream(ms, true);
                }
                picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                picImage.Size = picImage.Image.Size;
            }
            else
            {
                picImage.Image = null;
            }

            // show unit 
            sltUnit1.EditValue = null;
            txtRate1.EditValue = 1;

            sltUnit2.EditValue = null;
            txtRate2.EditValue = 1;

            sltUnit3.EditValue = null;
            txtRate3.EditValue = 1;

            sltUnit4.EditValue = null;
            txtRate4.EditValue = 1;

            for (int i = 0; i < unitTable.Rows.Count; i++)
            {
                switch (i)
                {
                    case 0:
                        sltUnit1.EditValue = unitTable.Rows[i]["UNIT_CODE"].NullString();
                        txtRate1.EditValue = unitTable.Rows[i]["RATE"].NullString();
                        break;
                    case 1:
                        sltUnit2.EditValue = unitTable.Rows[i]["UNIT_CODE"].NullString();
                        txtRate2.EditValue = unitTable.Rows[i]["RATE"].NullString();
                        break;
                    case 2:
                        sltUnit3.EditValue = unitTable.Rows[i]["UNIT_CODE"].NullString();
                        txtRate3.EditValue = unitTable.Rows[i]["RATE"].NullString();
                        break;
                    case 3:
                        sltUnit4.EditValue = unitTable.Rows[i]["UNIT_CODE"].NullString();
                        txtRate4.EditValue = unitTable.Rows[i]["RATE"].NullString();
                        break;
                }
            }
        }

        private void txtCode_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                // Enter key pressed

                try
                {
                    if (txtCode.Text.Trim().IsNullOrEmpty())
                    {
                        return;
                    }

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.ONLY_SHOW_SPAREPART", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { Consts.DEPARTMENT, txtCode.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                        {
                            ShowASparepart(base.m_ResultDB.ReturnDataSet.Tables[0], base.m_ResultDB.ReturnDataSet.Tables[1]);
                        }
                        else
                        {
                            txtNameVi.Focus();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
            }
        }

        private void cbGenCode_CheckedChanged(object sender, EventArgs e)
        {
            //txtCode.Enabled = !cbGenCode.Checked;
            txtCode.EditValue = null;
            txtCode.BackColor = !txtCode.Enabled ? Color.FromArgb(224, 224, 224) : Color.White;
        }

        private void txtCode_EditValueChanged(object sender, EventArgs e)
        {
        }

        private void ShowSparepart(string code,int rowHandle)
        {
            if (!string.IsNullOrEmpty(code) && code.Contains(Consts.STR_SPILIT_ON_BARCODE))
            {
                code = code.Split(Consts.CHARACTER_SPILIT_ON_BARCODE)[0];
            }

            string deppt = gvList.GetRowCellValue(rowHandle, "DEPT_CODE").NullString();

            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.SHOW", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { deppt, code });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                {
                    //txtCode.Enabled = false;
                    cbGenCode.Checked = false;
                    cbGenCode.Enabled = false;

                    ShowASparepart(base.m_ResultDB.ReturnDataSet.Tables[0], base.m_ResultDB.ReturnDataSet.Tables[1]);
                }
            }
        }

        private void txtCode_KeyDown(object sender, KeyEventArgs e)
        {
        }

        private void cheLeadTimeDay_CheckedChanged(object sender, EventArgs e)
        {
            if (cheLeadTimeDay.Checked)
            {
                txtLeadTime.Enabled = true;
                txtLeadTimeWeek.Enabled = false;
                cheLeadTimeWeek.Checked = false;
            }
            else
            {
                txtLeadTime.Enabled = false;
                txtLeadTimeWeek.Enabled = true;
                cheLeadTimeWeek.Checked = true;
            }
        }

        private void cheLeadTimeWeek_CheckedChanged(object sender, EventArgs e)
        {
            cheLeadTimeDay.Checked = !cheLeadTimeWeek.Checked;
        }

        private void txtLeadTimeWeek_EditValueChanged(object sender, EventArgs e)
        {
            if (cheLeadTimeWeek.Checked)
            {
                txtLeadTime.EditValue = Math.Round(float.Parse(txtLeadTimeWeek.EditValue.NullString()) * 7);
            }
        }

        private void txtLeadTime_EditValueChanged(object sender, EventArgs e)
        {
            if (cheLeadTimeDay.Checked)
            {
                txtLeadTimeWeek.EditValue = Math.Round(float.Parse(txtLeadTime.EditValue.NullString()) / 7);
            }
        }
    }
}
