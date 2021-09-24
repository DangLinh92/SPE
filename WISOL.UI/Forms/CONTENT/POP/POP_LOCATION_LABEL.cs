using DevExpress.XtraReports.UI;
using DevExpress.XtraTreeList.Nodes;
using System;
using System.IO;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class POP_LOCATION_LABEL : FormType
    {
        public string label = string.Empty;
        public POP_LOCATION_LABEL()
        {
            InitializeComponent();
            Init_Control();
        }
        private void Init_Control()
        {
            try
            {

                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_LOCATION@PRINT_LABEL", new string[] { "A_DEPARTMENT", "A_ROLE" }, new string[] { Consts.DEPARTMENT, Consts.USER_INFO.UserRole });
                if (mResultDB.ReturnInt == 0)
                {
                    treeList1.KeyFieldName = "CODE";
                    treeList1.ParentFieldName = "PARENT";
                    base.mBindData.BindTreeList(treeList1, base.mResultDB.ReturnDataSet.Tables[0], false, "CODE, PARENT");

                    label = base.mResultDB.ReturnDataSet.Tables[1].Rows[0]["LABEL"].ToString();
                }

                Classes.Common.SetFormIdToButton(null, "POP_LOCATION_LABEL", this);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            string designFile = string.Empty;
            string xml_content_Original = label;
            string xml_content = string.Empty;

            try
            {
                designFile = "STOCK_LABEL.xml";

                XtraReport reportPrint = new XtraReport();
                int i = 0;
                foreach (TreeListNode n in treeList1.GetAllCheckedNodes())
                {
                    xml_content = xml_content_Original.Replace("$NAME$", n.GetValue("LOCATION").ToString().ToUpper());
                    xml_content = xml_content.Replace("$BARCODE$", n.GetValue("CODE").ToString().ToUpper());

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
                    reportPrint.Pages.AddRange(report.Pages);
                    File.Delete((i + 1).NullString() + designFile);
                    i++;
                }
                reportPrint.PrintingSystem.ShowPrintStatusDialog = false;
                reportPrint.PrintingSystem.ShowMarginsWarning = false;
                //reportPrint.CreateDocument();
                //reportPrint.ShowPreview();
                reportPrint.Print();
                reportPrint.PrintingSystem.ExecCommand(DevExpress.XtraPrinting.PrintingSystemCommand.Parameters, new object[] { true });

            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }

        }
    }
}