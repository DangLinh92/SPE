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
    public partial class SPARE_PART_EXPORT : PageType
    {
        public SPARE_PART_EXPORT()
        {
            InitializeComponent();
            this.Load += SPARE_PART_EXPORT_Load;
        }

        private void SPARE_PART_EXPORT_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "SPARE_PART_EXPORT");
            LoadTemplate();
        }

        private void LoadTemplate()
        {
            IWorkbook workbook = speadSheetsControl.Document;
            workbook.BeginUpdate();

            workbook.LoadDocument("SPARE_PART_DATA_TEMP.xlsx");
            Worksheet sheet1 = workbook.Worksheets[0];
            GetDataForPRRequest(sheet1);
            workbook.EndUpdate();
        }

        private void GetDataForPRRequest(Worksheet sheet)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_DATA_TO_EXCEL",
                  new string[] { "A_DEPARTMENT" },
                  new string[] { Consts.DEPARTMENT});

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = base.m_ResultDB.ReturnDataSet.Tables[0];

                    for (int i = 0; i < data.Rows.Count; i++)
                    {
                        if (i > 0)
                        {
                            sheet.Rows[i + 1].CopyFrom(sheet.Rows[1], PasteSpecial.Formats);
                        }
                        Picture pic = sheet.Pictures.AddPicture(Classes.Common.GetImage(data.Rows[i]["IMAGE"].NullString()), sheet["H" + (2 + i)]);
                        sheet["F" + (2 + i)].Alignment.Horizontal = SpreadsheetHorizontalAlignment.Center;
                        sheet["F" + (2 + i)].Alignment.Vertical = SpreadsheetVerticalAlignment.Center;
                        pic.Placement = Placement.MoveAndSize;

                        pic.Width = (float)sheet["F" + (2 + i)].ColumnWidth - 80;
                        pic.Height = (float)sheet["F" + (2 + i)].RowHeight - 80;
                        pic.Move(40, 40);
                        data.Rows[i]["IMAGE"] = "";
                    }

                    sheet.DataBindings.BindToDataSource(data, 1, 0);
                }
                else
                {
                    MsgBox.Show(m_ResultDB.ReturnString, MsgType.Error);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog1 = new SaveFileDialog();

                saveFileDialog1.Filter = "excel files (*.xlsx)|*.xlsx";
                saveFileDialog1.FilterIndex = 2;
                saveFileDialog1.RestoreDirectory = true;

                if (saveFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    string fileName = saveFileDialog1.FileName;

                    // Save the modified document to a file.
                    IWorkbook workbook = speadSheetsControl.Document;
                    workbook.SaveDocument(fileName, DocumentFormat.Xlsx);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
