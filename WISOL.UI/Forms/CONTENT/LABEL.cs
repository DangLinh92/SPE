using DevExpress.XtraReports.UI;
using System;
using System.Drawing;
using System.Drawing.Printing;
using System.IO;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class LABEL : PageType
    {
        public LABEL()
        {
            InitializeComponent();
        }
        public override void Form_Show()
        {
            base.Form_Show();
            this.InitializePage();
            Classes.Common.SetFormIdToButton(this, "LABEL");
        }
        public override void InitializePage()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET", new string[] { }, new string [] {  });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvList.Columns["ID"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["ID"].DisplayFormat.FormatString = "n0";
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            base.InitializePage();
        }

        private void Init_Control(bool condFlag)
        {
            try
            {
                txtCode.EditValue = string.Empty;
                txtDesc.EditValue = string.Empty;
                txtXml.EditValue = string.Empty;
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
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.GET", new string[] { }, new string[] { });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    base.m_BindData.BindGridView(gcList, base.m_ResultDB.ReturnDataSet.Tables[0]);
                    gvList.Columns["ID"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                    gvList.Columns["ID"].DisplayFormat.FormatString = "n0";
                    gvList.Columns["LABEL"].Visible = false;
                    this.Init_Control(true);
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
                if (string.IsNullOrEmpty(txtCode.EditValue.NullString()) == true || string.IsNullOrEmpty(txtXml.EditValue.NullString()) == true){
                    MsgBox.Show("MSG_ERR_102".Translation(), MsgType.Warning);
                    return;
                }
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.PUT",
                    new string[] { "A_CODE", "A_LABEL", "A_DESC" },
                    new string[] { txtCode.EditValue.NullString(), txtXml.EditValue.NullString(), txtDesc.EditValue.NullString() });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    SearchPage();
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
            this.Init_Control(true);
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (txtCode.Text.Trim() == string.Empty)
            {
                return;
            }
            DialogResult dialogResult = MsgBox.Show("MSG_COM_015".Translation(), MsgType.Warning, DialogType.OkCancel);
            if (dialogResult == DialogResult.OK)
            {
                try
                {
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_LABEL.DELETE", new string[] { "A_CODE" }, new string[] { txtCode.EditValue.NullString() });
                    if (base.m_ResultDB.ReturnInt == 0)
                    {
                        MsgBox.Show(base.m_ResultDB.ReturnString.Translation(), MsgType.Information);
                        SearchPage();
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

        private void btnPrint_Click(object sender, EventArgs e)
        {
                string designFile = string.Empty;
                string xml_content_Original = string.Empty;
                string xml_content = txtXml.EditValue.NullString();

                try
                {
                    designFile = "STOCK_LABEL.xml";


                    XtraReport reportPrint = new XtraReport();
                    
                        xml_content = xml_content.Replace("$NAME$", "A-2-2-2");
                        xml_content = xml_content.Replace("$BARCODE$", "TEST");

                        xml_content = xml_content.Replace("&", "&amp;");
                File.WriteAllText((1).NullString() + designFile, xml_content);


                reportPrint.LoadLayoutFromXml((1).NullString() + designFile);
                reportPrint.PrintingSystem.ShowPrintStatusDialog = false;
                reportPrint.PrintingSystem.ShowMarginsWarning = false;

                        int leftMargine = reportPrint.Margins.Left + 0;
                        int rightMargine = reportPrint.Margins.Right;
                        int topMargine = reportPrint.Margins.Top + 0;
                        int bottomMargine = reportPrint.Margins.Bottom;
                        if (leftMargine < 0)
                        {
                            leftMargine = 0;
                        }
                        if (topMargine < 0)
                        {
                            topMargine = 0;
                        }
                reportPrint.Margins = new System.Drawing.Printing.Margins(leftMargine, rightMargine, topMargine, bottomMargine);
                reportPrint.CreateDocument();
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
                    txtCode.EditValue = gvList.GetDataRow(e.RowHandle)["CODE"].NullString();
                    txtXml.EditValue = gvList.GetDataRow(e.RowHandle)["LABEL"].NullString();
                    txtDesc.EditValue = gvList.GetDataRow(e.RowHandle)["DESC"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
