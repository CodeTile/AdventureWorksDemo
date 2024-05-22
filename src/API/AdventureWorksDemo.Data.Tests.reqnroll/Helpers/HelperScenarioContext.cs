using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AdventureWorksDemo.Data.Tests.reqnroll.enums;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        internal static class ScenarioContexts
        {
            internal static ScenarioContext? Context { get; set; }

            internal static object GetModel => Context!.Get<object>(ScenarioContextKey.Model.ToString());

            internal static object GetResult => Context!.Get<object>(ScenarioContextKey.Result.ToString());

            internal static Type GetResultType => (Type)Context!.Get<object>(ScenarioContextKey.ResultType.ToString());

            internal static object GetUot => Context!.Get<object>(ScenarioContextKey.UOT.ToString());

            internal static void AddToContext(ScenarioContextKey key, object? value)
            {
                Context?.Add(key.ToString(), value);
            }

            internal static string GetContextResultTypeName()
            {
                Type resultType = GetResultType;
                string retval = resultType.FullName;
                if (resultType.Name.StartsWith("Tuple"))
                {
                    retval = "System.Tuple<";
                    foreach (Type item in resultType.GenericTypeArguments)
                    {
                        if (item.FullName!.EndsWith("[]"))
                            retval += item.FullName + ", ";
                        else
                            retval += item.ToString().Replace("`1[", "<").Split(',')[0].Replace("]", "") + ", ";
                    }
                    retval = (retval += ">").Replace(", >", ">");
                }
                else if (retval.Contains("`1[["))
                {
                    retval = retval.Replace("`1[[", "<").Split(',')[0] + ">";
                }

//#if DEBUG
//                if (retval.EndsWith("Exception"))
//                {
//                    Debug.WriteLine(((Exception)GetResult).Message);
//                    return ((Exception)GetResult).Message;
//                }
//#endif
                return retval;
            }
        }
    }
}