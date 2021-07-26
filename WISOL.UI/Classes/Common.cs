using PROJ_B_DLL.Objects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Wisol.Common;
using Wisol.Components;

namespace Wisol.MES.Classes
{
    public class Common
    {
        public static void GetEncriptCode()
        {
            try
            {
                ResultDB result = Program.dbAccess.ExcuteProc("PKG_BUSINESS_SPAREPART.ENCRIPT_CODE"
                    , new string[] { "A_DEPARTMENT" }
                    , new string[] { Consts.DEPARTMENT }
                    );

                if (result.ReturnInt == 0)
                {
                    Consts.SPAREPART_TO_ID = result.ReturnDataSet.Tables[0];
                }
                else
                {
                    Consts.SPAREPART_TO_ID = new DataTable();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
        }

        public static string GetSparepartCodeWithEncript(string codeEncript)
        {
            try
            {
                if (Regex.Match(codeEncript, @"[a-zA-Z]").Success)
                {
                    return codeEncript;
                }

                if (Consts.SPAREPART_TO_ID == null || Consts.SPAREPART_TO_ID.Rows.Count == 0)
                {
                    GetEncriptCode();
                }

                DataRow[] rows = Consts.SPAREPART_TO_ID.Select("[ENCRIPT_CODE] = '" + codeEncript + "'");
                if (rows != null && rows.Length == 1)
                {
                    return rows[0]["SPARE_PART_CODE"].NullString();
                }
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message, MsgType.Error);
            }
            return codeEncript;
        }
    }
}
