using System.Data;
using System.Reflection;

using Microsoft.Data.SqlClient;

namespace AdventureWorksDemo.Common.Tests.Helpers
{
	public static partial class CommonHelper
	{
		public static readonly string[] separator = ["GO\r\n"];

		public static partial class Sql
		{
			public static DataTable GetDataTable(string query)
			{
				var sqlConn = new SqlConnection(DockerMsSqlServerDatabase.Current!.ConnectionString);
				sqlConn.Open();
				using (sqlConn)
				using (var cmd = new SqlCommand(query, sqlConn))
				{
					// create data adapter
					SqlDataAdapter da = new(cmd);
					// this will query your database and return the result to your datatable
					DataTable dt = new();
					da.Fill(dt);
					//sqlConn.Close();
					da.Dispose();
					return dt;
				}
			}

			public static List<T> GetDataTableAsList<T>(string query)
			{
				var dt = GetDataTable(query);
				return ConvertDataTable<T>(dt);
			}

			public static string[] SplitSqlQueryOnGo(string query)
			{
				return query.Split(separator, StringSplitOptions.RemoveEmptyEntries);
			}

			private static List<T> ConvertDataTable<T>(DataTable dt)
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
						if (colValue is DBNull)
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