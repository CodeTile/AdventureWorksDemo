using System;
using Reqnroll;
using AdventureWorksDemo.Data;
using AdventureWorksDemo.Data.StartUp;
using Microsoft.Extensions.DependencyInjection;
using AdventureWorksDemo.Data.Services;
using AdventureWorksDemo.Data.Tests.reqnroll.enums;
using SpecFlow.Internal.Json;

namespace AdventureWorksDemo.Data.Tests.reqnroll.StepDefinitions
{
    [Binding]
    public class StepDefinitions(FeatureContext featureContext, ScenarioContext scenarioContext)
    {
        private FeatureContext _featureContext = featureContext;
        private ScenarioContext _scenarioContext = scenarioContext;

        [Given("The service to test is {string}")]
        public void GivenTheServiceToTestIs(string uotName)
        {
            switch (uotName)
            {
                case "AdventureWorksDemo.Data.Services.IProductCategoryService":
                case "AdventureWorksDemo.Data.Services.ProductCategoryService":

                    _featureContext.Add(FeatureContextKey.UOT.ToString(), Helper.Ioc.ResolveObject<IProductCategoryService>());
                    break;

                default:
                    break;
                    throw new PendingStepException("Unknown service to Test");
            }
        }

        [Then("the results is")]
        public void ThenTheResultsIs(DataTable dataTable)
        {
            var result = _scenarioContext.Get<object>(ScenarioContextKey.Result.ToString());
            //throw new PendingStepException();
        }

        [When("I call the method {string} with the parameter value {int}")]
        public async Task WhenICallTheMethodWithTheParameterValue(string methodName, int id)
        {
            var uot = _featureContext.GetValueOrDefault(FeatureContextKey.UOT.ToString());
            var methodInfo = uot.GetType().GetMethod(methodName);
            var parameters = new object[] { id };
            if (methodInfo.ReturnType.Name.StartsWith("Task"))
            {
                var result = (Task)methodInfo?.Invoke(uot, parameters);
                await result;
                ;

                //_scenarioContext.Add("Result", resultAsync);
            }
            else
            {
                var resultSync = methodInfo?.Invoke(uot, parameters);
                AddToScenarioContext(ScenarioContextKey.Result, resultSync);
            }
        }

        private void AddToScenarioContext(ScenarioContextKey key, object? value)
        {
            _scenarioContext.Add(key.ToString(), value);
        }
    }
}