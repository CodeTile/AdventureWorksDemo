Feature:ReportOnLineVsOffLineTests

Tests for the report ReportOnLineVsOffLine

Background:
	Given The service to test is 'AdventureWorksDemo.Data.Services.IReportService'
	And I don't reset the database after the scenario

	Scenario: debug
	When I call the method 'ReportOnlineVsOffLine'
	Then the result is of type
		| Expected                                                                                                          |
		| Microsoft.EntityFrameworkCore.Query.Internal.EntityQueryable<AdventureWorksDemo.Data.Models.Reports.SalesSummary> |
	And the results are
		| Year | Month | OnlineOrderFlag | SalesCount | Period |
