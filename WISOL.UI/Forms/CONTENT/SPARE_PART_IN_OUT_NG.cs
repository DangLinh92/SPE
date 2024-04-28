using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;
using DevExpress.XtraTab;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Classes;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class SPARE_PART_IN_OUT_NG : PageType
    {
        public SPARE_PART_IN_OUT_NG()
        {
            InitializeComponent();
            this.Load += SPARE_PART_IN_OUT_NG_Load;
        }

        private void SPARE_PART_IN_OUT_NG_Load(object sender, EventArgs e)
        {
            Classes.Common.SelectPrinter(cboPrinter);
            Classes.Common.SetFormIdToButton(this, "SPARE_PART_IN_OUT_NG");
            cheInput.Checked = true;
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.INIT",
                    new string[] { "A_DEPARTMENT" },
                    new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection tableCollection = m_ResultDB.ReturnDataSet.Tables;

                    m_BindData.BindGridLookEdit(stlKho, tableCollection[0], "CODE", "NAME");

                    stlKho.EditValue = tableCollection[0].Rows[0]["CODE"].NullString();

                    m_BindData.BindGridLookEdit(stlSparepart, tableCollection[1], "CODE", "NAME_VI");
                    m_BindData.BindGridLookEdit(stlSparepartMove, tableCollection[1], "CODE", "NAME_VI");
                    m_BindData.BindGridLookEdit(stlLocationOld, tableCollection[2], "CODE", "CODE");
                    m_BindData.BindGridLookEdit(stlLocation_New, tableCollection[2], "CODE", "CODE");
                    m_BindData.BindGridLookEdit(stlVitri, tableCollection[2], "CODE", "CODE");

                    m_BindData.BindGridView(gcList, tableCollection[3]);
                    m_BindData.BindGridView(gcLocation, tableCollection[4]);
                    m_BindData.BindGridView(gcInventory, tableCollection[5]);

                    gvList.Columns["ID"].Visible = false;
                    gvLocation.Columns["ID"].Visible = false;

                    gvList.OptionsView.ColumnAutoWidth = true;
                    gvLocation.OptionsView.ColumnAutoWidth = true;
                    gvInventory.OptionsView.ColumnAutoWidth = true;

                    GetLabelTemplate();
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void cheInput_CheckedChanged(object sender, EventArgs e)
        {
            cheOutput.Checked = !cheInput.Checked;
            stlVitri.Enabled = !cheInput.Checked;
        }

        private void cheOutput_CheckedChanged(object sender, EventArgs e)
        {
            cheInput.Checked = !cheOutput.Checked;
            stlVitri.Enabled = !cheInput.Checked;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string inout = "";
                if (cheInput.Checked)
                {
                    inout = "IN";
                    stlVitri.EditValue = "";
                }
                else if (cheOutput.Checked)
                {
                    inout = "OUT";
                }

                if (inout == "" ||
                    stlKho.EditValue.NullString() == "" ||
                    stlSparepart.EditValue.NullString() == "" ||
                    stlUnit.EditValue.NullString() == "" ||
                    txtQuantity.EditValue.NullString() == "" ||
                    dateInOut.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.PUT",
                    new string[]
                    {
                        "A_ID",
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_SPARE_PART",
                        "A_UNIT",
                        "A_QUANTITY",
                        "A_DATE",
                        "A_USER",
                        "A_IN_OUT",
                        "A_LOCATION"
                    },
                    new string[]
                    {
                        txtID.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        stlSparepart.EditValue.NullString(),
                        stlUnit.EditValue.NullString(),
                        txtQuantity.EditValue.NullString(),
                        dateInOut.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                        inout,
                        stlVitri.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);

                    if (checkPrint1.Checked)
                    {
                        Print(stlVitri.EditValue.NullString(),
                             "NG",
                             stlSparepart.EditValue.NullString(),
                             DateTime.Parse(dateInOut.Text.NullString()).ToString("yyyy-MM-dd"),
                             "",
                             txtQuantity.EditValue.NullString(), stlUnit.EditValue.NullString().ToUpper(),
                             int.Parse(txtLabelNumber_Move1.EditValue.NullString()), "");
                    }

                    InitData();
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.DELETE",
                   new string[]
                   {
                        "A_ID",
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_USER",
                   },
                   new string[]
                   {
                        txtID.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                   });

                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        InitData();
                    }
                    else
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            txtID.EditValue = "";
            stlSparepart.EditValue = "";
            txtQuantity.EditValue = "";
            stlUnit.EditValue = "";
            stlVitri.EditValue = "";
            dateInOut.EditValue = "";
            txtUser.EditValue = "";
        }

        private void btnSaveMove_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlSparepartMove.EditValue.NullString() == "" ||
                    stlKho.EditValue.NullString() == "" ||
                    stlLocationOld.EditValue.NullString() == stlLocation_New.EditValue.NullString() ||
                    txtQuantityMove.EditValue.NullString() == "" ||
                    stlUnitMove.EditValue.NullString() == "" ||
                     float.Parse(txtQuantityMove.EditValue.NullString()) == 0)
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_NG.MOVE_LOCATION",
                 new string[]
                 {
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_SPAREPARTS",
                        "A_LOCATION_OLD",
                        "A_LOCATION_NEW",
                        "A_QUANTITY",
                        "A_UNIT","A_TIME_IN"
                 },
                 new string[]
                 {
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        stlSparepartMove.EditValue.NullString(),
                        stlLocationOld.EditValue.NullString(),
                        stlLocation_New.EditValue.NullString(),
                        txtQuantityMove.EditValue.NullString(),
                        stlUnitMove.EditValue.NullString(),
                        dateInMove.EditValue.NullString()
                 });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);

                    if (checkPrint2.Checked)
                    {
                        Print(stlLocation_New.EditValue.NullString(),
                             "NG",
                             stlSparepartMove.EditValue.NullString(),
                             DateTime.Parse(dateInMove.Text.NullString()).ToString("yyyy-MM-dd"),
                             "",
                             txtQuantityMove.EditValue.NullString(), stlUnitMove.EditValue.NullString().ToUpper(),
                             int.Parse(txtLabelNumber_Move2.EditValue.NullString()), "");
                    }

                    InitData();
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearMove_Click(object sender, EventArgs e)
        {
            stlSparepartMove.EditValue = "";
            stlLocationOld.EditValue = "";
            stlLocation_New.EditValue = "";
            txtQuantityMove.EditValue = "";
            stlUnitMove.EditValue = "";
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;
            string inOut = gvList.GetRowCellValue(e.RowHandle, "IN_OUT").NullString();

            if (inOut == "OUT")
            {
                txtID.EditValue ="";
                stlSparepart.EditValue = "";
                txtQuantity.EditValue = "0";
                stlUnit.EditValue = "";
                stlVitri.EditValue = "";
                dateInOut.EditValue = "";
                return;
            }

            txtID.EditValue = gvList.GetRowCellValue(e.RowHandle, "ID").NullString();
            stlSparepart.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
            txtQuantity.EditValue = gvList.GetRowCellValue(e.RowHandle, "QUANTITY").NullString();
            stlUnit.EditValue = gvList.GetRowCellValue(e.RowHandle, "UNIT").NullString();
            stlVitri.EditValue = "";
            dateInOut.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE").NullString();

            cheInput.Checked = false;
            //if (inOut == "IN")
            //{
            //    cheInput.Checked = true;
            //}
            //else if (inOut == "OUT")
            //{
            //    cheOutput.Checked = true;
            //}
        }

        private void stlSparepart_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepart.EditValue.NullString(), stlUnit, m_BindData);
            Classes.Common.GetLocationBySparepart(stlSparepart.EditValue.NullString(), stlVitri, m_BindData);
        }

        private void stlSparepartMove_EditValueChanged(object sender, EventArgs e)
        {
            Classes.Common.GetUnitBySparePart(stlSparepartMove.EditValue.NullString(), stlUnitMove, m_BindData);
            Classes.Common.GetLocationBySparepart(stlSparepartMove.EditValue.NullString(), stlLocationOld, m_BindData);
        }

        private void gvLocation_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            if (e.RowHandle < 0)
                return;

            stlSparepartMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();
            stlLocationOld.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "LOCATION_CODE").NullString();
            txtQuantityMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "QUANTITY").NullString();
            stlUnitMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "UNIT").NullString();
            dateInMove.EditValue = gvLocation.GetRowCellValue(e.RowHandle, "TIME_IN").NullString();
        }

        private void MainTabControl_TabIndexChanged(object sender, EventArgs e)
        {

        }

        private void MainTabControl_Click(object sender, EventArgs e)
        {

        }

        private void MainTabControl_SelectedPageChanged(object sender, DevExpress.XtraTab.TabPageChangedEventArgs e)
        {
            var obj = e.Page as XtraTabPage;
            if (obj.Name == "TabHistory")
            {
                btnSave.Enabled = true;
                btnDelete.Enabled = true;
            }
            else
            {
                btnSave.Enabled = false;
                btnDelete.Enabled = false;
            }

            if (obj.Name == "TabPageLocation")
            {
                btnSaveMove.Enabled = true;
            }
            else
            {
                btnSaveMove.Enabled = false;
            }
        }

        private void Print(string position, string condition, string spareCode, string timeIn, string Exdate, string quantity, string unit, int numberLabel, string poNo)
        {
            #region print
            string designFile = string.Empty;
            string xml_content_Original = string.Empty;
            string xml_content = label;
            string sparepartInput = spareCode;
            try
            {
                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();

                ReportPrintTool pt1 = new ReportPrintTool(reportPrint);
                pt1.PrintingSystem.StartPrint += new PrintDocumentEventHandler(PrintingSystem_StartPrint);

                List<XtraReport> reports = new List<XtraReport>();

                for (int j = 0; j < numberLabel; j++)
                {
                    spareCode = sparepartInput;

                    xml_content = label;

                    string lblPosition_condition = position + (position == string.Empty ? (condition == "NG" ? "NG" : string.Empty) : (condition == "NG" ? ".NG" : string.Empty));

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
                    if (DateTime.TryParse(Exdate, out dExdate))
                    {
                        Exdate = dExdate.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        Exdate = "2199-01-01";
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

                    string addPo = string.Empty;
                    if (poNo != string.Empty)
                    {
                        addPo = Consts.STR_SPILIT_ON_BARCODE + poNo;
                    }

                    string quantityInLabel = (float.Parse(quantity) / numberLabel).ToString();
                    string barcode =
                       spareCode + Consts.STR_SPILIT_ON_BARCODE +
                       position + Consts.STR_SPILIT_ON_BARCODE +
                       condition + Consts.STR_SPILIT_ON_BARCODE +
                       timeIn + Consts.STR_SPILIT_ON_BARCODE +
                       Exdate + Consts.STR_SPILIT_ON_BARCODE +
                       quantityInLabel + Consts.STR_SPILIT_ON_BARCODE +
                       unit + addPo;

                    string newSparepartCode = sparepartInput + "-" + quantityInLabel + unit;
                    if (Exdate == "2199-01-01")
                    {
                        xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                    }
                    else
                    {
                        if (DateTime.TryParse(Exdate, out DateTime ExpriDate))
                        {
                            xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "EXP:" + ExpriDate.ToString("yyyy-MM-dd"));
                        }
                        else
                        {
                            xml_content = xml_content.Replace("$BARCODE$", barcode).Replace("$CODE$", newSparepartCode).Replace("$POSITION$", lblPosition_condition).Replace("$EXP_DATE$", "IN TIME:" + timeIn);
                        }
                    }

                    xml_content = xml_content.Replace("&", "&amp;");
                    File.WriteAllText(designFile, xml_content);

                    XtraReport report = new XtraReport();
                    report.PrintingSystem.ShowPrintStatusDialog = false;
                    report.PrintingSystem.ShowMarginsWarning = false;
                    report.LoadLayoutFromXml(designFile);

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
                    File.Delete(designFile);

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
                    pts.Print();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            #endregion
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

        private PrinterSettings prnSettings;
        string label;
        private void GetLabelTemplate()
        {
            try
            {
                label = string.Empty;
                string LabelCode = "QRCODE_" + cboPrinter.Text;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET_TEMP", new string[] { "A_CODE_TEMP" }, new string[] { LabelCode });//QRCODE 
                if (m_ResultDB.ReturnInt == 0)
                {
                    if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                    {
                        label = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["LABEL"].NullString();
                    }
                    else
                    {
                        MsgBox.Show("Không có File label cho printer " + cboPrinter.Text, MsgType.Warning);
                    }
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void cboPrinter_SelectedIndexChanged(object sender, EventArgs e)
        {
            PrinterClass.SetDefaultPrinter(cboPrinter.Text);
            GetLabelTemplate();
        }

        private void btnNhapXuat_Click(object sender, EventArgs e)
        {
            try
            {
                string inout = "";
                if (cheInput.Checked)
                {
                    inout = "IN";
                    stlVitri.EditValue = "";
                }
                else if (cheOutput.Checked)
                {
                    inout = "OUT";
                }

                if (inout == "" ||
                    stlKho.EditValue.NullString() == "" ||
                    stlSparepart.EditValue.NullString() == "" ||
                    stlUnit.EditValue.NullString() == "" ||
                    txtQuantity.EditValue.NullString() == "" ||
                    dateInOut.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SPARE_PART_NG.PUT",
                    new string[]
                    {
                        "A_ID",
                        "A_DEPARTMENT",
                        "A_STOCK_CODE",
                        "A_SPARE_PART",
                        "A_UNIT",
                        "A_QUANTITY",
                        "A_DATE",
                        "A_USER",
                        "A_IN_OUT",
                        "A_LOCATION"
                    },
                    new string[]
                    {
                        "",
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        stlSparepart.EditValue.NullString(),
                        stlUnit.EditValue.NullString(),
                        txtQuantity.EditValue.NullString(),
                        dateInOut.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                        inout,
                        stlVitri.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);

                    if (checkPrint1.Checked)
                    {
                        Print(stlVitri.EditValue.NullString(),
                             "NG",
                             stlSparepart.EditValue.NullString(),
                             DateTime.Parse(dateInOut.Text.NullString()).ToString("yyyy-MM-dd"),
                             "",
                             txtQuantity.EditValue.NullString(), stlUnit.EditValue.NullString().ToUpper(),
                             int.Parse(txtLabelNumber_Move1.EditValue.NullString()), "");
                    }

                    InitData();
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
