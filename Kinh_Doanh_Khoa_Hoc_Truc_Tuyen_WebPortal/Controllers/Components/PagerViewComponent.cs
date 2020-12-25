using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Controllers.Components
{
    public class PagerViewComponent : ViewComponent
    {
        public Task<IViewComponentResult> InvokeAsync(PaginationBase result)
        {
            return Task.FromResult((IViewComponentResult)View("Default", result));
        }
    }
}
