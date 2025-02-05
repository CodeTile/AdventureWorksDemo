using System.Text;

namespace AdventureWorksDemo.Common.Tests.Extensions
{
	public static class StringExtensions
	{
		public static string FullNameReadable(this Type t)
		{
			var sb = new StringBuilder();
			sb.Append(t.FullName);

			if (!sb.ToString()!.Contains('[')) 
				return sb.ToString();
			sb.Clear();
			sb.Append(t.FullName!.Split('`')[0] + "<");
			foreach (var item in t.GenericTypeArguments)
			{
				sb.Append(item.FullName + ", ");
			}
			return (sb.ToString() + ">").Replace(", >", ">");
		}

		public static string InterpretValue(this string value)
		{
			if (!value.Contains("{{"))
			{
				return value;
			}

			value = value.Replace("{{pipe}}", "|")
						 .Replace("{{DateTime.Now}}", DateTime.Now.ToString("dd MMM yyyy hh:mm:ss"))
						 .Replace("{{DateTime.UtcNow}}", DateTime.UtcNow.ToString("dd MMM yyyy hh:mm:ss"))
						 .Replace("{{DateTime.UTCLastWeek}}", DateTime.UtcNow.AddDays(-7).ToString("dd MMM yyyy hh:mm:ss"))
						 .Replace("{{DateTime.UTCNextWeek}}", DateTime.UtcNow.AddDays(7).ToString("dd MMM yyyy hh:mm:ss"))
						 .Replace("{{DateTime.UTCLastWeek}}", DateTime.UtcNow.AddDays(-7).ToString("dd MMM yyyy hh:mm:ss"))
						 .Replace("{{DateTime.Tomorrow}}", DateTime.Today.AddDays(1).ToString("dd MMM yyyy"))
						 .Replace("{{DateTime.TomorrowResult}}", DateTime.Today.AddDays(1).ToString("M/d/yyyy 12:00:00 AM"))
						 .Replace("{{CrLf}}", "\r\n");

			while (value.Contains("{{Pad", StringComparison.CurrentCultureIgnoreCase))
			{
				var posStart = value.IndexOf("{{Pad", StringComparison.Ordinal);
				var posEnd = value.IndexOf("}}", posStart, StringComparison.Ordinal);
				var textToReplace = value.Substring(posStart, posEnd + 2 - posStart);
				var strippedTest = textToReplace.Replace("{{", "").Replace("}}", "");

				var character = strippedTest.Split(':')[1];
				var numerator = strippedTest.Split(':')[2];
				var iterations = Convert.ToInt32(numerator);
				var replacementText = character.PadRight(iterations, Convert.ToChar(character));
				value = value.Replace(textToReplace, replacementText);
			}

			return value;
		}
	}
}