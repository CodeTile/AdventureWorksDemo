using System.Collections;
using System.Reflection;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.Tests.reqnroll.enums;
using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;
using AdventureWorksDemo.Data.Tests.reqnroll.Models;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using AdventureWorksDemo.Data.Paging;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    [Binding]
    public class StepDefinitions
    {
        public StepDefinitions(ScenarioContext scenarioContext)
        {
            Helper.ScenarioContexts.Context = scenarioContext;
        }

        [Given("The service to test is {string}")]
        public void GivenTheServiceToTestIs(string uotName)
        {
            switch (uotName)
            {
                case "AdventureWorksDemo.Data.Services.IProductCategoryService":
                case "AdventureWorksDemo.Data.Services.ProductCategoryService":
                    Helper.ScenarioContexts.AddToContext(ScenarioContextKey.UOT, Helper.Ioc.ResolveObject<IProductCategoryService>());
                    break;

                default:
                    break;
                    throw new PendingStepException("Unknown service to Test");
            }
        }

        [Then("the exception message is")]
        public void ThenTheExceptionMessageIs(DataTable dataTable)
        {
            var actual = new List<ValueExpectedResult>()
            {
                new ValueExpectedResult(){
                Expected = ((Exception)Helper.ScenarioContexts.GetResult).Message ,
                }
            };
            dataTable.CompareToSet(actual);
        }

        [Then("the PagedList values are")]
        public void ThenThePagedListValuesAre(DataTable expected)
        {
            IPagedList actual = (IPagedList)Helper.ScenarioContexts.GetResult;
            expected.CompareToInstance(actual);
        }

        [Then("the result is")]
        public void ThenTheResultIs(DataTable table)
        {
            var contextResult = Helper.ScenarioContexts.GetResult;

            string? resultTypeName = contextResult.GetType().FullName;
            switch (resultTypeName)
            {
                case "System.Boolean":
                    table.CompareToSet(new List<ValueExpectedResult>() { new ValueExpectedResult() { Expected = ((bool)contextResult).ToString() } });
                    break;

                case "System.Exception":
                    table.CompareToSet(new List<string>() { resultTypeName });
                    break;

                case "AdventureWorksDemo.Data.Models.ProductCategoryModel":
                    table.CompareToSet(new List<ProductCategoryModel> { (ProductCategoryModel)contextResult });
                    break;

                default:
                    throw new NotImplementedException($"Type [{resultTypeName}] is not implemented!");
            }
        }

        [Then("the result is null")]
        public void ThenTheResultIsNull()
        {
            Assert.IsNull(Helper.ScenarioContexts.GetResult);
        }

        [Then(@"the result is of type")]
        public virtual void ThenTheResultIsOfType(DataTable table)
        {
            var expected = table.Rows.Single()["Expected"];
            if (!expected.Contains("."))
            {
                throw new ArgumentException($"Expected type '{expected}' must contain the namespace!");
            }
            var results = new List<ValueExpectedResult>()
            {
                new ValueExpectedResult(){
                Expected = Helper.ScenarioContexts.GetContextResultTypeName() ,
                }
            };

            table.CompareToSet(results);
        }

        [Then("the results are")]
        public void ThenTheResultsAre(DataTable table)
        {
            IEnumerable actual = (IEnumerable)Helper.ScenarioContexts.GetResult;
            string? resultTypeName = Helper.ScenarioContexts.GetContextResultTypeName();

            if (actual is Array)
                resultTypeName = resultTypeName!.ToString().Split('[')[0];
            else
                resultTypeName = resultTypeName!.ToString().Replace("`1", "").Replace("[", "<").Replace("]", ">")
                                                    .Replace(">", "")
                                                    .Split('<')[1];

            switch (resultTypeName)
            {
                case "System.Exception": table.CompareToSet(new List<string>() { resultTypeName }); break;
                case "AdventureWorksDemo.Data.Models.ProductCategoryModel": table.CompareToSet((IEnumerable<ProductCategoryModel>)actual); break;
                default: throw new NotImplementedException($"Type [{resultTypeName}] is not implemented!");
            }
        }

        [When("I call the method {string} with the parameter values")]
        public async Task WhenICallTheMethodWithTheParameterValuesAsync(string methodName, DataTable table)
        {
            // await Task.Delay(0);
            if (table.Rows.Count == 0)
            {
                throw new Exception("Table is empty");
            }
            var methodParameters = GetParametersFromDataTable(table);
            var uot = Helper.ScenarioContexts.GetUot;

            var result = await GetMethodValueForObjectAsync(uot,
                                                            methodName,
                                                            methodParameters);
            if (result.Item1.FullName.Contains("Task"))
            {
                var t = result.Item1.GenericTypeArguments.FirstOrDefault();
                Helper.ScenarioContexts.AddToContext(ScenarioContextKey.ResultType, t);
            }
            else
                Helper.ScenarioContexts.AddToContext(ScenarioContextKey.ResultType, result.Item1);

            Helper.ScenarioContexts.AddToContext(ScenarioContextKey.Result, result.Item2);
        }

        [When("I populate the model {string}")]
        public void WhenIPopulateTheModel(string modelTypeName, DataTable dataTable)
        {
            var model = Helper.Types.PopulateModelFromRow(modelTypeName, dataTable.Rows[0], null);
            Helper.ScenarioContexts.AddToContext(ScenarioContextKey.Model, model);
        }

        private object? GetArgumentValue(DataTableRow row)
        {
            return GetArgumentValue(row["Value"].Trim(),
                                    row["TypeName"].Trim()
                );
        }

        private object? GetArgumentValue(string value, string typeName)
        {
            if (value.StartsWith("{{"))
            {
                return value switch
                {
                    // "{{FilterParams}}" => (AdventureWorksDemo.Data.Paging.PagingFilter)Helper.GetContext(Helpers.StepsHelperBase.ContextKey.FilterParams),
                    //"{{entity}}" => Helper.GetContextEfEntity(),
                    //"{{ListOfObjects}}" => Helper.GetContextListOfObjects(),
                    "{{model}}" => Helper.ScenarioContexts.GetModel,
                    "{{null}}" => null,
                    _ => throw new ArgumentOutOfRangeException($"Value '{value}' is unhandled!"),
                };
            }
            Type T = typeName switch
            {
                "System.Int32" or "int" => typeof(Int32),
                "System.string" or "string" => typeof(string),
                "System.DateTime" or "DateTime" => typeof(DateTime),
                "bool" or "boolean" or "System.Boolean" => typeof(System.Boolean),
                _ => throw new ArgumentOutOfRangeException($"Type [{typeName}] is unhandled!"),
            };
            if (!value.Equals("null", StringComparison.OrdinalIgnoreCase))
                return Convert.ChangeType(value, T);
            return default;
        }

        private async Task<Tuple<Type, object>> GetMethodValueForObjectAsync(dynamic target,
                                                        string methodName,
                                                        KeyValueTypeName[] arguments)
        {
            Tuple<Type, object> retval = null;
            await Task.Delay(0);
            Type t = target.GetType();
            Type[] parameterTypes = new Type[arguments.Count()];
            for (int i = 0; i < arguments.Count(); i++)
            {
                parameterTypes[i] = Helper.Types.GetTypeByName(arguments[i]?.TypeName);
            }

            var method = t.GetMethod(methodName, parameterTypes);
            if (method == null)
                throw new ArgumentOutOfRangeException($"Can not find method [{methodName}] with matching parameters!");

            var args = new List<object>();
            ParameterInfo[] pars = method.GetParameters();
            for (int i = 0; i < pars.Count(); i++)
            {
                args.Add(arguments[i].Value);
            }
            try
            {
                retval = await InvokeMethodReturnValue(target, args.ToArray(), method);
            }
            catch (Exception ex)
            {
                retval = new Tuple<Type, object>(ex.GetType(), ex);
            }
            return retval;
        }

        private KeyValueTypeName[] GetParametersFromDataTable(DataTable table)
        {
            var args = new List<KeyValueTypeName>();
            foreach (DataTableRow? row in table.Rows)
            {
                var local = new KeyValueTypeName()
                {
                    Key = row[nameof(KeyValueTypeName.Key)].Trim(),
                    TypeName = row[nameof(KeyValueTypeName.TypeName)].Trim(),
                    Value = GetArgumentValue(row)
                };
                args.Add(local);
            }
            return args.ToArray();
        }

        private async Task<dynamic> InvokeMethod(object target, object[] args, dynamic method)
        {
            dynamic actionResult;
            if (await IsMethodAsync(method))
            {
                actionResult = await method.Invoke(target, args);
            }
            else
            {
                var nonAsyncResult = method.Invoke(target, args);
                try
                {
                    if (!typeof(IEnumerable).IsAssignableFrom(nonAsyncResult))
                    {
                        actionResult = nonAsyncResult;
                    }
                    else
                    {
                        actionResult = nonAsyncResult.Expression.Value;
                    }
                }
                catch (Exception)
                {
                    //try
                    //{
                    //    actionResult = GetInstanceField(nonAsyncResult, "_expression") ?? nonAsyncResult;
                    //}
                    //catch (Exception)
                    //{
                    actionResult = nonAsyncResult;
                    // }
                }
            }

            return actionResult;
        }

        private async Task<Tuple<Type, object>> InvokeMethodReturnValue(object target, object[] args, dynamic method)
        {
            dynamic actionResult = await InvokeMethod(target, args, method);

            if (actionResult == null)
            {
                Type a = ((MethodInfo)method).ReturnType;
                return new Tuple<Type, object>(a, null);
            }
            else
            {
                return new Tuple<Type, object>(actionResult.GetType(), actionResult);
            }
        }

        private async Task<bool> IsMethodAsync(dynamic method)
        {
            await Task.Delay(0);
            IReadOnlyCollection<CustomAttributeData> r = method.CustomAttributes;
            return r.Any(w => w.AttributeType?.Name == "AsyncStateMachineAttribute");
        }
    }
}