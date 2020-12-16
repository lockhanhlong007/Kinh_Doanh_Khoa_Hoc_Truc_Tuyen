namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Helpers
{
    public class ApiResult<T>
    {
        public bool IsSuccessed { get; set; }

        public string Message { get; set; }

        public T ResultObj { get; set; }
    }
}