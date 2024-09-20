namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    [Binding]
    public class DateTimeStepDefinitions
    {
        [Given("I set the TimeProvider to {string}")]
        public void GivenISetTheTimeProviderTo(string fakeDateTime)
        {
            DateTime datetime = Convert.ToDateTime(fakeDateTime);
            Helpers.Helper.DateTimeHelpers.SetTimeProvider(datetime);
        }
    }
}