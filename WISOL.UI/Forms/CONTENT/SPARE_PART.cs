using DevExpress.XtraEditors;
using DevExpress.XtraEditors.Controls;
using DevExpress.XtraGrid.Views.Grid;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class SPARE_PART : PageType
    {
        public string code = string.Empty;
        public string image = string.Empty;
        private string b64 = string.Empty;
        //private bool firstLoad = true;
        public SPARE_PART()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            Classes.Common.SetFormIdToButton(this, "SPARE_PART");
            //firstLoad = false;
        }

        public override void ReloadData()
        {
            //if (firstLoad)
            //{
            //    InitializePage();
            //}
            //firstLoad = true;
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

                    base.m_BindData.BindGridLookEdit(stlStage, data[5], "OPERATION_ID", "OPERATION_NAME");

                    cheCboEquipment.Properties.Items.Clear();
                    foreach (DataRow row in data[6].Rows)
                    {
                        cheCboEquipment.Properties.Items.Add(row["MODEL"]);
                    }

                }

                btnUpdate.Enabled = false;
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

                btnUpdate.Enabled = false;
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
                    ShowSparepart(gvList.GetDataRow(e.RowHandle)["CODE"].NullString());
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (txtCode.Text.Trim().IsNullOrEmpty())
            {
                return;
            }

            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.DELETE", new string[] { "A_CODE", "A_DEPARTMENT" }, new string[] { txtCode.Text.Trim(), Consts.DEPARTMENT });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        Wisol.MES.Classes.Common.GetEncriptCode();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
                catch (Exception ex)
                {
                    MsgBox.Show(ex.Message, MsgType.Error);
                }
                finally
                {
                    Init_Control();
                    SearchPage();
                }
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if ((string.IsNullOrEmpty(txtCode.EditValue.NullString()) && !cbGenCode.Checked) ||
                     string.IsNullOrEmpty(txtNameVi.EditValue.NullString()) ||
                     string.IsNullOrEmpty(sltUnit.EditValue.NullString()) ||
                     string.IsNullOrEmpty(sltVender.EditValue.NullString()) ||
                     string.IsNullOrEmpty(sltGlaccount.EditValue.NullString()) ||
                     string.IsNullOrEmpty(sltCostCtr.EditValue.NullString())
                    )
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                //if(sltVender.EditValue.NullString() == "OTHER")
                //{
                //    MsgBox.Show("HÃY CHỌN NHÀ CUNG CẤP PHÙ HỢP!".Translation(), MsgType.Warning);
                //    return;
                //}

                if (string.IsNullOrEmpty(sltSparePartType.EditValue.NullString())) // && cbGenCode.Checked)
                {
                    MsgBox.Show("MSG_ERR_SPARE_TYPE".Translation(), MsgType.Warning);
                    sltSparePartType.Focus();
                    return;
                }

                if (txtCode.EditValue.NullString().Contains(Consts.STR_SPILIT_ON_BARCODE) || txtCode.EditValue.NullString().Contains("_") || txtCode.EditValue.NullString().Contains("."))
                {
                    MsgBox.Show("Mã thiết bị không được chưa ký tự $ _ .".Translation(), MsgType.Warning);
                    return;
                }

                if ((new List<string> { sltUnit.EditValue.NullString(), sltUnit1.EditValue.NullString(), sltUnit2.EditValue.NullString(), sltUnit3.EditValue.NullString(), sltUnit4.EditValue.NullString() }.Contains(Consts.PACK_UNIT) == false))
                {
                    MsgBox.Show("MSG_ERR_MISS_PACK_UNIT".Translation(), MsgType.Warning);
                    return;
                }

                b64 = image;
                string code = cbGenCode.Checked ? GencodeAuto(sltSparePartType.EditValue.NullString()) : txtCode.EditValue.NullString().ToUpper();

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.PUT",
                    new string[]
                    {
                        "@A_CODE",
                        "@A_NAME_VI",
                        "@A_NAME_KR",
                        "@A_CODE_VENDOR",
                        "@A_GL_ACCOUNT",
                        "@A_SP_TYPE",
                        "@A_MATERIAL",
                        "@A_SIZE",
                        "@A_WEIGHT",
                        "@A_USES",
                        "@A_EQUIPMENT",
                        "@A_SPECIFICATION",
                        "@A_UNIT",
                        "@A_DESC", // cong doan
                        "@A_COST_CTR",
                        "@A_DEPARTMENT",
                        "@A_IMAGE",
                        "@USER",
                        "@A_UNIT1",
                        "@A_UNIT2",
                        "@A_UNIT3",
                        "@A_UNIT4",
                        "@A_RATE1",
                        "@A_RATE2",
                        "@A_RATE3",
                        "@A_RATE4",
                        "@A_MIN_ORDER",
                        "@A_LEAD_TIME"
                    },
                    new string[]
                    {
                        code,
                        txtNameVi.EditValue.NullString(),
                        txtNameKr.EditValue.NullString(),
                        sltVender.EditValue.NullString(),
                        sltGlaccount.EditValue.NullString(),
                        sltSparePartType.EditValue.NullString(),
                        txtMaterial.EditValue.NullString(),
                        txtSize.EditValue.NullString(),
                        txtWeight.EditValue.NullString(),
                        txtUses.EditValue.NullString(),
                        txtEquipment.EditValue.NullString(),
                        txtSpecification.EditValue.NullString(),
                        sltUnit.EditValue.NullString(),
                        stlStage.EditValue.NullString(), // cong doan
                        sltCostCtr.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        b64,
                        Consts.USER_INFO.Id,
                        sltUnit1.EditValue.NullString(),
                        sltUnit2.EditValue.NullString(),
                        sltUnit3.EditValue.NullString(),
                        sltUnit4.EditValue.NullString(),

                        txtRate1.EditValue.NullString(),
                        txtRate2.EditValue.NullString(),
                        txtRate3.EditValue.NullString(),
                        txtRate4.EditValue.NullString(),
                        txtMinOrder.EditValue.NullString(),
                        txtLeadTime.EditValue.NullString()
                    }); ;
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    SearchPage();
                    Init_Control();

                    for (int i = 0; i < gvList.DataRowCount; i++)
                    {
                        string sparePartCode = gvList.GetRowCellValue(i, gvList.Columns[0]).NullString();
                        if (sparePartCode == code)
                        {
                            gvList.MakeRowVisible(i);
                            break;
                        }
                    }

                    if (cheCboEquipment.Text.NullString() != "")
                    {
                        //cheCboEquipment.Text
                        DataTable modelTable = new DataTable();
                        modelTable.Columns.Add("SPARE_PART_CODE");
                        modelTable.Columns.Add("MODEL");
                        modelTable.Columns.Add("DEPT_CODE");

                        DataRow row;
                        foreach (var item in cheCboEquipment.Text.Split(','))
                        {
                            if (item.NullString() != "")
                            {
                                row = modelTable.NewRow();
                                row["SPARE_PART_CODE"] = code;
                                row["MODEL"] = item.Trim();
                                row["DEPT_CODE"] = Consts.DEPARTMENT;
                                modelTable.Rows.Add(row);
                            }
                        }

                        base.m_ResultDB = base.m_DBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_SP.PUT_SPAREPART_MODEL_BOM",
                           new string[] { "DEPT_CODE", "A_SPAREPART_CODE" }, "A_DATA",
                           new string[] { Consts.DEPARTMENT, code }, modelTable);

                        if (m_ResultDB.ReturnInt != 0)
                        {
                            MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                        }
                    }

                    Wisol.MES.Classes.Common.GetEncriptCode();
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Init_Control();
        }

        private void picImage_Enter(object sender, EventArgs e)
        {
            PasteImage();
        }

        private void PasteImage()
        {
            System.Drawing.Image returnImage = null;
            if (System.Windows.Clipboard.ContainsImage())
            {
                returnImage = System.Windows.Forms.Clipboard.GetImage();
                byte[] bytes = (byte[])(new ImageConverter()).ConvertTo(returnImage, typeof(byte[]));
                image = Convert.ToBase64String(bytes);
                picImage.Image = System.Windows.Forms.Clipboard.GetImage();
            }
        }

        private void GetData()
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                gvList.Columns.Where(x => x.VisibleIndex <= gvList.Columns["NAME_KR"].VisibleIndex).ToList().ForEach(x => x.Fixed = DevExpress.XtraGrid.Columns.FixedStyle.Left);
                gvList.OptionsSelection.MultiSelect = true;
                gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;
            }
        }

        private void txtSearch_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Mã[상품]" && s != "Tên tiếng việt[Sparepart의 이름]") args.IsSearchColumn = false;
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
            stlStage.EditValue = table.Rows[0]["STAGE"].NullString();
            sltCostCtr.EditValue = table.Rows[0]["COST_CTR"].NullString();
            txtMinOrder.EditValue = table.Rows[0]["MIN_ORDER"].NullString();

            txtLeadTime.EditValue = table.Rows[0]["LEAD_TIME"].NullString().IfNullIsZero();
            txtLeadTimeWeek.EditValue = Math.Round(float.Parse(txtLeadTime.EditValue.IfNullIsZero()) / 7);


            image = table.Rows[0]["IMAGE"].NullString();

            if (!string.IsNullOrWhiteSpace(image))
            {
                try
                {
                    byte[] imagebytes = Convert.FromBase64String(image);
                    using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                    {
                        picImage.Image = Image.FromStream(ms, true);
                    }
                    picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                    picImage.Size = picImage.Image.Size;
                }
                catch (Exception)
                {
                    picImage.Image = null;
                }
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
            txtCode.Enabled = !cbGenCode.Checked;
            txtCode.EditValue = null;
            txtCode.BackColor = !txtCode.Enabled ? Color.FromArgb(224, 224, 224) : Color.White;
        }

        private string GencodeAuto(string type)
        {
            string result = "";
            try
            {
                string s = "";
                if (type == Consts.SPARE_PART_TYPE)
                {
                    s = "SP-";
                }
                else if (type == Consts.CONSUMABLE_PART_TYPE)
                {
                    s = "CP-";
                }
                else
                {
                    s = "OP-";
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_MAX_AUTO_CODE", new string[] { "A_TYPE", "A_DEPARTMENT" }, new string[] { s, Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        string max = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["STT"].NullString();
                        if (int.TryParse(max, out int intMax))
                        {
                            if (intMax == 9999)
                            {
                                MsgBox.Show("MSG_ERR_9999", MsgType.Error);
                                return "";
                            }
                            else
                            {
                                result = s + (CreateNumberCode(intMax + 1));
                            }
                        }
                    }
                    else
                    {
                        result = s + "0001";
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            return result;
        }

        private string CreateNumberCode(int number)
        {
            if (number <= 9) return "000" + number;
            if (number > 9 && number <= 99) return "00" + number;
            if (number > 99 && number <= 999) return "0" + number;
            if (number > 999 && number <= 9999) return "" + number;
            return "";
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            POP.UPDATE_SPAREPART_CODE popup = new POP.UPDATE_SPAREPART_CODE();
            popup.SpareCode_Old = txtCode.EditValue.NullString();
            popup.ShowDialog();

            Init_Control();
            SearchPage();
            Wisol.MES.Classes.Common.GetEncriptCode();
        }

        private void txtCode_EditValueChanged(object sender, EventArgs e)
        {
            if (txtCode.EditValue.NullString() != "")
            {
                btnUpdate.Enabled = true;
            }
            else
            {
                btnUpdate.Enabled = false;
            }
        }

        private void txtSearch_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (e.KeyCode == Keys.Enter)
                {
                    ShowSparepart(txtSearch.EditValue.NullString());
                    txtSearch.EditValue = null;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }

        }

        private void ShowSparepart(string code)
        {
            if (!string.IsNullOrEmpty(code) && code.Contains(Consts.STR_SPILIT_ON_BARCODE))
            {
                code = code.Split(Consts.CHARACTER_SPILIT_ON_BARCODE)[0];
            }

            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.SHOW", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { Consts.DEPARTMENT, code });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                {
                    DataTableCollection tableCollection = base.m_ResultDB.ReturnDataSet.Tables;
                    txtCode.Enabled = false;
                    cbGenCode.Checked = false;
                    cbGenCode.Enabled = false;

                    ShowASparepart(tableCollection[0], tableCollection[1]);
                    int i = -1;
                    foreach (CheckedListBoxItem item in cheCboEquipment.Properties.Items)
                    {
                        item.CheckState = CheckState.Unchecked;
                    }

                    foreach (DataRow row in tableCollection[2].Rows)
                    {
                        i = cheCboEquipment.Properties.Items.IndexOf(row["MODEL"].NullString());
                        if (i >= 0)
                        {
                            cheCboEquipment.Properties.Items[i].CheckState = CheckState.Checked;
                            i = -1;
                        }
                    }
                }
            }
        }

        private void txtCode_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (e.KeyCode == Keys.Enter)
                {
                    ShowSparepart(txtCode.EditValue.NullString());
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnMemoryData_Click(object sender, EventArgs e)
        {
            try
            {
                DataRow row;
                string code = "";
                foreach (int i in gvList.GetSelectedRows())
                {
                    code = gvList.GetRowCellValue(i, "CODE").NullString();

                    if (Consts.GetDataMemory().Select("[CODE] = '" + code + "'").Length == 0)
                    {
                        row = Consts.GetDataMemory().NewRow();
                        row["CODE"] = gvList.GetRowCellValue(i, "CODE");
                        row["NAME_VI"] = gvList.GetRowCellValue(i, "NAME_VI");
                        Consts.GetDataMemory().Rows.Add(row);
                    }
                }
                m_BindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");
                MsgBox.Show("MSG_COM_004".Translation(), MsgType.Information);
                gvList.ClearSelection();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void bntClearMemory_Click(object sender, EventArgs e)
        {
            try
            {
                Consts.GetDataMemory().Rows.Clear();
                m_BindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");
                gvList.ClearSelection();
                MsgBox.Show("MSG_COM_004".Translation(), MsgType.Information);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
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

        private void btnReferCode_Click(object sender, EventArgs e)
        {
            try
            {
                Consts.mainForm.NewPageFromOtherPage("SPARE_PART_EX", "Tổng hợp mã thiết bị", "W", "Y", "");
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnAddVendor_Click(object sender, EventArgs e)
        {
            POP.VENDOR pop = new POP.VENDOR();
            pop.ShowDialog();

            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_VENDOR.GET", new string[] { }, new string[] { });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                DataTableCollection data = base.m_ResultDB.ReturnDataSet.Tables;
                base.m_BindData.BindGridLookEdit(sltVender, data[0], "VENDER_ID", "NAME");
            }
        }

        private void btnOutExcel_Click(object sender, EventArgs e)
        {
            try
            {
                splashScreenManager1.ShowWaitForm();
                Consts.mainForm.NewPageFromOtherPage("SPARE_PART_EXPORT", "Dữ liệu thiết bị", "W", "Y", "");
                splashScreenManager1.CloseWaitForm();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDocument_Click(object sender, EventArgs e)
        {
            if (txtCode.EditValue.NullString() == "")
            {
                MsgBox.Show("INPUT SPAREPART CODE !!!", MsgType.Warning);
                return;
            }

            POP.DOCUMENT_FORM pop = new POP.DOCUMENT_FORM();
            pop.SparepartCode = txtCode.EditValue.NullString();
            pop.ShowDialog();
        }
    }
}
