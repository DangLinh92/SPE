﻿using System;
using System.Data;
using System.Linq;
using Wisol.Common;
using Wisol.Components;
using Wisol.MES.Inherit;

namespace Wisol.MES.Forms.CONTENT.POP
{
    public partial class HISTORY_GOOD_RE_ISS : FormType
    {
        public HISTORY_GOOD_RE_ISS()
        {
            InitializeComponent();
            this.Load += HISTORY_GOOD_RE_ISS_Load;
        }

        private void HISTORY_GOOD_RE_ISS_Load(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_SP.GET",
                    new string[] { "A_DEPARTMENT" },
                    new string[] { Consts.DEPARTMENT });

                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    base.mBindData.BindGridLookEdit(stlSparepart, data, "CODE", "NAME_VI", "NAME_KR,SPECIFICATION,GL_ACCOUNT,COST_CTR,VENDER_NAME,UNIT,TYPENAME,CODE_MERGED,STAGE");
                }

                Classes.Common.SetFormIdToButton(null, "HISTORY_GOOD_RE_ISS", this);
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public string Kho { get; set; }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                base.mResultDB = base.mDBaccess.ExcuteProc("PKG_BUSINESS_GOODS_RECEIPT_ISSUE.HISTORY_BY_CODE",
                    new string[] { "A_DEPT_CODE", "A_STOCK_CODE", "A_SPARE_PART", "A_TIME_FROM", "A_TIME_TO" },
                    new string[] { Consts.DEPARTMENT, Kho, stlSparepart.EditValue.NullString(), dateFrom.EditValue.NullString(), dateTo.EditValue.NullString() });
                if (mResultDB.ReturnInt == 0)
                {
                    DataTable data = mResultDB.ReturnDataSet.Tables[0];
                    base.mBindData.BindGridView(gcList, data);
                    gvList.OptionsView.ColumnAutoWidth = true;
                }
                else
                {
                    MsgBox.Show(mResultDB.ReturnString.Translation(), MsgType.Warning);
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }
    }
}
