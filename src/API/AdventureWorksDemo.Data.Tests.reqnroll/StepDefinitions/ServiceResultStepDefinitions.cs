using AdventureWorksDemo.Data.Tests.reqnroll.Extensions;
using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
	[Binding]
	public class ServiceResultStepDefinitions
	{
		[Then("the ServiceResult is of type {string} with the value")]
		public void ThenTheServiceResultIsOfTypeWithTheValue(string expectedTypeName, DataTable dataTable)
		{
			var contextResult = (dynamic)Helper.ScenarioContexts.GetResult;

			// check type
			Type actualType = contextResult.Value.GetType();
			actualType.FullNameReadable().Should().Be(expectedTypeName);
			//
			//Check datatype
			if (dataTable.Rows.Count == 1 && !string.IsNullOrEmpty(dataTable.Rows.Single()["Expected"]))
			{
				var expectedValue = dataTable.Rows.Single()["Expected"];
				string actualValue = Convert.ToString(contextResult.Value);
				actualValue.Should().Be(expectedValue);
			}
			else
				throw new NotImplementedException();
		}
	}
}