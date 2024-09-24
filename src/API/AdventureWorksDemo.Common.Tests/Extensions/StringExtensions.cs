namespace AdventureWorksDemo.Common.Tests.Extensions
{
	public static class StringExtensions
	{
		public static string FullNameReadable(this Type t)
		{
			var value = t.FullName;

			if (!value!.Contains('[')) return value;
			value = t.FullName!.Split('`')[0] + "<";
			foreach (var item in t.GenericTypeArguments)
			{
				value += item.FullName + ", ";
			}
			value = (value + ">").Replace(", >", ">");

			return value;
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

			while (value.Contains("{{Pad"))
			{
				var posStart = value.IndexOf("{{Pad", StringComparison.Ordinal);
				var posEnd = value.IndexOf("}}", posStart, StringComparison.Ordinal);
				var textToReplace = value.Substring(posStart, posEnd + 2 - posStart);

				var character = textToReplace.Split('\'')[1];
				var numerator = textToReplace.Split('\'')[2].Split(',')[1].Split(')')[0];
				var iterations = Convert.ToInt32(numerator);
				var replacementText = character.PadRight(iterations, Convert.ToChar(character));
				value = value.Replace(textToReplace, replacementText);
			}
			return value;
		}
	}
}