namespace AdventureWorksDemo.Common.Tests.Extensions
{
	public static class IntegerExtentions
	{
		public static Guid ToGuid(this int value)
		{
			byte[] bytes = new byte[16];
			BitConverter.GetBytes(value).CopyTo(bytes, 0);
			return new Guid(bytes);
		}
	}
}