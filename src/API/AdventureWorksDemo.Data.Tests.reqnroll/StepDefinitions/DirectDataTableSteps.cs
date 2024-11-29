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
			ThenTheTableFilteredByContains(tableName, string.Empty, table);
		}

		[Given("the table {string} filtered by {string} contains")]
		[Then("the table {string} filtered by {string} contains")]
		public void ThenTheTableFilteredByContains(string tableName, string filter, Reqnroll.DataTable table)
		{
			string sqlQuery = $"SELECT * FROM {tableName} ";
			if (filter != string.Empty)
				sqlQuery += $" WHERE {filter};";
			else
				sqlQuery += ";";
			switch (tableName)
			{
				case "SalesLT.Address": table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<Address>(sqlQuery)); break;
				case "SalesLT.ProductDescription": table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<ProductDescription>(sqlQuery)); break;
				case "SalesLT.ProductCategory": table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<ProductCategory>(sqlQuery)); break;
				default:
					throw new NotImplementedException(tableName);
			}
		}
	}
}