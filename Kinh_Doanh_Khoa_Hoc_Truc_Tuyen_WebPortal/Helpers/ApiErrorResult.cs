namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Helpers
{
    public class ApiErrorResult<T> : ApiResult<T>
    {
        public string[] ValidationErrors { get; set; }

        public ApiErrorResult(string message)
        {
            IsSuccessed = false;
            Message = message;
        }

        public ApiErrorResult()
        {
            IsSuccessed = false;
        }

        public ApiErrorResult(string message, string[] validation)
        {
            IsSuccessed = false;
            Message = message;
            ValidationErrors = validation;
        }
    }
}