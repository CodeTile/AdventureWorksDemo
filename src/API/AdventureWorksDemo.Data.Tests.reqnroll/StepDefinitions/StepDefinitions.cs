using System;
using Reqnroll;
using AdventureWorksDemo.Data;
using AdventureWorksDemo.Data.StartUp;
using Microsoft.Extensions.DependencyInjection;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.Tests.reqnroll.enums;
using SpecFlow.Internal.Json;
using System.Reflection;
using System.Net.WebSockets;
using AdventureWorksDemo.Data.Models;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using AdventureWorksDemo.Data.Tests.reqnroll.Models;
using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;
using System.Collections;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    [Binding]
    public class StepDefinitions(
            //FeatureContext featureContext,
            ScenarioContext scenarioContext
        )
    {
        //private FeatureContext _featureContext = featureContext;

        private ScenarioContext _scenarioContext = scenarioContext;

        [Given("The service to test is {string}")]
        public void GivenTheServiceToTestIs(string uotName)
        {
            switch (uotName)
            {
                case "AdventureWorksDemo.Data.Services.IProductCategoryService":
                case "AdventureWorksDemo.Data.Services.ProductCategoryService":

                    _scenarioContext.Add(FeatureContextKey.UOT.ToString(), Helper.Ioc.ResolveObject<IProductCategoryService>());
                    break;

                default:
                    break;
                    throw new PendingStepException("Unknown service to Test");
            }
        }

        [Then("the result is")]
        public void ThenTheResultIs(DataTable table)
        {
            var contextResult = _scenarioContext.Get<object>(ScenarioContextKey.Result.ToString());

            string? resultTypeName = contextResult.GetType().FullName;
            switch (resultTypeName)
            {
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

        [Then("the results are")]
        public void ThenTheResultsAre(DataTable table)
        {
            var contextResult = _scenarioContext.Get<object>(ScenarioContextKey.Result.ToString());

            string? resultTypeName = contextResult.GetType()!.FullName;

            //if (contextResult is Array)
            //    resultTypeName = contextResult.ToString().Split('[')[0];
            //else
            resultTypeName = resultTypeName!.ToString().Replace("`1", "").Replace("[", "<").Replace("]", ">")
                                                    .Replace(">", "")
                                                    .Split('<')[1];

            switch (resultTypeName)
            {
                case "System.Exception": table.CompareToSet(new List<string>() { resultTypeName }); break;
                case "AdventureWorksDemo.Data.Models.ProductCategoryModel": table.CompareToSet(new List<ProductCategoryModel> { (ProductCategoryModel)contextResult }); break;
                default: throw new NotImplementedException($"Type [{resultTypeName}] is not implemented!");
            }
        }

        //[When("I call the method {string} with the parameter value {int}")]
        //public async Task WhenICallTheMethodWithTheParameterValueAsync(string methodName, int id)
        //{
        //    await Task.Delay(0);
        //    var uot = _scenarioContext.GetValueOrDefault(FeatureContextKey.UOT.ToString());
        //    var methodInfo = uot.GetType()?.GetMethod(methodName);
        //    var parameters = new object[] { id };

        // dynamic result = null;

        //    if (IsMethodAsync(methodInfo))
        //    {
        //        dynamic? awaitable = methodInfo.Invoke(uot, parameters);
        //        await awaitable;
        //        result = awaitable?.GetAwaiter().GetResult();
        //    }
        //    else
        //    {
        //        result = methodInfo!.Invoke(uot, parameters);
        //    }
        //    AddToScenarioContext(ScenarioContextKey.ResultType, methodInfo.ReturnType);
        //    AddToScenarioContext(ScenarioContextKey.Result, result);
        //}

        [When("I call the method {string} with the parameter values")]
        public async Task WhenICallTheMethodWithTheParameterValuesAsync(string methodName, DataTable table)
        {
            await Task.Delay(0);
            if (!table.Rows.Any())
            {
                throw new Exception("Table is empty");
            }
            var methodParameters = GetParametersFromDataTable(table);
            var uot = _scenarioContext.GetValueOrDefault(FeatureContextKey.UOT.ToString());

            var result = await GetMethodValueForObjectAsync(uot,
                                                            methodName,
                                                            methodParameters);
            if (result.Item1.FullName.Contains("Task"))
            { 
                var t = result.Item1.GenericTypeArguments.FirstOrDefault();
                AddToScenarioContext(ScenarioContextKey.ResultType, t);

            }
            else
                AddToScenarioContext(ScenarioContextKey.ResultType, result.Item1);

               AddToScenarioContext(ScenarioContextKey.Result, result.Item2);
        }


        [Then(@"the result is of type")]
        public virtual void ThenTheResultIsOfType(DataTable table)
        {
            var actual = (Type) _scenarioContext.GetValueOrDefault(ScenarioContextKey.ResultType.ToString());
            var expected = table.Rows.Single()["Expected"];
            if (!expected.Contains("."))
            {
                throw new ArgumentException($"Expected type '{expected}' must contain the namespace!");
            }
            var results = new List<ValueExpectedResult>()
            {
                new ValueExpectedResult(){
                Expected = actual.FullName ,
                }
            };
            table.CompareToSet(results);
        }
        private void AddToScenarioContext(ScenarioContextKey key, object? value)
        {
            _scenarioContext.Add(key.ToString(), value);
        }
        [Then("the result is null")]
        public void ThenTheResultIsNull()
        {
            var actual = _scenarioContext.GetValueOrDefault(ScenarioContextKey.Result.ToString());
            Assert.IsNull(actual);
        }

        private object? GetArgumentValue(DataTableRow row)
        {
            return GetArgumentValue(row["Value"].Trim(),
                                    row["TypeName"].Trim()
                );
        }

        private object? GetArgumentValue(string value, string typeName)
        {
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


            retval = await InvokeMethodReturnValue(target, args.ToArray(), method);
            return retval;
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

        private async Task<bool> IsMethodAsync(dynamic method)
        {
            await Task.Delay(0);
            IReadOnlyCollection<CustomAttributeData> r = method.CustomAttributes;
            return r.Any(w => w.AttributeType?.Name == "AsyncStateMachineAttribute");
        }
    }
}