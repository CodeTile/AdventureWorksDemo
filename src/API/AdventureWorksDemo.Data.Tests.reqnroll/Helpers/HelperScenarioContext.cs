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

            internal static dynamic Get(ScenarioContextKey key) => Context!.Get<dynamic>(key.ToString());

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

                return retval;
            }

            internal static bool GetFlag(ScenarioContextKey key)
            {
                if (Context == null)
                    return false;

                return Context!.ContainsKey(key.ToString());
            }

            internal static bool KeyExists(ScenarioContextKey key)
            {
                return Context!.ContainsKey(key.ToString());
            }

            internal static void UpdateFlag(ScenarioContextKey key, bool flag)
            {
                if (Context != null)
                {
                    Context!.Remove(key.ToString());

                    AddToContext(key, flag);
                }
            }
        }
    }
}