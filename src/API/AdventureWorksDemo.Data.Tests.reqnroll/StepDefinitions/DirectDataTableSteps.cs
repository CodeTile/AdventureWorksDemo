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
			string sqlQuery = $"SELECT * FROM {tableName} " +
				  (string.IsNullOrEmpty(filter) ? ";" : $"WHERE {filter};");
			// // // if there are nullable columns you need to specify the column names
			switch (tableName)
			{
				case "Person.Address":
					sqlQuery = "SELECT AddressID, AddressLine1, AddressLine2, City, StateProvinceID, PostalCode,RowGuid ,ModifiedDate FROM Person.Address " +
								(string.IsNullOrEmpty(filter) ? ";" : $"WHERE {filter};");
					table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<Address>(sqlQuery));
					break;

				case "Production.ProductDescription": table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<ProductDescription>(sqlQuery)); break;
				case "Production.ProductCategory": table.CompareToSet(CommonHelper.Sql.GetDataTableAsList<ProductCategory>(sqlQuery)); break;
				default:
					throw new NotImplementedException(tableName);
			}
		}
	}
}