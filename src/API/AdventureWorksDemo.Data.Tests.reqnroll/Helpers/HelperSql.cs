using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        public static class Sql
        {
            internal static string[] SplitSqlQueryOnGo(string query)
            {
                return query.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            }
        }
    }
}