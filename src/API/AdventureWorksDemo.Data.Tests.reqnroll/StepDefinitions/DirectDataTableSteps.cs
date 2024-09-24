using AdventureWorksDemo.Common.Tests.Helpers;
using AdventureWorksDemo.Data.Entities;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
	[Binding]
	public class DirectDataTableSteps
	{
		[Then("the table {string} contains")]
		public void ThenTheTableContains(string tableName, Reqnroll.DataTable table)
		{
			string sqlQuery = $"SELECT * FROM {tableName} ;";
			var data = tableName switch
			{
				"SalesLT.ProductCategory" => CommonHelper.Sql.GetDataTableAsList<ProductCategory>(sqlQuery),
				_ => throw new NotImplementedException(tableName),
			};

			table.CompareToSet(data);
		}

		[Given("the table {string} filtered by {string} contains")]
		[Then("the table {string} filtered by {string} contains")]
		public void ThenTheTableFilteredByContains(string tableName, string filter, Reqnroll.DataTable table)
		{
			string sqlQuery = $"SELECT * FROM {tableName} WHERE {filter};";
			var data = tableName switch
			{
				"SalesLT.ProductCategory" => CommonHelper.Sql.GetDataTableAsList<ProductCategory>(sqlQuery),
				_ => throw new NotImplementedException(tableName),
			}
			;

			table.CompareToSet(data);
		}
	}
}