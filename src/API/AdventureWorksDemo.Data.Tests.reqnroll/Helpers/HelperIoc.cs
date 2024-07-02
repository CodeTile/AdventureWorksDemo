using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Data.StartUp;

using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;

namespace AdventureWorksDemo.Data.Tests.reqnroll.Helpers
{
    internal static partial class Helper
    {
        public static class Ioc
        {
            public static ServiceProvider BuildIoc()
            {
                var services = new ServiceCollection();
                var config = Configuration.GetConfiguration;
                // normal services
                new IocData(config).ConfigureServices(services);
                // test specific services
                services.RemoveAll<System.TimeProvider>();
                services.AddSingleton(Helper.DateTimeHelpers.GetTimeProvider());
                // build service provider
                return services.BuildServiceProvider();
            }

            public static T? ResolveObject<T>()
            {
                var service = BuildIoc().GetService(typeof(T));
                return (T?)service;
            }
        }
    }
}