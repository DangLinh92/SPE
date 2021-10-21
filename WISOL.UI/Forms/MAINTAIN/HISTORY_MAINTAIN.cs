using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.MAINTAIN
{
    public partial class HISTORY_MAINTAIN : PageType
    {
        public HISTORY_MAINTAIN()
        {
            InitializeComponent();
            this.Load += HISTORY_MAINTAIN_Load;
        }

        private void HISTORY_MAINTAIN_Load(object sender, EventArgs e)
        {
            Classes.Common.SetFormIdToButton(this, "HISTORY_MAINTAIN");
            dateMaintain.EditValue = DateTime.Now;
            dateSuccess.EditValue = DateTime.Now;
            txtCondition_After.EditValue = "OK";

            if (EQUIPMENT_DATA == null)
            {
                EQUIPMENT_DATA = new DataTable();
                EQUIPMENT_DATA.Columns.Add("EQUIPMENT_ID");
                EQUIPMENT_DATA.Columns.Add("EQUIPMENT_NAME");
                EQUIPMENT_DATA.Columns.Add("EQUIPMENT_TYPE");
            }

            InitData();

            if (MainID.NullString() != "")
            {
                gvList.ActiveFilterString = "[EQUIPMENT_ID] = '" + MainID.NullString() + "'";
            }
        }

        DataTable EQUIPMENT_DATA;

        private void InitData()
        {
            try
            {
                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT_MAINTAIN.INIT", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTableCollection datas = m_ResultDB.ReturnDataSet.Tables;
                    m_BindData.BindGridLookEdit(stlCodeEquipment, datas[0], "EQUIPMENT_ID", "EQUIPMENT_NAME");
                    m_BindData.BindGridLookEdit(stlCodeSparepart, datas[1], "CODE", "NAME_VI", "IMAGE");

                    m_BindData.BindGridView(gcList, datas[2], false, "IMAGE_ERROR,MAINTAIN_ID");
                    gvList.Columns.Where(x => x.VisibleIndex <= gvList.Columns["EQUIPMENT_ID"].VisibleIndex).ToList().ForEach(x => x.Fixed = DevExpress.XtraGrid.Columns.FixedStyle.Left);

                    EQUIPMENT_DATA = datas[0];
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

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (stlCodeSparepart.EditValue.NullString() == "" || stlCodeEquipment.EditValue.NullString() == "")
                {
                    MsgBox.Show("MSG_ERR_044".Translation(), MsgType.Warning);
                    return;
                }

                string img = Convert.ToBase64String(ImageToByte(picError.Image));

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT_MAINTAIN.PUT",
                    new string[]
                    {   "A_ID",
                        "A_DEPARTMENT",
                        "A_EQUIPMENT_CODE",
                        "A_SPAREPART_CODE",
                        "A_DATE_MAINTAIN",
                        "A_SERIAL_PRE",
                        "A_DATE_IN_PRE",
                        "A_CONDITION_PRE",
                        "A_SERIAL_AFTER",
                        "A_DATE_IN_AFTER",
                        "A_CONDITION_AFTER",
                        "A_TIME_MAINTAIN",
                        "A_USER",
                        "A_USER_UPDATE",
                        "A_CAUSE_MAINTAIN",
                        "A_IMG_ERROR",
                        "A_DATE_SUCCESS",
                        "A_GANTRY_ID",
                        "A_SEGMENT_ID"
                    },
                    new string[]
                    { txtID.EditValue.NullString(),
                        Consts.DEPARTMENT,
                        stlCodeEquipment.EditValue.NullString(),
                        stlCodeSparepart.EditValue.NullString(),
                        dateMaintain.EditValue.NullString(),
                        txtSerialPre.EditValue.NullString(),
                        dateIn_Pre.EditValue.NullString(),
                        txtCondition_Pre.EditValue.NullString(),
                        txtSerial_After.EditValue.NullString(),
                        dateIn_after.EditValue.NullString(),
                        txtCondition_After.EditValue.NullString(),
                        spTimeMaintain.EditValue.NullString(),
                        txtUser.EditValue.NullString(),
                        Consts.USER_INFO.Id,
                        memoCause.EditValue.NullString(),
                        img,
                        dateSuccess.EditValue.NullString(),
                        txtGantryId.EditValue.NullString(),
                        txtSegmentID.EditValue.NullString()
                    });

                if (m_ResultDB.ReturnInt == 0)
                {
                    MsgBox.Show(m_ResultDB.ReturnString.Translation(), MsgType.Information);
                    InitData();
                    btnClear.PerformClick();
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

        public byte[] ImageToByte(Image img)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(img, typeof(byte[]));
        }

        private void stlCodeSparepart_EditValueChanged(object sender, EventArgs e)
        {
            try
            {
                string image = "";

                base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_SP.GET_IMG", new string[] { "A_DEPARTMENT", "A_CODE" }, new string[] { Consts.DEPARTMENT, stlCodeSparepart.EditValue.NullString() });

                if (m_ResultDB.ReturnInt == 0)
                {
                    DataTable data = m_ResultDB.ReturnDataSet.Tables[0];

                    image = data.Rows[0]["IMAGE"].NullString();
                    if (image != "")
                    {
                        byte[] imagebytes = Convert.FromBase64String(image);
                        using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                        {
                            picImage.Image = Image.FromStream(ms, true);
                        }
                        picImage.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                        picImage.Size = picImage.Image.Size;
                    }
                    else
                    {
                        picImage.Image = null;
                    }
                }
                else
                {
                    picImage.Image = null;
                }
            }
            catch (Exception)
            {
                picImage.Image = null;
            }
        }

        private void gvList_RowCellClick(object sender, DevExpress.XtraGrid.Views.Grid.RowCellClickEventArgs e)
        {
            try
            {
                if (e.RowHandle < 0)
                    return;

                txtID.EditValue = gvList.GetRowCellValue(e.RowHandle, "MAINTAIN_ID").NullString();
                stlCodeEquipment.EditValue = gvList.GetRowCellValue(e.RowHandle, "EQUIPMENT_ID").NullString();
                stlCodeSparepart.EditValue = gvList.GetRowCellValue(e.RowHandle, "SPARE_PART_CODE").NullString();

                if (gvList.GetRowCellValue(e.RowHandle, "DATE_MAINTAIN").NullString() != "1900-01-01")
                {
                    dateMaintain.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_MAINTAIN").NullString();
                }
                else
                {
                    dateMaintain.EditValue = "";
                }

                txtSerialPre.EditValue = gvList.GetRowCellValue(e.RowHandle, "SERIAL_PRE").NullString();
                txtSerial_After.EditValue = gvList.GetRowCellValue(e.RowHandle, "SERIAL_AFTER").NullString();
                txtCondition_Pre.EditValue = gvList.GetRowCellValue(e.RowHandle, "CONDITION_PRE").NullString();
                txtCondition_After.EditValue = gvList.GetRowCellValue(e.RowHandle, "CONDITION_AFTER").NullString();

                if (gvList.GetRowCellValue(e.RowHandle, "DATE_IN_PRE").NullString() == "1900-01-01")
                {
                    dateIn_Pre.EditValue = "";
                }
                else
                {
                    dateIn_Pre.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_IN_PRE").NullString();
                }

                if (gvList.GetRowCellValue(e.RowHandle, "DATE_IN_AFTER").NullString() == "1900-01-01")
                {
                    dateIn_after.EditValue = "";
                }
                else
                {
                    dateIn_after.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_IN_AFTER").NullString();
                }

                txtUser.EditValue = gvList.GetRowCellValue(e.RowHandle, "USER_MAINTAIN").NullString();
                spTimeMaintain.EditValue = gvList.GetRowCellValue(e.RowHandle, "TIME_MAINTAIN").NullString();
                dateSuccess.EditValue = gvList.GetRowCellValue(e.RowHandle, "DATE_SUCCESS").NullString();
                memoCause.EditValue = gvList.GetRowCellValue(e.RowHandle, "CAUSE_MAINTAIN").NullString();
                txtSegmentID.EditValue = gvList.GetRowCellValue(e.RowHandle, "SEGMENT_ID").NullString();
                txtGantryId.EditValue = gvList.GetRowCellValue(e.RowHandle, "GANTRY_ID").NullString();

                string img = gvList.GetRowCellValue(e.RowHandle, "IMAGE_ERROR").NullString();

                if (img != "")
                {
                    byte[] imagebytes = Convert.FromBase64String(img);
                    using (var ms = new MemoryStream(imagebytes, 0, imagebytes.Length))
                    {
                        picError.Image = Image.FromStream(ms, true);
                    }
                    picError.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch;
                    picError.Size = picError.Image.Size;
                }
                else
                {
                    picError.Image = null;
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                txtID.EditValue = "";
                stlCodeEquipment.EditValue = "";
                stlCodeSparepart.EditValue = "";
                dateMaintain.EditValue = "";
                txtSerialPre.EditValue = "";
                txtSerial_After.EditValue = "";
                txtCondition_Pre.EditValue = "";
                txtCondition_After.EditValue = "";
                dateIn_Pre.EditValue = "";
                dateIn_after.EditValue = "";
                txtUser.EditValue = "";
                spTimeMaintain.EditValue = "";
                dateSuccess.EditValue = "";
                memoCause.EditValue = "";

                picError.Image = null;
                picImage.Image = null;
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
                    if (txtID.EditValue.NullString() == "")
                        return;

                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_BUSINESS_EQUIPMENT_MAINTAIN.DELETE", new string[] { "A_ID" }, new string[] { txtID.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
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

        private void btnReload_Click(object sender, EventArgs e)
        {
            splashScreenManager1.ShowWaitForm();
            InitData();
            splashScreenManager1.CloseWaitForm();
        }

        private void txtSerialPre_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (e.KeyCode == Keys.Enter)
                {
                    m_DBaccess.connectionStringParam = 1;// using WHNP1 DB
                    base.m_ResultDB = base.m_DBaccess.ExcuteProc("PKG_ASM.ASM_SEGMENT_SPAREPART", new string[] { "A_SerialNumber" }, new string[] { txtSerialPre.EditValue.NullString() });

                    if (m_ResultDB.ReturnInt == 0)
                    {
                        DataTable data = m_ResultDB.ReturnDataSet.Tables[0];

                        if (data.Rows.Count > 0)
                        {
                            string machineName = data.Rows[0]["MachineName"].NullString();
                            string machineId = "";
                            foreach (DataRow row in EQUIPMENT_DATA.Rows)
                            {
                                if(row["EQUIPMENT_NAME"].NullString() == machineName)
                                {
                                    machineId = row["EQUIPMENT_ID"].NullString();
                                    break;
                                }
                            }

                            stlCodeEquipment.EditValue = machineId;

                            string dataInPre = data.Rows[0]["DateOfLastMaintenance"].NullString().Replace(".", "/");

                            dateIn_Pre.EditValue = DateTime.ParseExact(dataInPre, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                            txtGantryId.EditValue = data.Rows[0]["GantryID"].NullString();
                            txtSegmentID.EditValue = data.Rows[0]["SegmentID"].NullString();
                        }
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
    }
}
