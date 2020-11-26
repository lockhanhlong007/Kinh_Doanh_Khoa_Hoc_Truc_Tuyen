using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using ILogger = Serilog.ILogger;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CoursesController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<CoursesController> _logger;

        public CoursesController(EKhoaHocDbContext khoaHocDbContext, ILogger<CoursesController> logger)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(string id)
        {
            var result = await _khoaHocDbContext.Courses.FindAsync(id);
            if (result == null)
            {
                _logger.LogError($"Cannot found Course with id {id}");
                return  NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
            }

            return Ok(new CourseViewModel
            {
                Name = result.Name,
                CategoryId = result.CategoryId,
                Status = result.Status,
                Price = result.Price,
                Description = result.Description,
                Content = result.Content,
                CreationTime = result.CreationTime,
                LastModificationTime = result.LastModificationTime,
                Id = result.Id
            });

        }

        [HttpPost]
        [ValidationFilter]
        //[ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.CREATE)]
        public async Task<IActionResult> PostCourse([FromForm] CourseCreateRequest request)
        {
            var dbCourse = await _khoaHocDbContext.Courses.FindAsync(request.Id);
            if (dbCourse != null)
            {
                _logger.LogError($"Course with id {request.Id} is existed.");
                return BadRequest(new ApiBadRequestResponse($"Course with id {request.Id} is existed."));
            }

            var course = new Course
            {
                Name = request.Name,
                CategoryId = request.CategoryId,
                Status = request.Status,
                Description = request.Description,
                Content = request.Content,
                Price = request.Price
            };
            await _khoaHocDbContext.Courses.AddAsync(course);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return CreatedAtAction(nameof(GetById), new { id = course.Id }, request);
            }
            _logger.LogError("Create course is failed");
            return BadRequest(new ApiBadRequestResponse("Create course is failed"));
        }


        [HttpGet]
        public async Task<IActionResult> GetCourses()
        {
            return Ok(await _khoaHocDbContext.Courses.AsNoTracking().Select(_ => new CourseViewModel
            {
                Name = _.Name,
                CategoryId = _.CategoryId,
                Status = _.Status,
                Description = _.Description,
                Content = _.Content,
                Price = _.Price
            }).ToListAsync());
        }

        [HttpGet("filter")]
        // [ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.VIEW
        public async Task<IActionResult> GetCoursesPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Courses.AsQueryable().AsNoTracking();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Name.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageSize - 1) * pageSize).Take(pageSize).Select(_ => new CourseViewModel
            {
                Name = _.Name,
                CategoryId = _.CategoryId,
                Status = _.Status,
                Description = _.Description,
                Content = _.Content,
                Price = _.Price
            }).ToListAsync();
            var pagination = new Pagination<CourseViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

          [HttpPut("{id}")]
        //  [ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.UPDATE)]
        [ValidationFilter]
        public async Task<IActionResult> PutCourse(int id, [FromBody] CourseCreateRequest request)
        {
            var course = await _khoaHocDbContext.Courses.FindAsync(id);
            if (course == null)
            {
                _logger.LogError($"Cannot found course with id {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
            }

            course.Name = request.Name;
            course.CategoryId = request.CategoryId;
            course.Status = request.Status;
            course.Description = request.Description;
            course.Content = request.Content;
            course.Price = request.Price;
            _khoaHocDbContext.Courses.Update(course);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }
            _logger.LogError("Update course failed");
            return BadRequest(new ApiBadRequestResponse("Update course failed"));
        }

        [HttpDelete("{id}")]
        //[ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.DELETE)]
        public async Task<IActionResult> DeleteCourse(int id)
        {
            var course = await _khoaHocDbContext.Courses.FindAsync(id);
            if (course == null)
            {
                _logger.LogError($"Cannot found Course with id {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found Course with id {id}"));
            }
            var lessons = _khoaHocDbContext.Lessons.Where(x => x.CourseId == id);
            _khoaHocDbContext.Lessons.RemoveRange(lessons);
            _khoaHocDbContext.Courses.Remove(course);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result <= 0)
            {
                _logger.LogError("Delete Course failed");
                return BadRequest(new ApiBadRequestResponse("Delete Course failed"));
            }

            var courseViewModel = new CourseViewModel
            {
                Name = course.Name,
                CategoryId = course.CategoryId,
                Status = course.Status,
                Description = course.Description,
                Content = course.Content,
                Price = course.Price
            };
            return Ok(courseViewModel);
        }
    }
}
