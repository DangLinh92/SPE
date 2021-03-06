using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Classes;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class PRINT_LABEL : FormType
    {
        public PRINT_LABEL()
        {
            InitializeComponent();
        }

        public string Kho { get; set; }

        private DataTableCollection GetLocations()
        {
            if (checkShowAllData.Checked)
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET_FOR_PRINT", new string[] { "A_DEPARTMENT", "A_STOCK" }, new string[] { Consts.DEPARTMENT, Kho });
                if (base.mResultDB.ReturnInt == 0)
                {
                    return base.mResultDB.ReturnDataSet.Tables;
                }
            }
            else
            {
                if (Consts.GetDataMemory().Rows.Count > 0)
                {
                    string spareparts = string.Empty;
                    foreach (DataRow item in Consts.GetDataMemory().Rows)
                    {
                        spareparts += item["CODE"].NullString() + ",";
                    }
                    spareparts = spareparts.Remove(spareparts.Length - 1);
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GETBYSPAREPART", new string[] { "A_DEPARTMENT", "A_STOCK", "A_SPAREPARTS" }, new string[] { Consts.DEPARTMENT, Kho, spareparts });
                    if (base.mResultDB.ReturnInt == 0)
                    {
                        return base.mResultDB.ReturnDataSet.Tables;
                    }
                }
                else
                {
                    base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET_FOR_PRINT", new string[] { "A_DEPARTMENT", "A_STOCK" }, new string[] { Consts.DEPARTMENT, Kho });
                    if (base.mResultDB.ReturnInt == 0)
                    {
                        return base.mResultDB.ReturnDataSet.Tables;
                    }
                }
            }

            return null;
        }

        private DataTable GetUnitBySparepart(string code)
        {
            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_UNIT_SPAREPART.GET_UNIT_BY_SPAREPART", new string[] { "A_DEPT_CODE", "A_SPARE_PART_CODE" }, new string[] { Consts.DEPARTMENT, code });
            if (base.mResultDB.ReturnInt == 0)
            {
                return base.mResultDB.ReturnDataSet.Tables[0];
            }
            return null;
        }


        private void ViewLocation(DataTable data)
        {
            try
            {
                base.mBindData.BindGridView(gcList, data);
                if (data.Rows.Count > 0)
                {
                    gvList.Columns["KHO"].Visible = false;
                    gvList.Columns["STT"].Visible = false;
                    gvList.Columns["BARCODE"].Visible = false;
                    gvList.Columns["QUANTITY"].Visible = true;

                    gvList.OptionsSelection.MultiSelect = true;
                    gvList.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;

                    gvList.OptionsBehavior.Editable = true;
                    gvList.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["SPARE_PART_CODE"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["NAME_VI"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["CONDITION_NAME"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["UNIT"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["EXPIRED_DATE"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["QUANTITY_PRINT_LABEL"].OptionsColumn.AllowEdit = true;
                    gvList.Columns["TIME_IN"].OptionsColumn.AllowEdit = false;
                    gvList.Columns["QUANTITY_A_UNIT"].OptionsColumn.AllowEdit = true;
                    gvList.Columns["PO_NO"].OptionsColumn.AllowEdit = false;
                    gvList.OptionsView.ColumnAutoWidth = true;
                }

            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void PRINT_LABEL_Load(object sender, EventArgs e)
        {
            Classes.Common.SelectPrinter(cboPrinter);
            Classes.Common.SetFormIdToButton(null, "PRINT_LABEL", this);

            LoadData();
            GetLabelTemplate();
        }

        private void LoadData()
        {
            mBindData.BindGridLookEdit(stlMemoryData, Consts.GetDataMemory(), "CODE", "NAME_VI");

            DataTableCollection dataLocations = GetLocations();
            if (dataLocations != null)
            {
                if (dataLocations.Count > 1)
                {
                    ViewLocation(dataLocations[1]);
                }
                else
                {
                    ViewLocation(dataLocations[0]);
                }
            }
        }

        private void gvList_CustomRowCellEdit(object sender, CustomRowCellEditEventArgs e)
        {

        }

        private void gvList_RowCellClick(object sender, RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }

                DataTable data = GetUnitBySparepart(gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString());
                mBindData.BindGridLookEdit(stlUnit, data, "CODE", "NAME");
                txtHandleRow.EditValue = e.RowHandle.NullString();
                stlUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
                txtQuantity.EditValue = gvList.GetRowCellValue(e.RowHandle, "QUANTITY_A_UNIT").NullString();
                txtQuantityLabel.EditValue = gvList.GetRowCellValue(e.RowHandle, "QUANTITY_PRINT_LABEL").NullString();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                gvList.SetRowCellValue(int.Parse(txtHandleRow.EditValue.NullString()), "UNIT", stlUnit.EditValue.NullString());
                gvList.SetRowCellValue(int.Parse(txtHandleRow.EditValue.NullString()), "QUANTITY_A_UNIT", txtQuantity.EditValue.NullString());
                gvList.SetRowCellValue(int.Parse(txtHandleRow.EditValue.NullString()), "QUANTITY_PRINT_LABEL", txtQuantityLabel.EditValue.NullString());
                gvList.MakeRowVisible(int.Parse(txtHandleRow.EditValue.NullString()));
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private PrinterSettings prnSettings;
        private void btnPrint_Click(object sender, EventArgs e)
        {

            string designFile = string.Empty;
            string xml_content_Original = string.Empty;
            string xml_content = label;

            try
            {
                // new barcode is : MA SAN PHAM$VI TRI$TINH TRANG$NGAY NHAP KHO$NGAY HET HAN$SO LUONG$DON VI$PO_NO
                // SP-0001$01-01$OK$2021-06-30$2021-06-30$100$PACK$12313

                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();

                ReportPrintTool pt1 = new ReportPrintTool(reportPrint);
                pt1.PrintingSystem.StartPrint += new PrintDocumentEventHandler(PrintingSystem_StartPrint);

                List<XtraReport> reports = new List<XtraReport>();
                int check = 0;
                foreach (int i in gvList.GetSelectedRows())
                {
                    int numberLabel = int.Parse(Math.Ceiling(decimal.Parse(gvList.GetRowCellValue(i, "QUANTITY_PRINT_LABEL").NullString())).NullString());
                    for (int j = 0; j < numberLabel; j++)
                    {
                        xml_content = label;

                        string spareCode = gvList.GetRowCellValue(i, "SPARE_PART_CODE").NullString();
                        string position = gvList.GetRowCellValue(i, "LOCATION").NullString();
                        string condition = gvList.GetRowCellValue(i, "CONDITION_NAME").NullString();
                        string lblPosition_condition = position + (position == string.Empty ? (condition == "NG" ? "NG" : string.Empty) : (condition == "NG" ? ".NG" : string.Empty));
                        string strDate = gvList.GetRowCellValue(i, "EXPIRED_DATE").NullString();
                        string timeIn = gvList.GetRowCellValue(i, "TIME_IN").NullString();
                        string quantity = gvList.GetRowCellValue(i, "QUANTITY_A_UNIT").NullString();
                        string unit = gvList.GetRowCellValue(i, "UNIT").NullString().ToUpper();
                        string poNo = gvList.GetRowCellValue(i, "PO_NO").NullString();

                        DateTime dTimeIn;
                        if (DateTime.TryParse(timeIn, out dTimeIn))
                        {
                            timeIn = dTimeIn.ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            timeIn = "-";
                        }

                        DateTime dExdate;
                        if (DateTime.TryParse(strDate, out dExdate))
                        {
                            strDate = dExdate.ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            strDate = "2199-01-01";
                        }

                        if (spareCode.Length > 8 && Consts.DEPARTMENT == Consts.SMT_DEPT)
                        {
                            if (Consts.SPAREPART_TO_ID != null && Consts.SPAREPART_TO_ID.Rows.Count > 0)
                            {
                                DataRow[] rows = Consts.SPAREPART_TO_ID.Select("[SPARE_PART_CODE] = '" + spareCode + "'");
                                if (rows.Length == 1)
                                {
                                    spareCode = rows[0]["ENCRIPT_CODE"].NullString();
                                }
                            }
                        }

                        string barcode =
                            spareCode + Consts.STR_SPILIT_ON_BARCODE +
                            position + Consts.STR_SPILIT_ON_BARCODE +
                            condition + Consts.STR_SPILIT_ON_BARCODE +
                            timeIn + Consts.STR_SPILIT_ON_BARCODE +
                            strDate + Consts.STR_SPILIT_ON_BARCODE +
                            quantity + Consts.STR_SPILIT_ON_BARCODE +
                            unit;

                        if (poNo != "")
                        {
                            barcode += (Consts.STR_SPILIT_ON_BARCODE + poNo);
                        }

                        string newSparepartCode = gvList.GetRowCellValue(i, "SPARE_PART_CODE").NullString() + "-" + quantity + unit;

                        if (strDate == "2199-01-01")
                        {
                            xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                        }
                        else
                        {
                            if (DateTime.TryParse(strDate, out DateTime ExpriDate))
                            {
                                xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "EXP:" + ExpriDate.ToString("yyyy-MM-dd"));
                            }
                            else
                            {
                                xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                            }
                        }

                        xml_content = xml_content.Replace("&", "&amp;");
                        File.WriteAllText((i + 1).NullString() + designFile, xml_content);

                        XtraReport report = new XtraReport();
                        report.PrintingSystem.ShowPrintStatusDialog = false;
                        report.PrintingSystem.ShowMarginsWarning = false;
                        report.LoadLayoutFromXml((i + 1).NullString() + designFile);

                        int leftMargine = report.Margins.Left + 0;
                        int rightMargine = report.Margins.Right;
                        int topMargine = report.Margins.Top + 0;
                        int bottomMargine = report.Margins.Bottom;
                        if (leftMargine < 0)
                        {
                            leftMargine = 0;
                        }
                        if (topMargine < 0)
                        {
                            topMargine = 0;
                        }
                        report.Margins = new System.Drawing.Printing.Margins(leftMargine, rightMargine, topMargine, bottomMargine);
                        report.CreateDocument();

                        reports.Add(report);
                        File.Delete((i + 1).NullString() + designFile);
                        //i++;
                        //check++;

                    }

                    check++;

                }

                if (check == 0)
                {
                    MsgBox.Show("MSG_NOT_HAVE_LOCATION".Translation(), MsgType.Warning);
                    return;
                }

                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    pts.PrintingSystem.StartPrint +=
                        new PrintDocumentEventHandler(reportsStartPrintEventHandler);
                }

                pt1.PrintDialog();
                foreach (XtraReport report in reports)
                {
                    ReportPrintTool pts = new ReportPrintTool(report);
                    //pts.ShowPreview();
                    pts.Print();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void reportsStartPrintEventHandler(object sender, PrintDocumentEventArgs e)
        {
            int pageCount = e.PrintDocument.PrinterSettings.ToPage;
            e.PrintDocument.PrinterSettings = prnSettings;

            // The following line is required if the number of pages for each report varies, 
            // and you consistently need to print all pages.
            e.PrintDocument.PrinterSettings.ToPage = pageCount;
        }

        private void PrintingSystem_StartPrint(object sender, PrintDocumentEventArgs e)
        {
            prnSettings = e.PrintDocument.PrinterSettings;
        }


        string label;
        private void GetLabelTemplate()
        {
            try
            {
                label = string.Empty;
                string LabelCode = "QRCODE_" + cboPrinter.Text;
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET_TEMP", new string[] { "A_CODE_TEMP" }, new string[] { LabelCode });//QRCODE
                if (mResultDB.ReturnInt == 0)
                {
                    if (base.mResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        label = base.mResultDB.ReturnDataSet.Tables[0].Rows[0]["LABEL"].NullString();
                    }
                    else
                    {
                        MsgBox.Show("Không có File label cho printer " + cboPrinter.Text, MsgType.Warning);
                    }
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void checkShowAllData_CheckedChanged(object sender, EventArgs e)
        {
            LoadData();
        }

        private void cboPrinter_SelectedIndexChanged(object sender, EventArgs e)
        {
            PrinterClass.SetDefaultPrinter(cboPrinter.Text);
            GetLabelTemplate();
        }
    }
}
