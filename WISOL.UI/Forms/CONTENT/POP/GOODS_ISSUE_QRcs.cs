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
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class GOODS_ISSUE_QRcs : FormType
    {
        private DataTable STATUS = new DataTable();

        public GOODS_ISSUE_QRcs()
        {
            InitializeComponent();
        }

        private void GOODS_ISSUE_QRcs_Load(object sender, EventArgs e)
        {
            STATUS.Columns.Add("CODE");
            STATUS.Columns.Add("NAME");
            STATUS.Rows.Add("NEW", "TẠO MỚI");
            STATUS.Rows.Add("INPROGRESS", "ĐANG XỬ LÝ");
            STATUS.Rows.Add("COMPLETE", "HOÀN THÀNH");
            base.mBindData.BindGridLookEdit(stlStatus, STATUS, "CODE", "NAME");
        }

        private void Init()
        {
            dateInput.EditValue = DateTime.Now;
            base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP_INVENTORY.GET", new string[] { "A_DEPARTMENT" }, new string[] { Consts.DEPARTMENT });

            if(mResultDB.ReturnInt == 0)
            {
                DataTableCollection datas = base.mResultDB.ReturnDataSet.Tables;
                base.mBindData.BindGridLookEdit(stlSparepart, datas[1], "CODE", "NAME_VI");
                base.mBindData.BindGridLookEdit(stlKho, datas[2], "CODE", "NAME");
                base.mBindData.BindGridLookEdit(stlUnit, datas[3], "CODE", "NAME");
                stlKho.EditValue = datas[2].Rows[0]["CODE"].NullString();
            }
        }
    }
}
