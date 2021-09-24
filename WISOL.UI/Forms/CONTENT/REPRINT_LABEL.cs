using DevExpress.XtraEditors.Repository;
using DevExpress.XtraGrid.Columns;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.XtraReports.UI;
using DevExpress.XtraTreeList.Nodes;
using System;
using System.Collections.Generic;
using System.IO;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class REPRINT_LABEL : PageType
    {
        public string label = string.Empty;
        public REPRINT_LABEL()
        {
            InitializeComponent();
        }

        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            Classes.Common.SetFormIdToButton(this, "REPRINT_LABEL");
        }

        public override void InitializePage()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_REPRINT.INIT_LIST", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridLookEdit(sltSparePart, base.m_ResultDB.ReturnDataSet.Tables[1], "CODE", "NAME_VI");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
            Init_Control(true);
        }
        private void Init_Control(bool condFlag)
        {
            try
            {
                DateTime date = DateTime.Now;
                sltSparePart.EditValue = string.Empty;
                dtDate.EditValue = date.ToString("yyyy-MM-dd");
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
        public override void SearchPage()
        {
            base.SearchPage();
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_REPRINT.GET", new string[] { "A_DEPARTMENT", "A_ROLE", "A_SP", "A_DATE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, sltSparePart.EditValue.NullString(), dtDate.DateTime.ToString("yyyyMMdd") });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcStockin, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvStockin.Columns["ID"].Visible = false;

                    gvStockin.Columns["QUANTITY"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvStockin.Columns["QUANTITY"].DisplayFormat.FormatString = "n0";


                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvStockin_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                {
                    return;
                }
                else
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_REPRINT.GET_LOT", 
                        new string[] { "A_DEPARTMENT", "A_ROLE", "A_STOCKIN" }, 
                        new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole, gvStockin.GetDataRow(e.RowHandle)["ID"].NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        base.m_BindData.BindTreeList(treeList1, base.m_ResultDB.ReturnDataSet.Tables[0], true, "LOT_NO, CREATED_AT");

                        label = base.m_ResultDB.ReturnDataSet.Tables[1].Rows[0]["LABEL"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            
        }
        private void btnPrintLabel_Click(object sender, EventArgs e)
        {
            string designFile = string.Empty;
            string xml_content_Original = label;
            string xml_content = string.Empty;

            try
            {
                designFile = "STOCKIN_LABEL.xml";

                XtraReport reportPrint = new XtraReport();
                int i = 0;
                foreach (TreeListNode n in treeList1.GetAllCheckedNodes())
                {
                    string[] arrListStr = n.GetValue("LOT_NO").ToString().Split('.');

                    xml_content = xml_content_Original.Replace("$NAME$", (arrListStr[0] + '.' + arrListStr[1] + arrListStr[2]).ToString().ToUpper());
                    xml_content = xml_content.Replace("$BARCODE$", n.GetValue("LOT_NO").ToString().ToUpper());
                    xml_content = xml_content.Replace("$LOCATION$", n.GetValue("LOCATION").ToString().ToUpper());

                    xml_content = xml_content.Replace("&", "&amp;");
                    File.WriteAllText((i + 1).NullString() + designFile, xml_content);

                    XtraReport report = new XtraReport();

                    report.PrintingSystem.ShowPrintStatusDialog = false;
                    report.PrintingSystem.ShowMarginsWarning = false;

                    report.LoadLayoutFromXml((i + 1).NullString() + designFile);
                    int leftMargine = report.Margins.Left + 2;
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
                    reportPrint.Pages.AddRange(report.Pages);
                    File.Delete((i + 1).NullString() + designFile);
                    i++;
                }

                reportPrint.PrintingSystem.ShowPrintStatusDialog = false;
                reportPrint.PrintingSystem.ShowMarginsWarning = false;
                reportPrint.Print();
                reportPrint.PrintingSystem.ExecCommand(DevExpress.XtraPrinting.PrintingSystemCommand.Parameters, new object[] { true });
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            Init_Control(true);
        }
    }
}
