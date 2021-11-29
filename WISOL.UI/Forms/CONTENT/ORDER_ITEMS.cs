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
    public partial class ORDER_ITEMS : PageType
    {
        public ORDER_ITEMS()
        {
            InitializeComponent();
            this.Load += ORDER_ITEMS_Load;
        }

        private void ORDER_ITEMS_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "ORDER_ITEMS");
            InitData();
        }

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.GETALL", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });
                if (base.m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = base.m_ResultDB.ReturnDataSet.Tables;

                    m_BindData.BindGridView(gcList, datas[0]);
                    //gcList.DataSource = datas[0];
                    gvList.OptionsView.ColumnAutoWidth = true;

                    m_BindData.BindGridLookEdit(stlStatus, datas[1], "CODE", "NAME");
                    m_BindData.BindGridLookEdit(stlSparepart, datas[2], "CODE", "NAME_VI");
                    m_BindData.BindGridLookEdit(stlMrp, datas[3], "MRP_CODE", "MRP_CODE");
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnReload_Click(object sender, EventArgs e)
        {
            InitData();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlMrp.EditValue.NullString() == "" ||
                    stlSparepart.EditValue.NullString() == "" ||
                    stlStatus.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                if(!(dateEndActual.EditValue.NullString() != "" && DateTime.TryParse(dateEndActual.EditValue.NullString(), out _)))
                {
                    dateEndActual.EditValue = "";
                }

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_MRP.UPDATE_STATUS",
                    new string[]
                    {
                        "A_PR_CODE",
                        "A_MRP_CODE",
                        "A_SPARE_PART_CODE",
                        "A_STATUS",
                        "A_DEPARTMENT",
                        "A_USER",
                        "A_DATE_END_ACTUAL"
                    },
                    new string[]
                    {
                        txtPR_CODE.EditValue.NullString(),
                        stlMrp.EditValue.NullString(),
                        stlSparepart.EditValue.NullString(),
                        stlStatus.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        Consts.USER_INFO.Id,
                        dateEndActual.EditValue.NullString()
                    });

                if (base.m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    Clear();
                    btnReload.PerformClick();

                    if (rowHandle >= 0)
                    {
                        gvList.MakeRowVisible(rowHandle);
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

        private void Clear()
        {
            stlMrp.EditValue = "";
            stlSparepart.EditValue = "";
            stlStatus.EditValue = "";
            txtPR_CODE.EditValue = "";
            dateEndActual.EditValue = null;
        }

        int rowHandle = -1;
        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0) return;

                rowHandle = e.RowHandle;

                stlSparepart.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPAREPART_CODE").NullString();
                stlMrp.EditValue = gvList.GetRowCellValue(e.RowHandle, "MRP_CODE").NullString();
                stlStatus.EditValue = gvList.GetRowCellValue(e.RowHandle, "STATUS").NullString();
                txtPR_CODE.EditValue = gvList.GetRowCellValue(e.RowHandle, "PR_CODE").NullString();
                if (gvList.GetRowCellValue(e.RowHandle, "DATE_END_ACTUAL").NullString() != "")
                {
                    dateEndActual.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_END_ACTUAL").NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void gvList_RowCellStyle(object sender, DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs e)
        {
            if (e.Column.FieldName == "STATUS")
            {
                switch (e.CellValue.NullString())
                {
                    case "COMPLETE":
                        e.Appearance.BackColor = Color.FromArgb(46, 204, 113);
                        break;
                    case "NEW":
                        e.Appearance.BackColor = Color.FromArgb(254, 245, 231);
                        break;
                    case "WAIT_ACCEPT":
                        e.Appearance.BackColor = Color.FromArgb(245, 203, 167);
                        break;
                    case "ACCEPT":
                        e.Appearance.BackColor = Color.FromArgb(212, 239, 223);
                        break;
                    case "PUR_RECEIPT":
                        e.Appearance.BackColor = Color.FromArgb(162, 217, 206);
                        break;
                    case "ORDER":
                        e.Appearance.BackColor = Color.FromArgb(115, 198, 182);
                        break;
                    case "SHIPPING":
                        e.Appearance.BackColor = Color.FromArgb(133, 193, 233);
                        break;
                    case "RECEIVE":
                        e.Appearance.BackColor = Color.FromArgb(46, 204, 113);
                        break;
                    case "CANCEL":
                        e.Appearance.BackColor = Color.FromArgb(202, 207, 210);
                        break;
                }
            }
        }
    }
}
