using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using PertentoBI.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

public class DataLookup
{


    public static SelectedData get_Lookup(Session session, string tableName, string valueColumn = "", string descriptionColumn = "", string orderColumn = "", string filterRows = "", bool DISTINCT = false, string AdditionalColumns = "")
    {

        try
        {

            if (string.IsNullOrEmpty(valueColumn.Trim()))
            {
                valueColumn = "ID";
            }
            if (string.IsNullOrEmpty(descriptionColumn.Trim()))
            {
                descriptionColumn = "Description";
            }

            StringBuilder strSQL = new StringBuilder("");

            if (!string.IsNullOrEmpty(AdditionalColumns.Trim(' ')))
            {
                AdditionalColumns = AdditionalColumns.TrimStart(" ,"[0]).TrimEnd(" ,"[0]);
                AdditionalColumns = string.IsNullOrEmpty(AdditionalColumns.Trim(' ')) ? "" : ", " + AdditionalColumns;
            }

            if ((string.IsNullOrEmpty(orderColumn)) && (DISTINCT == false))
            {
                DISTINCT = true;
            }

            if (DISTINCT)
            {
                strSQL.AppendLine("SELECT DISTINCT " + valueColumn + ((valueColumn == descriptionColumn) ? "" : ", " + descriptionColumn + "") + AdditionalColumns + " FROM " + tableName + "");
            }
            else
            {
                strSQL.AppendLine("SELECT " + valueColumn + ((valueColumn == descriptionColumn) ? "" : ", " + descriptionColumn + "") + AdditionalColumns + " FROM " + tableName + "");
            }

            if (!string.IsNullOrEmpty(filterRows.Trim()))
            {
                strSQL.AppendLine(" WHERE " + filterRows);
            }

            if (!string.IsNullOrEmpty(orderColumn.Trim()))
            {
                strSQL.AppendLine(" ORDER BY " + orderColumn);
            }
            else
            {
                strSQL.AppendLine(" ORDER BY " + descriptionColumn);
            }

            //Dim f As New System.IO.StreamWriter("c:\t.txt", True)
            //f.WriteLine(strSQL & vbCrLf & "=============" & vbCrLf)
            //f.Flush()
            //f.Close()

            SelectedData data = session.ExecuteQueryWithMetadata(strSQL.ToString());

            return data;
        }
        catch (Exception ex)
        {

         
            return null;

        }


    }

    public static string GetJSONString(DataTable Dt)
    {

        string[] StrDc = new string[Dt.Columns.Count];

        StringBuilder Sb = new StringBuilder();

        Sb.Append("[");
        for (int row = 0; row < Dt.Rows.Count; row++)
        {

            string tmp = "";

            if (row > 0)
            {
                Sb.Append(",");
            }

            for (int col = 0; col < Dt.Columns.Count; col++)
            {

                tmp += string.IsNullOrEmpty(tmp) ? "" : ",";

                if (NumericHelper.IsNumeric(Dt.Rows[row][col]))
                {
                    tmp += (string.Format("{0}:{1}", Dt.Columns[col].ColumnName.Replace(" ", ""), HelperFunctions.Catchnull(Dt.Rows[row][col], 0)));
                }
                else
                {
                    tmp += (string.Format("{0}:\"{1}\"", Dt.Columns[col].ColumnName.Replace(" ", ""), HelperFunctions.Catchnull(Dt.Rows[row][col], 0)));
                }

            }

            Sb.Append("{" + tmp + "}");

        }

        Sb.Append("]");

        return Sb.ToString();

    }


}
