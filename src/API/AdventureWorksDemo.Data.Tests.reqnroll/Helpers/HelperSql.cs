using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Data.Tests.reqnroll.Hooks;

using Microsoft.Data.SqlClient;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        internal static class Sql
        {
            internal static System.Data.DataTable GetDataTable(string query)
            {
                var sqlConn = new SqlConnection(DockerMsSqlServerDatabase.Current!.ConnectionString);

                System.Data.DataTable dt = null;
                using (sqlConn)
                using (var cmd = new SqlCommand(query, sqlConn))
                {
                    sqlConn.Open();
                    // create data adapter
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    // this will query your database and return the result to your datatable
                    dt = new System.Data.DataTable();
                    da.Fill(dt);
                    sqlConn.Close();
                    da.Dispose();
                }
                return dt;
            }

            internal static List<T> GetDataTableAsList<T>(string query)
            {
                var dt = GetDataTable(query);
                return ConvertDataTable<T>(dt);
            }

            internal static string[] SplitSqlQueryOnGo(string query)
            {
                return query.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            }

            private static List<T> ConvertDataTable<T>(System.Data.DataTable dt)
            {
                var data = new List<T>();
                foreach (DataRow row in dt.Rows)
                {
                    T item = GetItem<T>(row);
                    data.Add(item);
                }
                return data;
            }

            private static T GetItem<T>(DataRow dr)
            {
                Type temp = typeof(T);
                T obj = Activator.CreateInstance<T>();
                foreach (DataColumn column in dr.Table.Columns)
                {
                    foreach (PropertyInfo pro in temp.GetProperties()
                                                     .Where(m => m.Name.Equals(column.ColumnName, StringComparison.CurrentCultureIgnoreCase)))
                    {
                        var colValue = dr[column.ColumnName] ?? "";
                        if (colValue is System.DBNull)
                            pro.SetValue(obj, null, null);
                        else
                            pro.SetValue(obj, colValue, null);
                    }
                }
                return obj;
            }
        }
    }
}