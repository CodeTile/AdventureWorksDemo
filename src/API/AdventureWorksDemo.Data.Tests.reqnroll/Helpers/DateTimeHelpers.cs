using Microsoft.Extensions.Time.Testing;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        internal static class DateTimeHelpers
        {
            internal static TimeProvider GetTimeProvider()
            {
                if (!Helper.ScenarioContexts.KeyExists(enums.ScenarioContextKey.FakeTimeProvider))
                    DateTimeHelpers.SetTimeProvider();
                return Helper.ScenarioContexts.Get(enums.ScenarioContextKey.FakeTimeProvider);
            }

            internal static void SetTimeProvider(DateTime fakeDateTime)
            {
                Helper.ScenarioContexts.AddToContext(enums.ScenarioContextKey.FakeDateTime, fakeDateTime);
                var fake = new FakeTimeProvider();
                fake.SetUtcNow(fakeDateTime);
                Helper.ScenarioContexts.AddToContext(enums.ScenarioContextKey.FakeTimeProvider, fake);
            }

            internal static void SetTimeProvider()
            {
                DateTimeHelpers.SetTimeProvider(new DateTime(2024, 5, 24, 12, 34, 56, DateTimeKind.Local));
            }
        }
    }
}