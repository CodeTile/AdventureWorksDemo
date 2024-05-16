using System;
using Reqnroll;
using AdventureWorksDemo.Data;
using AdventureWorksDemo.Data.StartUp;
using Microsoft.Extensions.DependencyInjection;
using AdventureWorksDemo.Data.Services;

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
                    _featureContext.Add("UOT", Helper.Ioc.ResolveObject<IProductCategoryService>());
                    break;

                default:
                    break;
                    throw new PendingStepException("Unknown service to Test");
            }
        }

        [When("I call the method {string} with the parameter value {int}")]
        public async Task WhenICallTheMethodWithTheParameterValueAsync(string methodName, int id)
        {
            var uot = _featureContext.GetValueOrDefault("UOT");
            var methodInfo = uot.GetType().GetMethod(methodName);
            var parameters = new object[] { id };
            if (methodInfo.ReturnType.Name.StartsWith("Task"))
            {
                var resultAsync = (Task)methodInfo?.Invoke(uot, parameters);
                await resultAsync;
                _scenarioContext.Add("Result", resultAsync);
            }
            else
            {
                var resultSync = methodInfo?.Invoke(uot, parameters);
                _scenarioContext.Add("Result", resultSync);
            }
        }
    }
}