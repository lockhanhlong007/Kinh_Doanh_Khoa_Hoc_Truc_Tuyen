namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Helpers
{
    public class ApiSuccessResult<T> : ApiResult<T>
    {
        public ApiSuccessResult()
        {
            IsSuccessed = true;
        }

        public ApiSuccessResult(T resultObject)
        {
            IsSuccessed = true;
            ResultObj = resultObject;
        }
    }
}