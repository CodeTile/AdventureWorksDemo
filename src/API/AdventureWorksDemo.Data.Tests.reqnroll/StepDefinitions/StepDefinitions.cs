using System.Collections;
using System.Reflection;

using AdventureWorksDemo.Common.Tests;

using AdventureWorksDemo.Common.Tests.Extensions;
using AdventureWorksDemo.Data.Models;
using AdventureWorksDemo.Data.Models.Reports;
using AdventureWorksDemo.Data.Paging;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;
using AdventureWorksDemo.Data.Tests.reqnroll.Models;

using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
	[Binding]
	public class StepDefinitions
	{
		public StepDefinitions(ScenarioContext scenarioContext)
		{
			Helper.ScenarioContexts.Context = scenarioContext;
		}

		[Given("I clear the previous results")]
		public void GivenIClearThePreviousResults()
		{
			Helper.ScenarioContexts.ClearResult();
		}

		[Given("The service to test is {string}")]
		public void GivenTheServiceToTestIs(string uotName)
		{
			switch (uotName)
			{
				case "AdventureWorksDemo.Data.Services.IAddressService":
				case "AdventureWorksDemo.Data.Services.AddressService":
					Helper.ScenarioContexts.AddToContext(ScenarioContextKey.UOT, Helper.Ioc.ResolveObject<IAddressService>());
					break;

				case "AdventureWorksDemo.Data.Services.IReportService":
				case "AdventureWorksDemo.Data.Services.ReportService":
					Helper.ScenarioContexts.AddToContext(ScenarioContextKey.UOT, Helper.Ioc.ResolveObject<IReportService>());
					break;

				case "AdventureWorksDemo.Data.Services.IProductCategoryService":
				case "AdventureWorksDemo.Data.Services.ProductCategoryService":
					Helper.ScenarioContexts.AddToContext(ScenarioContextKey.UOT, Helper.Ioc.ResolveObject<IProductCategoryService>());
					break;

				case "AdventureWorksDemo.Data.Services.IProductDescriptionService":
				case "AdventureWorksDemo.Data.Services.ProductDescriptionService":
					Helper.ScenarioContexts.AddToContext(ScenarioContextKey.UOT, Helper.Ioc.ResolveObject<IProductDescriptionService>());
					break;

				default:
					throw new PendingStepException($"Unknown service to Test '{uotName}'!");
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
			List<IPagedList> actualAsList = [actual];

			expected.CompareToSet(actualAsList);
		}

		[Then("the result is")]
		public void ThenTheResultIs(DataTable table)
		{
			var contextResult = Helper.ScenarioContexts.GetResult;

			string? resultTypeName = contextResult.GetType().FullNameReadable();
			switch (contextResult)
			{
				case bool:
					table.CompareToSet([new ValueExpectedResult() { Expected = ((bool)contextResult).ToString() }]);
					break;

				case Exception:
					table.CompareToSet([resultTypeName]);
					break;

				case AdventureWorksDemo.Data.Models.AddressModel:
					table.CompareToSet([(AddressModel)contextResult]);
					break;

				case AdventureWorksDemo.Data.Models.AddressModel[]:
				case IEnumerable<AddressModel>:
					table.CompareToSet((AddressModel[])contextResult);
					break;

				case AdventureWorksDemo.Data.Models.ProductCategoryModel:
					table.CompareToSet([(ProductCategoryModel)contextResult]);
					break;

				case AdventureWorksDemo.Data.Models.ProductCategoryModel[]:
				case IEnumerable<ProductCategoryModel>:
					table.CompareToSet((ProductCategoryModel[])contextResult);
					break;

				case AdventureWorksDemo.Data.Models.ProductDescriptionModel:
					table.CompareToSet([(ProductDescriptionModel)contextResult]);
					break;

				case AdventureWorksDemo.Data.Models.ProductDescriptionModel[]:
				case IEnumerable<ProductDescriptionModel>:
					table.CompareToSet((ProductDescriptionModel[])contextResult);
					break;

				case IServiceResult:
					CompareDataTableWithResult(table, (IServiceResult)contextResult);
					break;

				default:
					//table.CompareToSet(contextResult);
					throw new NotImplementedException($"Type [{resultTypeName}] is not handled in step {nameof(ThenTheResultIs)}!");
					break;
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
			CompareResults(table, false);
		}

		[Then("the results property {string} contains")]
		public void ThenTheResultsPropertyContains(string propertyName, DataTable dataTable)
		{
			var result = Helper.ScenarioContexts.GetResult;
			var properties = result.GetType().GetProperties();
			var property = properties.Single(p => p.Name == propertyName);

			Type valueType = property.PropertyType;
			var value = property.GetValue(result, null);

			IList? values;

			if (valueType == typeof(string))
			{
				var list = value.ToString().Split(["\n", "\r\n"], StringSplitOptions.RemoveEmptyEntries);
				values = list.Select(m => new ValueExpectedResult() { Expected = m }).ToList<ValueExpectedResult>();
			}
			else if (value is not IEnumerable)
			{
				values = CreateList(valueType);
				values.Add(value);
			}
			else
				values = (IList?)value;
			CompareDataTableWithResult(dataTable, values);
		}

		[Then("the sorted results are")]
		public void ThenTheSortedResultsAre(DataTable table)
		{
			CompareResults(table, true);
		}

		[When("I call the method {string}")]
		public async Task WhenICallTheMethodAsync(string methodName)
		{
			await WhenICallTheMethodWithTheParameterValuesAsync(methodName, null);
		}

		[When("I call the method {string} with the parameter values")]
		public async Task WhenICallTheMethodWithTheParameterValuesAsync(string methodName, DataTable? table)
		{
			if (table?.Rows.Count == 0)
			{
				throw new Exception("Table is empty");
			}
			KeyValueTypeName[] methodParameters = [];
			if (table != null)
			{
				methodParameters = GetParametersFromDataTable(table);
			}
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

		[When("I populate a list of the model {string}")]
		public void WhenIPopulateAListOfTheModel(string modelTypeName, DataTable table)
		{
			var models = Helper.Types.PopulateListFromTable(modelTypeName, table, null);
			Helper.ScenarioContexts.AddToContext(ScenarioContextKey.ListOfObjects, models);
		}

		[When("I populate the model {string}")]
		public void WhenIPopulateTheModel(string modelTypeName, DataTable dataTable)
		{
			var model = Helper.Types.PopulateModelFromRow(modelTypeName, dataTable.Rows[0], null);
			Helper.ScenarioContexts.AddToContext(ScenarioContextKey.Model, model);
		}

		[When("I update the model {string}")]
		public void WhenIUpdateTheModel(string modelTypeName, DataTable dataTable)
		{
			var model = Helper.Types.PopulateModelFromRow(modelTypeName, dataTable.Rows[0], null);
			Helper.ScenarioContexts.UpdateObjectInContext(ScenarioContextKey.Model, model);
		}

		private void CompareDataTableWithResult(DataTable datatable, object value)
		{
			if (value is IServiceResult result)
			{
				value = ServiceResult.Simple(result);
			}
			IList? values = CreateList(value.GetType());
			values.Add(value);
			CompareDataTableWithResult(datatable, values);
		}

		private void CompareDataTableWithResult(DataTable datatable, IEnumerable values)
		{
			var valueType = values.GetType();
			string valueTypeName = valueType.FullNameReadable();
			if (valueTypeName.Contains(nameof(ProductCategoryModel))) datatable.CompareToSet(values.Cast<ProductCategoryModel>());
			else if (valueTypeName.Contains(nameof(AddressModel))) datatable.CompareToSet(values.Cast<AddressModel>());
			else if (valueTypeName.Contains(nameof(ProductDescriptionModel))) datatable.CompareToSet(values.Cast<ProductDescriptionModel>());
			else if (valueTypeName.Contains(nameof(ServiceResult))) datatable.CompareToSet(values.Cast<IServiceResult>());
			else if (valueTypeName.Contains(nameof(ValueExpectedResult))) datatable.CompareToSet(values.Cast<ValueExpectedResult>());
			else
				throw new NotImplementedException($"unhandled type!!!\r\n {valueTypeName}");
		}

		private void CompareResults(DataTable table, bool compareSorted)
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
				case "System.Exception": table.CompareToSet([resultTypeName]); break;
				case "AdventureWorksDemo.Data.Models.AddressModel": table.CompareToSet((IEnumerable<AddressModel>)actual, compareSorted); break;
				case "AdventureWorksDemo.Data.Models.Reports.SalesSummary": table.CompareToSet((IEnumerable<SalesSummary>)actual, compareSorted); break;
				case "AdventureWorksDemo.Data.Models.Reports.SaleByTerritory": table.CompareToSet((IEnumerable<SaleByTerritory>)actual, compareSorted); break;
				case "AdventureWorksDemo.Data.Models.ProductCategoryModel": table.CompareToSet((IEnumerable<ProductCategoryModel>)actual, compareSorted); break;
				case "AdventureWorksDemo.Data.Models.ProductDescriptionModel": table.CompareToSet((IEnumerable<ProductDescriptionModel>)actual, compareSorted); break;
				default: throw new NotImplementedException($"Type [{resultTypeName}] is not implemented!");
			}
		}

		private IList CreateList(Type myType)
		{
			Type genericListType = typeof(List<>).MakeGenericType(myType);
			return (IList)Activator.CreateInstance(genericListType);
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
					"{{ListOfObjects}}" => Helper.ScenarioContexts.Get(ScenarioContextKey.ListOfObjects),
					"{{models}}" => Helper.ScenarioContexts.Get(ScenarioContextKey.ListOfObjects),
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
														KeyValueTypeName[]? arguments)
		{
			ArgumentNullException.ThrowIfNull(target);
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

		private async Task<object> InvokeMethod(object target, object[] args, MethodInfo method)
		{
			if (method == null) throw new ArgumentNullException(nameof(method));
			if (target == null) throw new ArgumentNullException(nameof(target));

			object actionResult;

			try
			{
				if (IsMethodAsynchronous(method))
				{
					var result = method.Invoke(target, args);
					if (result is Task task)
					{
						await task.ConfigureAwait(false);
						actionResult = task.GetType().IsGenericType ? ((dynamic)task).Result : null;
					}
					else
					{
						actionResult = result;
					}
				}
				else
				{
					var nonAsyncResult = method.Invoke(target, args);
					actionResult = nonAsyncResult is IEnumerable enumerable ? enumerable : nonAsyncResult;
				}
			}
			catch (Exception ex)
			{
				// Log exception (if needed)
				throw new InvalidOperationException($"Error invoking method {method.Name}.", ex);
			}

			return actionResult;
		}

		//private async Task<dynamic> InvokeMethod(object target, object[] args, dynamic method)
		//{
		//	ArgumentNullException.ThrowIfNull(method);
		//	ArgumentNullException.ThrowIfNull(target);

		// dynamic actionResult; if (IsMethodAsynchronous(method)) { actionResult = await
		// method.Invoke(target, args); } else { var nonAsyncResult = method.Invoke(target, args);
		// try { if (!typeof(IEnumerable).IsAssignableFrom(nonAsyncResult)) { actionResult =
		// nonAsyncResult; } else { actionResult = nonAsyncResult.Expression.Value; } } catch
		// (Exception) { actionResult = nonAsyncResult; } }

		//	return actionResult;
		//}

		private async Task<Tuple<Type, object>> InvokeMethodReturnValue(object target, object[]? args, dynamic method)
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

		private bool IsMethodAsynchronous(dynamic method)
		{
			IReadOnlyCollection<CustomAttributeData> r = method.CustomAttributes;
			return r.Any(w => w.AttributeType?.Name == "AsyncStateMachineAttribute");
		}
	}
}