namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    using AdventureWorksDemo.Data.Tests.reqnroll.Helpers;

    [Binding]
    public class DatabaseResetSteps
    {
        [Given("I don't reset the database after the scenario")]
        public void GivenIDontResetTheDatabaseAfterTheScenario()
        {
            Helper.ScenarioContexts.UpdateFlag(enums.ScenarioContextKey.FlagResetDatabase, false);
        }

        [Given("I reset the database after the scenario")]
        public void GivenIResetTheDatabaseAfterTheScenario()
        {
            Helper.ScenarioContexts.UpdateFlag(enums.ScenarioContextKey.FlagResetDatabase, true);
        }
    }
}