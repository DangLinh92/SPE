using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT
{
    public partial class GOC_PLANT : PageType
    {
        public GOC_PLANT()
        {
            InitializeComponent();
            this.Load += GOC_PLANT_Load;
        }

        private void GOC_PLANT_Load(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GOC_PLANT.INIT",
                                  new string[] { "A_DEPARTMENT", "A_DATE" },
                                  new string[] { Consts.DEPARTMENT, DateTime.Now.ToString("yyyyMMdd") });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    gvList.OptionsView.ColumnAutoWidth = true;
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

        private void btnGetFileTemp_Click(object sender, EventArgs e)
        {
            try
            {
                string fileName = "";

                if(Consts.DEPARTMENT == Consts.SMT_DEPT)
                {
                    fileName = "GOC_PLANT_SMT.xlsx";
                }

                string url = Application.StartupPath + @"\\" + fileName;

                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.Filter = "All files (*.*)|*.*";
                saveFileDialog.FilterIndex = 1;
                saveFileDialog.RestoreDirectory = true;
                saveFileDialog.FileName = fileName;

                if (saveFileDialog.ShowDialog() == DialogResult.OK)
                {
                    using (WebClient web1 = new WebClient())
                        web1.DownloadFile(url, saveFileDialog.FileName);
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
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
            popup.stock_code = "";
            popup.ImpportType = Consts.IMPORT_TYPE_GOC_PLAN;
            popup.ShowDialog();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_GOC_PLANT.SEARCH",
                                  new string[] { "A_DEPARTMENT", "A_DATE" },
                                  new string[] { Consts.DEPARTMENT, dateSearch.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];
                    m_BindData.BindGridView(gcList, data);
                    gvList.OptionsView.ColumnAutoWidth = true;
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
