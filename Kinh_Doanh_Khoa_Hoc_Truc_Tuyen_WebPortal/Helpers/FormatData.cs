namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Helpers
{
    public static class FormatData
    {
        public static string formatData(this string input, int length)
        {
            if (input.Length > length)
            {
                return input.Substring(0, length) + "...";
            }

            return input;
        }
    }
}
