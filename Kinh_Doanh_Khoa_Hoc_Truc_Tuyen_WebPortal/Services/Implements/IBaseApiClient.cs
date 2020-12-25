using System.Collections.Generic;
using System.Threading.Tasks;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements
{
    public interface IBaseApiClient
    {
        Task<TResponse> GetAsync<TResponse>(string url);
        Task<List<T>> GetListAsync<T>(string url);
        Task<bool> Delete(string url);
    }
}