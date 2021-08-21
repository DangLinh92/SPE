using DevExpress.Spreadsheet;
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

namespace Wisol.MES.Forms.CONTENT
{
    public partial class PO_EXPORT : PageType
    {
        public PO_EXPORT()
        {
            InitializeComponent();
            this.Load += PO_EXPORT_Load;
        }

        private string PR_LIST;
        private string PO_CODE_TEMP;
        private string PO_ID;
        private string Mode;
        private DataTable PO_DETAIL_TYPE = new DataTable();

        private void PO_EXPORT_Load(object sender, EventArgs e)
        {
            PR_LIST = MainID.NullString().Split('$')[0];
            PO_CODE_TEMP = MainID.NullString().Split('$')[1];
            PO_ID = MainID.NullString().Split('$')[2];
            Mode = MainID.NullString().Split('$')[3];

            cboCurrentce.SetEditValue("USD");
            txtPO_Example.EditValue = PO_CODE_TEMP;
            txtPO_ID.EditValue = PO_ID;

            PO_DETAIL_TYPE.Columns.Add("PO_ID");
            PO_DETAIL_TYPE.Columns.Add("PO_ID_TEMP");
            PO_DETAIL_TYPE.Columns.Add("PO_CREATE");
            PO_DETAIL_TYPE.Columns.Add("LIFNR");
            PO_DETAIL_TYPE.Columns.Add("PR_CODE");
            PO_DETAIL_TYPE.Columns.Add("KUNNR");
            PO_DETAIL_TYPE.Columns.Add("BKGRP");
            PO_DETAIL_TYPE.Columns.Add("PSTYP");
            PO_DETAIL_TYPE.Columns.Add("SPARE_PART_CODE");
            PO_DETAIL_TYPE.Columns.Add("TXZ01_DESCRIPTION");
            PO_DETAIL_TYPE.Columns.Add("WERKS");
            PO_DETAIL_TYPE.Columns.Add("LGORT");
            PO_DETAIL_TYPE.Columns.Add("LGORT_STOREAGE_LOCATION");
            PO_DETAIL_TYPE.Columns.Add("PO_QTY");
            PO_DETAIL_TYPE.Columns.Add("UNIT");
            PO_DETAIL_TYPE.Columns.Add("NETPR_PRICE");
            PO_DETAIL_TYPE.Columns.Add("PER");
            PO_DETAIL_TYPE.Columns.Add("WAERS");
            PO_DETAIL_TYPE.Columns.Add("MWSKZ");
            PO_DETAIL_TYPE.Columns.Add("EINDT_DELIVERY_DATE");
            PO_DETAIL_TYPE.Columns.Add("KNTTP");
            PO_DETAIL_TYPE.Columns.Add("MATKL");
            PO_DETAIL_TYPE.Columns.Add("POSID");
            PO_DETAIL_TYPE.Columns.Add("SAKNR_GL_ACCOUNT");
            PO_DETAIL_TYPE.Columns.Add("KOSTL_COST_CENTER");
            PO_DETAIL_TYPE.Columns.Add("DEPT_CODE");

            if(Mode == Consts.MODE_VIEW)
            {
                btnLoadFile.Enabled = false;
                btnSave.Enabled = false;
                LoadTemplate();
            }
            else if(Mode == Consts.MODE_UPDATE)
            {
                btnSave.Enabled = false;
            }
        }

        private void btnLoadFile_Click(object sender, EventArgs e)
        {
            try
            {
                if (cboCurrentce.Text.NullString() == "")
                {
                    MsgBox.Show("HÃY CHỌN ĐƠN VỊ TIỀN TỆ", MsgType.Warning);
                    return;
                }

                if (cboCurrentce.Text.NullString().Contains(","))
                {
                    MsgBox.Show("HÃY CHỌN 1 ĐƠN VỊ TIỀN TỆ USD HOẶC VND", MsgType.Warning);
                    return;
                }

                LoadTemplate();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void LoadTemplate()
        {
            try
            {
                IWorkbook workbook = spreadsheet_PO.Document;
                workbook.BeginUpdate();

                workbook.LoadDocument("OpenPOMigration(WHC).xlsx");
                Worksheet sheet1 = workbook.Worksheets[0];

                if(Mode == Consts.MODE_NEW)
                {
                    GetDataForPO(sheet1);
                }
                else if(Mode == Consts.MODE_VIEW || Mode == Consts.MODE_UPDATE)
                {
                    GetDataForPOByID(sheet1);

                    if(Mode == Consts.MODE_UPDATE)
                    {
                        btnSave.Enabled = true;
                    }
                }
               
                workbook.EndUpdate();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private DataTable PR_SP_DEPT;
        private void GetDataForPO(Worksheet sheet)
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PR.GET_DATA_PO_FILE_NEW", new string[] { "A_WARES", "A_PR_LIST" }, new string[] { cboCurrentce.Text, PR_LIST });
            if (m_ResultDB.ReturnInt == 0)
            {
                DataTableCollection tableCollection = base.m_ResultDB.ReturnDataSet.Tables;
                DataTable data = tableCollection[0];
                for (int i = 0; i < data.Rows.Count; i++)
                {
                    if (i > 0)
                    {
                        sheet.Rows[i + 3].CopyFrom(sheet.Rows[3], PasteSpecial.Formats);
                    }
                }
                sheet.DataBindings.BindToDataSource(data, 3, 0);

                PR_SP_DEPT = tableCollection[1];
            }
            else
            {
                MsgBox.Show(m_ResultDB.ReturnString, MsgType.Error);
            }
        }

        private void GetDataForPOByID(Worksheet sheet)
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_PO.GET_DETAIL_PO", new string[] { "A_PO_ID" }, new string[] { txtPO_ID.EditValue.NullString() });
            if (m_ResultDB.ReturnInt == 0)
            {
                DataTableCollection tableCollection = base.m_ResultDB.ReturnDataSet.Tables;
                DataTable data = tableCollection[0];
                for (int i = 0; i < data.Rows.Count; i++)
                {
                    if (i > 0)
                    {
                        sheet.Rows[i + 3].CopyFrom(sheet.Rows[3], PasteSpecial.Formats);
                    }
                }

                sheet.DataBindings.BindToDataSource(data, 3, 0);
                PR_SP_DEPT = tableCollection[1];
            }
            else
            {
                MsgBox.Show(m_ResultDB.ReturnString, MsgType.Error);
            }
        }

        private void btnCreateExcel_Click(object sender, EventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog1 = new SaveFileDialog();

                saveFileDialog1.Filter = "exel files (*.xlsx)|*.xlsx";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;

                if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    string fileName = saveFileDialog1.FileName;

                    // Save the modified document to a file.
                    IWorkbook workbook = spreadsheet_PO.Document;
                    workbook.SaveDocument(fileName, DocumentFormat.Xlsx);

                    if(Mode == Consts.MODE_NEW || Mode == Consts.MODE_UPDATE)
                    {
                        // save data
                        SavePO();
                    }
                    else if(Mode == Consts.MODE_VIEW)
                    {
                        MsgBox.Show("TẠO FILE THÀNH CÔNG!!!", MsgType.Information);
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
            if(txtPO_ID.EditValue.NullString() != "")
            {
                SavePO();
            }
            else
            {
                MsgBox.Show("HÃY NHẬP PO NUMBER ", MsgType.Warning);
                txtPO_ID.Focus();
            }
        }

        private void SavePO()
        {
            IWorkbook workbook = spreadsheet_PO.Document;
            Worksheet sheet = workbook.Worksheets[0];
            int i = 4;
            DataRow row;
            int deliveryDate = 0;
            string dateCreatePO = "";
            PO_DETAIL_TYPE.Rows.Clear();
            while (sheet.Cells["V" + i].Value.NullString() != "")
            {
                row = PO_DETAIL_TYPE.NewRow();
                row["PO_ID"] = txtPO_ID.Text.NullString();
                row["PO_ID_TEMP"] = txtPO_Example.EditValue.NullString();

                if (sheet.Cells["A" + i].Value.NullString() != "" && sheet.Cells["A" + i].Value.NullString().Length == 8)
                {
                    dateCreatePO = sheet.Cells["A" + i].Value.NullString();
                }

                row["PO_CREATE"] = sheet.Cells["A" + i].Value.NullString();
                row["LIFNR"] = sheet.Cells["B" + i].Value.NullString();
                row["PR_CODE"] = (PR_SP_DEPT?.AsEnumerable().FirstOrDefault(x => x["SPAREPART_CODE"].NullString() == sheet.Cells["F" + i].Value.NullString() && x["DEPT_CODE"].NullString() == sheet.Cells["V" + i].Value.NullString())?["PR_CODE"].NullString()).NullString();
                row["KUNNR"] = sheet.Cells["C" + i].Value.NullString();
                row["BKGRP"] = sheet.Cells["D" + i].Value.NullString();
                row["PSTYP"] = sheet.Cells["E" + i].Value.NullString();
                row["SPARE_PART_CODE"] = sheet.Cells["F" + i].Value.NullString();
                row["TXZ01_DESCRIPTION"] = sheet.Cells["G" + i].Value.NullString();
                row["WERKS"] = sheet.Cells["H" + i].Value.NullString();
                row["LGORT"] = sheet.Cells["I" + i].Value.NullString();
                row["LGORT_STOREAGE_LOCATION"] = sheet.Cells["I" + i].Value.NullString();
                row["PO_QTY"] = sheet.Cells["J" + i].Value.NullString();
                row["UNIT"] = sheet.Cells["K" + i].Value.NullString();
                row["NETPR_PRICE"] = sheet.Cells["L" + i].Value.NullString();
                row["PER"] = sheet.Cells["M" + i].Value.NullString();
                row["WAERS"] = sheet.Cells["N" + i].Value.NullString();
                row["MWSKZ"] = sheet.Cells["O" + i].Value.NullString();
                row["EINDT_DELIVERY_DATE"] = sheet.Cells["P" + i].Value.NullString();

                if (sheet.Cells["P" + i].Value.NullString() != "" && int.TryParse(sheet.Cells["P" + i].Value.NullString(), out _))
                {
                    if (deliveryDate < int.Parse(sheet.Cells["P" + i].Value.NullString()))
                    {
                        deliveryDate = int.Parse(sheet.Cells["P" + i].Value.NullString());
                    }
                }

                row["KNTTP"] = sheet.Cells["Q" + i].Value.NullString();
                row["MATKL"] = sheet.Cells["R" + i].Value.NullString();
                row["POSID"] = sheet.Cells["S" + i].Value.NullString();
                row["SAKNR_GL_ACCOUNT"] = sheet.Cells["T" + i].Value.NullString();
                row["KOSTL_COST_CENTER"] = sheet.Cells["U" + i].Value.NullString();
                row["DEPT_CODE"] = sheet.Cells["V" + i].Value.NullString();
                PO_DETAIL_TYPE.Rows.Add(row);
                i++;
            }

            if (PO_DETAIL_TYPE.Rows.Count <= 0)
            {
                MsgBox.Show("KHÔNG CÓ DỮ LIỆU YÊU CÂÙ ĐẶT HÀNG", MsgType.Warning);
                return;
            }
             
            base.m_ResultDB = base.m_DBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_PO.PUT_PO",
                new string[] { "A_LIST_PR_CODE", "A_PO_ID_TEMP", "A_PO_ID", "A_DATE_NEED_FINISH", "A_DATE_CREATE_PO", "A_TITLE", "A_USER" }, "A_DATA",
                new string[] { PR_LIST, txtPO_Example.EditValue.NullString(), txtPO_ID.EditValue.NullString(), deliveryDate.NullString(), dateCreatePO, txtTitle.EditValue.NullString(), Consts.USER_INFO.Id }, PO_DETAIL_TYPE);

            if(m_ResultDB.ReturnInt != 0)
            {
                MsgBox.Show(m_ResultDB.ReturnString.NullString().Translation(), MsgType.Error);
            }
            else
            {
                MsgBox.Show(m_ResultDB.ReturnString.NullString().Translation(), MsgType.Information);
            }
        }
    }
}
