﻿using AdventureWorksDemo.Data.Entities;
using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    [Binding]
    public class DirectDataTableSteps
    {
        [Then("the table {string} filtered by {string} contains")]
        public void ThenTheTableFilteredByContains(string tableName, string filter, Reqnroll.DataTable table)
        {
            string sqlQuery = $"SELECT * FROM {tableName} WHERE {filter};";
            var data = tableName switch
            {
                "SalesLT.ProductCategory" => Helper.Sql.GetDataTableAsList<ProductCategory>(sqlQuery),
                _ => throw new NotImplementedException(tableName),
            }
            ;

            table.CompareToSet(data);
        }
    }
}