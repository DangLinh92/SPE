using DevExpress.Utils;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraPrinting;
using DevExpress.XtraPrinting.BarCode;
using DevExpress.XtraReports.UI;
using DevExpress.XtraTreeList;
using DevExpress.XtraTreeMap;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Printing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class LOCATION : PageType
    {
        public LOCATION()
        {
            InitializeComponent();
        }

        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
        }

        public override void InitializePage()
        {
            try
            {
                Init_Control();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }
        private void Init_Control()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_INIT.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(stlPosition, base.m_ResultDB.ReturnDataSet.Tables[0], "CODE", "CODE");
                    base.m_BindData.BindGridLookEdit(stlKho, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlCondition, base.m_ResultDB.ReturnDataSet.Tables[2], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlUnit, base.m_ResultDB.ReturnDataSet.Tables[3], "CODE", "NAME");
                    base.m_BindData.BindGridLookEdit(stlSparepart, base.m_ResultDB.ReturnDataSet.Tables[4], "CODE", "NAME_VI");
                    base.m_BindData.BindGridLookEdit(stlSparePartSearch, base.m_ResultDB.ReturnDataSet.Tables[4], "CODE", "NAME_VI");

                    string firstValue = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["CODE"].NullString();
                    stlKho.EditValue = firstValue;
                }

                SettingDefaultValueControl();

                ViewLocation();

                GetLabelTemplate();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void GetLocationForCombobox()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_INIT.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(stlPosition, base.m_ResultDB.ReturnDataSet.Tables[0], "CODE", "CODE");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void SettingDefaultValueControl()
        {
            rdoChoose.SelectedIndex = 1;// quick add position

            ActiveInactiveControl();

            cheIsWait.Checked = false;
            stlPosition.EditValue = string.Empty;
            stlSparepart.EditValue = string.Empty;
            txtQuantity.EditValue = "0";
            stlUnit.EditValue = string.Empty;
            txtQuantityNewAdd.EditValue = "0";
            stlCondition.EditValue = string.Empty;
        }

        private void ActiveInactiveControl()
        {
            if ("1".Equals(rdoChoose.EditValue.NullString()))// add quick
            {
                txtposition1.Enabled = false;
                txtPosition2.Enabled = false;

                loStartPosition.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                loSquareNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
                loPositionNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Always;
            }
            else
            {
                txtposition1.Enabled = true;
                txtPosition2.Enabled = true;

                loStartPosition.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                loSquareNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
                loPositionNumber.Visibility = DevExpress.XtraLayout.Utils.LayoutVisibility.Never;
            }
        }

        private void AddNewLocation()
        {
            // add quick
            if ("1".Equals(rdoChoose.EditValue.NullString()))
            {
                if (
                    string.IsNullOrEmpty(txtStartPosition.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtsquare.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtPositionNumber.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlKho.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                int squareNumber = int.Parse(txtsquare.EditValue.NullString());
                int positionNumber = int.Parse(txtPositionNumber.EditValue.NullString());
                int startPositionNumber = int.Parse(txtStartPosition.EditValue.NullString());

                DataTable LOCATION_TYPE = new DataTable();
                LOCATION_TYPE.Columns.Add("CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("STOCK_CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("DEPT_CODE", typeof(string));
                LOCATION_TYPE.Columns.Add("RACK_CODE", typeof(string));

                string stockCode = stlKho.EditValue.NullString();
                string codeLocation = "";
                string position1 = "";

                for (int j = startPositionNumber; j < startPositionNumber + squareNumber; j++)
                {
                    position1 = CreateNumberCode(j);

                    for (int k = 1; k <= positionNumber; k++)
                    {
                        codeLocation = position1 + "-" + CreateNumberCode(k);
                        LOCATION_TYPE.Rows.Add(codeLocation, stockCode, Consts.DEPARTMENT, "");
                    }
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProcWithTableParam("PKG_BUSINESS_LOCATION.INSERT_BATCH", new string[] { }, "@A_LOCATION_TYPE", new string[] { }, LOCATION_TYPE);

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtposition1.EditValue.NullString()) ||
                    string.IsNullOrEmpty(txtPosition2.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                string codeLocation = txtposition1.EditValue.NullString() + "-" + txtPosition2.EditValue.NullString();

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.INSERT_SINGLE", new string[] { "A_CODE", "A_STOCK_CODE", "A_DEPT_CODE" }, new string[] { codeLocation, stlKho.EditValue.NullString(), Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                }
                else
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
        }

        private void ViewLocation()
        {
            try
            {
                DataTableCollection dataLocations = GetLocations();
                if (dataLocations != null)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    if (dataLocations[0].Rows.Count > 0)
                    {
                        gvList.Columns["KHO"].Visible = false;
                        gvList.Columns["LOCATION"].Width = 230;
                        gvList.MakeRowVisible(gvList.DataRowCount - 1);
                    }

                    base.m_BindData.BindGridView(gcListNoPosition, base.m_ResultDB.ReturnDataSet.Tables[1]);
                    if (dataLocations[1].Rows.Count > 0)
                    {
                        gvListNoPosition.Columns["KHO"].Visible = false;
                        gvListNoPosition.Columns["STT"].Visible = false;
                        gvListNoPosition.Columns["BARCODE"].Visible = false;

                        gvListNoPosition.OptionsSelection.MultiSelect = true;
                        gvListNoPosition.OptionsSelection.MultiSelectMode = GridMultiSelectMode.CheckBoxRowSelect;


                        gvListNoPosition.OptionsBehavior.Editable = true;
                        gvListNoPosition.Columns["LOCATION"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["SPARE_PART_CODE"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["NAME_VI"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["CONDITION_NAME"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["UNIT"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["QUANTITY"].OptionsColumn.AllowEdit = false;
                        gvListNoPosition.Columns["QUANTITY_PRINT_LABEL"].OptionsColumn.AllowEdit = true;
                    }

                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private DataTableCollection GetLocations()
        {
            base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.GET", new string[] { "A_DEPARTMENT", "A_STOCK" }, new string[] { Consts.DEPARTMENT, stlKho.EditValue.NullString() });
            if (base.m_ResultDB.ReturnInt == 0)
            {
                return base.m_ResultDB.ReturnDataSet.Tables;
            }
            return null;
        }

        private string CreateNumberCode(int number)
        {
            if (number <= 9) return "0" + number;
            return "" + number;
        }

        public override void SearchPage()
        {
            base.SearchPage();
        }

        private void radioGroup1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActiveInactiveControl();
        }

        private void cheIsWait_CheckedChanged(object sender, EventArgs e)
        {
            if (cheIsWait.Checked)
            {
                stlPosition.Enabled = false;
                stlPosition.EditValue = null;
            }
            else
            {
                stlPosition.Enabled = true;
            }
        }

        private void btnSaveNewLocation_Click(object sender, EventArgs e)
        {
            try
            {
                AddNewLocation();

                // View UI
                ViewLocation();

                // update location and rack in combobox
                GetLocationForCombobox();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearLocationNew_Click(object sender, EventArgs e)
        {
            txtsquare.EditValue = null;
            txtPositionNumber.EditValue = null;
            txtposition1.EditValue = null;
            txtPosition2.EditValue = null;
            txtStartPosition.EditValue = null;
        }

        private void txtSearch_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Vị trí") args.IsSearchColumn = false;
        }

        private void btnDeleteLocation_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) || string.IsNullOrEmpty(txtposition1.EditValue.NullString()) || string.IsNullOrEmpty(txtPosition2.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    rdoChoose.EditValue = "2";
                    txtposition1.Focus();
                    return;
                }

                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    string codeLocation = txtposition1.EditValue.NullString() + "-" + txtPosition2.EditValue.NullString();
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION.DELETE", new string[] { "A_CODE", "A_DEPARTMENT", "A_STOCK" }, new string[] { codeLocation, Consts.DEPARTMENT, stlKho.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);

                        // reload location in grid
                        ViewLocation();

                        // update location and rack in combobox
                        GetLocationForCombobox();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);

                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            if (e.RowHandle < 0)
            {
                txtSearchNoLocation.EditValue = null;
                return;
            }
            else
            {
                string location = gvList.GetDataRow(e.RowHandle)["LOCATION"].NullString();
                txtSearchNoLocation.EditValue = location;
                txtposition1.EditValue = location.Split('-')[0];
                txtPosition2.EditValue = location.Split('-')[1];
            }
        }

        private void btnSaveLocation_Sparepart_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlPosition.EditValue.NullString()) && cheIsWait.Checked == false
                    || string.IsNullOrEmpty(stlSparepart.EditValue.NullString())
                    || (string.IsNullOrEmpty(txtQuantity.EditValue.NullString()) && string.IsNullOrEmpty(txtQuantityNewAdd.EditValue.NullString()))
                    || string.IsNullOrEmpty(stlUnit.EditValue.NullString())
                    || string.IsNullOrEmpty(stlCondition.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if (string.IsNullOrEmpty(txtQuantity.EditValue.NullString()))
                {
                    txtQuantity.EditValue = "0";
                }

                if (string.IsNullOrEmpty(txtQuantityNewAdd.EditValue.NullString()))
                {
                    txtQuantity.EditValue = "0";
                }

                float quantity = float.Parse(txtQuantity.EditValue.NullString()) + float.Parse(txtQuantityNewAdd.EditValue.NullString());

                string barcode = stlSparepart.EditValue.NullString() + (stlPosition.EditValue.NullString() == string.Empty ? "" : "." + stlPosition.EditValue.NullString()) + (stlCondition.EditValue.NullString() == Consts.NG ? "." + stlCondition.EditValue.NullString() : "");
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.INSERT_SPAREPART",
                    new string[] { "A_STT", "A_SPARE_PART_CODE", "A_LOCATION", "A_CONDITION", "A_ISWATE", "A_QUANTITY", "A_DEPART_MENT", "A_STOCK", "A_BARCODE", "A_UNIT" },
                    new string[]
                    {
                        txtSTT.EditValue.NullString(),
                        stlSparepart.EditValue.NullString() ,
                        stlPosition.EditValue.NullString() ,
                        stlCondition.EditValue.NullString() ,
                        cheIsWait.Checked.NullString(),
                        quantity.NullString() ,
                        Consts.DEPARTMENT,
                        stlKho.EditValue.NullString(),
                        barcode,
                        stlUnit.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    ViewLocation();
                    ClearSparepartLocation();
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

        private void btnClearSparePartLocation_Click(object sender, EventArgs e)
        {
            ClearSparepartLocation();
        }

        private void ClearSparepartLocation()
        {
            try
            {
                cheIsWait.EditValue = false;
                stlPosition.EditValue = null;
                stlSparepart.EditValue = null;
                txtQuantity.EditValue = null;
                stlUnit.EditValue = null;
                stlCondition.EditValue = null;
                stlPosition.Enabled = true;
                txtSTT.EditValue = null;
                txtQuantityNewAdd.EditValue = null;
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnDeleteLocation_Sparepart_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlKho.EditValue.NullString()) ||
                    (string.IsNullOrEmpty(stlPosition.EditValue.NullString()) && !cheIsWait.Checked) ||
                    string.IsNullOrEmpty(stlSparepart.EditValue.NullString()) ||
                    string.IsNullOrEmpty(stlCondition.EditValue.NullString()))
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    stlPosition.Focus();
                    return;
                }


                DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
                if (dialogResult == DialogResult.OK)
                {
                    string codeLocation = txtposition1.EditValue.NullString() + "-" + txtPosition2.EditValue.NullString();
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.DELETE",
                        new string[] { "A_STT", "A_SPARE_PART_CODE", "A_LOCATION", "A_DEPART_MENT", "A_STOCK", "A_CONDITION", "A_UNIT" },
                        new string[]
                        {
                            txtSTT.EditValue.NullString(),
                            stlSparepart.EditValue.NullString(),
                            stlPosition.EditValue.NullString(),
                            Consts.DEPARTMENT,
                            stlKho.EditValue.NullString(),
                            stlCondition.EditValue.NullString(),
                            stlUnit.EditValue.NullString()
                        });

                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);

                        // reload location in grid
                        ViewLocation();

                        ClearSparepartLocation();
                    }
                    else
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Warning);
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void txtSearchNoLocation_QueryIsSearchColumn(object sender, DevExpress.XtraEditors.QueryIsSearchColumnEventArgs args)
        {
            string s = sender.ToString();
            if (s != "Vị trí") args.IsSearchColumn = false;
        }

        private void gvListNoPosition_RowClick(object sender, DevExpress.XtraGrid.Views.Grid.RowClickEventArgs e)
        {
            if (e.RowHandle < 0)
            {
                return;
            }
            else
            {
                try
                {
                    // Get sparepart no position
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LOCATION_SPAREPART.GET_SINGLE", new string[] { "A_STT" }, new string[] { gvListNoPosition.GetDataRow(e.RowHandle)["STT"].NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        if (base.m_ResultDB.ReturnDataSet.Tables[0].Rows.Count > 0)
                        {
                            DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];

                            stlPosition.EditValue = data.Rows[0]["LOCATION"].NullString();

                            stlSparepart.EditValue = data.Rows[0]["SPARE_PART_CODE"].NullString();
                            txtQuantity.EditValue = data.Rows[0]["QUANTITY"].NullString();
                            stlUnit.EditValue = data.Rows[0]["UNIT"].NullString();
                            stlCondition.EditValue = data.Rows[0]["CONDITION_CODE"].NullString();
                            txtSTT.EditValue = gvListNoPosition.GetDataRow(e.RowHandle)["STT"].NullString();

                            if (string.IsNullOrEmpty(data.Rows[0]["LOCATION"].NullString()))
                            {
                                cheIsWait.Checked = true;
                            }
                            else
                            {
                                stlPosition.Enabled = false;
                                cheIsWait.Checked = false;
                            }
                        }
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
        }

        private void stlPosition_EditValueChanged(object sender, EventArgs e)
        {
            AceGridLookUpEdit position = (AceGridLookUpEdit)sender;
            if (!string.IsNullOrEmpty(position.EditValue.NullString()))
            {
                cheIsWait.Checked = false;
            }
        }

        private PrinterSettings prnSettings;
        private void btnPrintLabel_Click(object sender, EventArgs e)
        {
            string designFile = string.Empty;
            string xml_content_Original = string.Empty;
            string xml_content = label;

            try
            {
                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();

                ReportPrintTool pt1 = new ReportPrintTool(reportPrint);
                pt1.PrintingSystem.StartPrint += new PrintDocumentEventHandler(PrintingSystem_StartPrint);

                List<XtraReport> reports = new List<XtraReport>();
                int check = 0;
                for (int i = 0; i < gvListNoPosition.DataRowCount; i++)
                {
                    if (gvListNoPosition.IsRowSelected(i))
                    {
                        int numberLabel = int.Parse(Math.Ceiling(decimal.Parse(gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[9]).NullString())).NullString());
                        for (int j = 0; j < numberLabel; j++)
                        {
                            string position = gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[0]).NullString();
                            string condition = gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[3]).NullString();
                            string lblPosition_condition = position + (position == "" ? "" : ".") + (condition == "NG" ? "NG" : "");
                            xml_content = xml_content.Replace("$BARCODE$", gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[8]).NullString()).Replace("$CODE$", gvListNoPosition.GetRowCellValue(i, gvListNoPosition.Columns[1]).NullString()).Replace("$POSITION$", lblPosition_condition);

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
                            i++;

                            check++;
                        }
                    }
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET_TEMP", new string[] { "A_CODE_TEMP" }, new string[] { "QRCODE" });
                if (m_ResultDB.ReturnInt == 0)
                {
                    label = base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["LABEL"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            POP.IMPORT_EXCEL popup = new POP.IMPORT_EXCEL();
            popup.stock_code = stlKho.EditValue.NullString();
            popup.ShowDialog();
            ViewLocation();
        }

        /// <summary>
        /// Save file excel template to DB
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSaveFileTemp_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog dlg = new OpenFileDialog();
                dlg.Filter = "Excel Files (.xls*)|*.xls*";
                dlg.Multiselect = false;

                DialogResult dlgResult = dlg.ShowDialog();
                if (dlgResult == DialogResult.OK)
                {
                    string fileName = dlg.FileName;
                    byte[] bytes = File.ReadAllBytes(fileName);
                    string contentType = "";

                    switch (Path.GetExtension(fileName))
                    {
                        case ".xls":
                        case ".xlsx":
                            contentType = "application/vnd.ms-excel";
                            break;
                    }

                    base.m_ResultDB = base.m_DBaccess.ExcuteProcWithBytes("PKG_BUSINESS_FILE_TEMP.INSERT", new string[] { "A_FILENAME", "A_CONTENT_TYPE" }, "A_DATA", new string[] { Path.GetFileName(fileName), contentType }, bytes);
                    if (m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
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

        /// <summary>
        /// Download file
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnGetFileTemp_Click(object sender, EventArgs e)
        {
            try
            {
                byte[] bytes;
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_FILE_TEMP.GET_FILE", new string[] { "A_FILENAME" }, new string[] { "EWIP_SPAREPART_LOCATION.xlsx" });
                if (m_ResultDB.ReturnInt == 0)
                {
                    bytes = (byte[])base.m_ResultDB.ReturnDataSet.Tables[0].Rows[0]["Data"];

                    Stream stream;
                    SaveFileDialog saveFileDialog = new SaveFileDialog();
                    saveFileDialog.Filter = "All files (*.*)|*.*";
                    saveFileDialog.FilterIndex = 1;
                    saveFileDialog.RestoreDirectory = true;
                    saveFileDialog.FileName = "EWIP_SPAREPART_LOCATION.xlsx";
                    if (saveFileDialog.ShowDialog() == DialogResult.OK)
                    {
                        stream = saveFileDialog.OpenFile();
                        stream.Write(bytes, 0, bytes.Length);
                        stream.Close();

                        MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    }
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

        private void cboFilterSparepart_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboFilterSparepart.SelectedIndex == 0) // Ton tai vi tri
            {
                gvListNoPosition.ActiveFilterString = "[LOCATION] != '' AND [LOCATION] IS NOT NULL";
            }
            else if (cboFilterSparepart.SelectedIndex == 1) // Dang cho
            {
                gvListNoPosition.ActiveFilterString = "[LOCATION] = '' OR [LOCATION] IS NULL";
            }
            else // All
            {
                gvListNoPosition.ActiveFilter.Clear();
            }
        }

        private void stlSparePartSearch_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(stlSparePartSearch.EditValue.NullString()))
                {
                    txtSearchNoLocation.EditValue = null;
                    cboFilterSparepart.EditValue = null;
                    stlSparePartSearch.EditValue = null;
                    ViewLocation();
                    return;
                }

                gvListNoPosition.ActiveFilter.Clear();
                gvListNoPosition.ActiveFilterString = "[SPARE_PART_CODE] = '" + stlSparePartSearch.EditValue.NullString()+"'";
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearchNoLocation.EditValue = null;
            cboFilterSparepart.EditValue = null;
            stlSparePartSearch.EditValue = null;
            ViewLocation();
        }
    }
}
