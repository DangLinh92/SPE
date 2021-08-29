using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class IMPORT_EXCEL : FormType
    {
        public IMPORT_EXCEL()
        {
            InitializeComponent();
        }

        public string stock_code { get; set; }
        public string ImpportType { get; set; }
        DataTable Data;

        private void IMPORT_EXCEL_Load(object sender, EventArgs e)
        {
            Data = new DataTable();
            if (ImpportType == Consts.IMPORT_TYPE_PRICE)
            {
                dateValid.Enabled = true;
                dateValid.EditValue = DateTime.Now;
                lblTime.Visible = true;
            }
            else
            {
                lblTime.Visible = false;
                dateValid.Enabled = false;
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            if (Data.Rows.Count > 0)
            {
                Import();
            }
        }

        private void Import()
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_IMPORT_EXCEL".Translation(), MsgType.Information, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    if (ImpportType == Consts.IMPORT_TYPE_INVENTORY_REAL)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_LOCATION.INSERT_BATCH_INVENTORY_REAL", new string[] { "A_DEPARTMENT_CODE", "A_STOCK", "A_USER", "A_TIME" }, "A_DATA", new string[] { Consts.DEPARTMENT, stock_code, Consts.USER_INFO.Id, string.Empty }, Data);
                    }
                    else if (ImpportType == Consts.IMPORT_TYPE_BUSINESS_LOCATION_SPAREPART_INSERT_BATCH)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_LOCATION_SPAREPART.INSERT_ BATCH", new string[] { "A_DEPARTMENT_CODE", "A_STOCK" }, "A_DATA", new string[] { Consts.DEPARTMENT, stock_code }, Data);
                    }
                    else if (ImpportType == Consts.IMPORT_TYPE_PRICE)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_PRICE.IMPORT", new string[] { "A_DATE", "A_DEPT_CODE" }, "A_DATA", new string[] { dateValid.EditValue.NullString(), Consts.DEPARTMENT }, Data);
                    }
                    else if (ImpportType == Consts.IMPORT_TYPE_INVOICE)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_INVOICE.IMPORT", new string[] { "A_USER" }, "A_DATA", new string[] { Consts.USER_INFO.Id }, Data);
                    }
                    else if (ImpportType == Consts.IMPORT_TYPE_LOGISTICS_DAILY)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_LOGISTICS_DAILY_REPORT.IMPORT", new string[] { "A_USER" }, "A_DATA", new string[] { Consts.USER_INFO.Id }, Data);
                    }

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

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            if (ImpportType == Consts.IMPORT_TYPE_PRICE)
            {
                if (dateValid.EditValue.NullString() == "")
                {
                    MsgBox.Show("Nhập thời điểm giá tiền được áp dụng", MsgType.Warning);
                    return;
                }
            }

            //string name file;
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "Excel Files (.xls*)|*.xls*|All Files (*.*)|*.*";
            dlg.Multiselect = false;

            DialogResult dlgResult = dlg.ShowDialog();
            if (dlgResult == DialogResult.OK)
            {
                txtFilePath.Text = dlg.FileName;
                if (txtFilePath.Text.Equals(string.Empty))
                {
                    lblMsg.Text = "Please Load File First!!!";
                    return;
                }
                if (!File.Exists(txtFilePath.Text))
                {
                    lblMsg.Text = "Can not Open File!!!";
                    return;
                }
                string filePath = txtFilePath.Text;
                string excelcon;
                if (filePath.Substring(filePath.LastIndexOf('.')).ToLower() == ".xlsx")
                {
                    excelcon = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties='Excel 12.0;HDR=NO;IMEX=1'";
                }
                else
                {
                    excelcon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties='Excel 8.0;HDR=NO;IMEX=1'";
                }
                OleDbConnection conexcel = new OleDbConnection(excelcon);

                try
                {
                    conexcel.Open();
                    DataTable dtExcel = conexcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                    string sheetName = "EWIP_SPAREPART_LOCATION$";

                    if (ImpportType == Consts.IMPORT_TYPE_PRICE)
                    {
                        sheetName = "EWIP_SPAREPART_PRICE$";
                    }
                    else if (ImpportType == Consts.IMPORT_TYPE_INVOICE || ImpportType == Consts.IMPORT_TYPE_LOGISTICS_DAILY)
                    {
                        foreach (DataRow drSheet in dtExcel.Rows)
                        {
                            if (drSheet["TABLE_NAME"].ToString().Contains("$"))
                            {
                                sheetName = drSheet["TABLE_NAME"].ToString();
                                break;
                            }
                        }
                    }

                    OleDbCommand cmdexcel1 = new OleDbCommand();
                    cmdexcel1.Connection = conexcel;
                    cmdexcel1.CommandText = "select * from[" + sheetName + "]";

                    Data = new DataTable();
                    OleDbDataAdapter da = new OleDbDataAdapter();
                    da.SelectCommand = cmdexcel1;
                    da.Fill(Data);
                    conexcel.Close();

                    Data.Rows.RemoveAt(0);

                    if (ImpportType == Consts.IMPORT_TYPE_PRICE)
                    {
                        base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_EXCHANGE_RATE.GET_BY_TIME", new string[] { "A_DATE" }, new string[] { dateValid.EditValue.NullString() });

                        if (mResultDB.ReturnInt == 0)
                        {
                            DataTable table = mResultDB.ReturnDataSet.Tables[0];
                            float rate = float.Parse(table.Rows[0]["RATE"].NullString());
                            foreach (DataRow row in Data.Rows)
                            {
                                if (row[3].NullString() == "" && row[4].NullString() != "")
                                {
                                    row[3] = float.Parse(row[4].IfNullIsZero()) * rate; // USD->VND
                                }
                                else if (row[3].NullString() != "" && row[4].NullString() == "")
                                {
                                    row[4] = float.Parse(row[3].IfNullIsZero()) / rate; // VND->USD
                                }
                                else if (row[3].NullString() == "" && row[4].NullString() == "")
                                {
                                    row[3] = 1;
                                    row[4] = 0;
                                }
                            }
                        }
                    }

                    base.mBindData.BindGridView(gcList, Data);
                    //gvList.DeleteRow(0);
                }
                catch (Exception ex)
                {
                    conexcel.Close();
                    MessageBox.Show(ex.ToString());
                }
            }
        }
    }
}
