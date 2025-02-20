using AdventureWorksDemo.Common.Tests.Extensions;

using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace AdventureWorksDemo.Common.Tests;

[TestClass]
public class StringExtentionsTests_PadRight
{
	[DataRow("{{PadRight:X:0}}", "X")]
	[DataRow("{{PadRight:X:3}}", "XXX")]
	[DataRow("{{PadRight:X:3}}  {{PadRight:X:2}}  {{PadRight:X:1}}", "XXX  XX  X")]
	[DataRow("{{PadRight:X:3}}{{PadRight:X:3}}", "XXXXXX")]
	[TestMethod]
	public void InterpretValuePadRightContentTest(string uot, string expected)
	{
		//arrange

		//act
		var actual = uot.InterpretValue();
		//assert
		Assert.AreEqual(expected, actual);
	}

	[DataRow("{{PadRight:X:1}}", 1)]
	[DataRow("{{PadRight:X:3}}", 3)]
	[DataRow("{{PadRight:X:60}}", 60)]
	[DataRow("{{PadRight:X:9999}}", 9999)]
	[TestMethod]
	public void InterpretValuePadRightLengthTest(string uot, int expectedLength)
	{
		//arrange

		//act
		var actual = uot.InterpretValue();
		//assert
		Assert.AreEqual(expectedLength, actual.Length);
	}
}