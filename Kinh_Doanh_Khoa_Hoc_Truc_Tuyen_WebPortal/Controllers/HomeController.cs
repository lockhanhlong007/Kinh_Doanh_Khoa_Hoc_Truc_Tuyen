using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements;
using Microsoft.Extensions.Configuration;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Controllers
{
    public class HomeController : Controller
    {
        private readonly IBaseApiClient _apiClient;

        public HomeController(IBaseApiClient apiClient)
        {
            _apiClient = apiClient;
        }

        public async Task<IActionResult> Index()
        {
            var newCourses = await _apiClient.GetListAsync<CourseViewModel>($"/api/courses/new-courses");
            var homeCategories = await _apiClient.GetListAsync<CategoryViewModel>($"/api/categories/home-categories");

            return View(new HomeViewModel()
            {
                HomeCategoryViewModels = homeCategories,
                NewCourses = newCourses
            });
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
