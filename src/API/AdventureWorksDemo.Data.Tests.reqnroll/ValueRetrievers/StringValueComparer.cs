using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using AdventureWorksDemo.Common.Tests.Extensions;

using Reqnroll.Assist;

namespace AdventureWorksDemo.Data.Tests.reqnroll.ValueRetrievers
{
	internal class StringValueComparer : IValueComparer
	{
		public bool CanCompare(object actualValue)
		{
			return actualValue is string;
		}

		public bool Compare(string expectedValue, object actualValue)
		{
			if (actualValue is string)
				return actualValue.Equals(expectedValue.InterpretValue());
			else
				return actualValue.Equals(expectedValue);
		}
	}
}