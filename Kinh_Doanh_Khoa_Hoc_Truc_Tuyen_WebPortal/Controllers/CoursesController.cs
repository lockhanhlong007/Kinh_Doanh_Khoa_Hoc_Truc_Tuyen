using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Services.Implements;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Controllers
{
    public class CoursesController : Controller
    {
        private readonly IBaseApiClient _apiClient;

        public CoursesController(IBaseApiClient apiClient)
        {
            _apiClient = apiClient;
        }

        [HttpGet]
        [Route("courses.html")]
        public async Task<IActionResult> Index(int? categoryId,long? priceMin, long? priceMax, int? pageSize, string filter = null, string sortBy = null, int page = 1)
        {
            var courseCatalog = new CourseCatalogViewModel();
            pageSize ??= 3;
            courseCatalog.PageSize = pageSize;
            courseCatalog.SortType = sortBy;
            courseCatalog.PriceMax = priceMax;
            courseCatalog.PriceMin = priceMin;
            courseCatalog.Filter = filter;
            courseCatalog.CategoryViewModels = await _apiClient.GetListAsync<CategoryViewModel>($"/api/categories/side-bar");
            courseCatalog.Data = await _apiClient.GetAsync<Pagination<CourseViewModel>>($"/api/courses/client-filter?categoryId={categoryId}" + $"&pageIndex={page}" + $"&pageSize={pageSize}" + $"&priceMin={priceMin}" + $"&priceMax={priceMax}" + $"&sortBy={sortBy}" + $"&filter={filter}");
            return View(courseCatalog);
        }

        [HttpGet]
        [Route("courses-{id}.html")]
        public async Task<IActionResult> Detail(int id, int? pageSize, string sortBy = "new", int page = 1)
        {
            var detail = new CourseDetailClientViewModel();
            pageSize ??= 5;
            detail.SortType = sortBy;
            detail.CourseViewModel = await _apiClient.GetAsync<CourseViewModel>($"/api/courses/{id}");
            detail.LessonViewModels = await _apiClient.GetListAsync<LessonViewModel>($"/api/lessons/course-{id}");
            detail.CommentViewModels = await _apiClient.GetAsync<Pagination<CommentViewModel>>($"/api/comments/courses/{id}/client-pag?entityId={id}" + "&entityType=courses" + $"&pageSize={pageSize}" + $"&sortBy={sortBy}" + $"&pageIndex={page}");
            detail.RelatedCourses = await _apiClient.GetListAsync<CourseViewModel>($"/api/courses/related-courses/{id}");
            detail.UserViewModel = await _apiClient.GetAsync<UserViewModel>($"/api/users/course-{id}");
            return View(detail);
        }

        [HttpGet]
        [Route("lessons-with-courses-{id}.html")]
        public async Task<IActionResult> Lessons(int id, int? lessonId,string sortBy = "new")
        {
            var data = new LessonsCatalogViewModel();
            data.SortType = sortBy;
            data.CourseViewModel = await _apiClient.GetAsync<CourseViewModel>($"/api/courses/{id}");
            data.LessonViewModels = await _apiClient.GetListAsync<LessonViewModel>($"/api/lessons/course-{id}");
            data.LessonViewModel = await _apiClient.GetAsync<LessonViewModel>($"/api/lessons/course-{id}/detail?id={id}&lessonId={lessonId}");
            data.CommentViewModels = await _apiClient.GetListAsync<CommentViewModel>($"/api/comments/courses/{id}/client?sortBy={sortBy}&entityId={id}&entityType=lessons");
            return View(data);
        }
    }
}
