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
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LessonsController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<LessonsController> _logger;

        public LessonsController(EKhoaHocDbContext khoaHocDbContext, ILogger<LessonsController> logger)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(string id)
        {
            var result = await _khoaHocDbContext.Lessons.FindAsync(id);
            if (result == null)
            {
                _logger.LogError($"Cannot found Course with id {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
            }

            return Ok(new LessonViewModel
            {
                Name = result.Name,
                Status = result.Status,
                SortOrder = result.SortOrder,
                CourseId = result.CourseId,
                Id = result.Id
            });

        }

        [HttpPost]
        [ValidationFilter]
        //[ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.CREATE)]
        public async Task<IActionResult> PostLesson([FromForm] LessonCreateRequest request)
        {
            var dbCourse = await _khoaHocDbContext.Courses.FindAsync(request.Id);
            if (dbCourse != null)
            {
                _logger.LogError($"Course with id {request.Id} is existed.");
                return BadRequest(new ApiBadRequestResponse($"Course with id {request.Id} is existed."));
            }

            var lesson = new Lesson
            {
                Name = request.Name,
                Status = request.Status,
                SortOrder = request.SortOrder,
                CourseId = request.CourseId,
            };
            await _khoaHocDbContext.Lessons.AddAsync(lesson);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return CreatedAtAction(nameof(GetById), new { id = lesson.Id }, request);
            }
            _logger.LogError("Create course is failed");
            return BadRequest(new ApiBadRequestResponse("Create course is failed"));
        }


        [HttpGet]
        public async Task<IActionResult> GetLessons()
        {
            return Ok(await _khoaHocDbContext.Lessons.AsNoTracking().Select(_ => new LessonViewModel
            {
                Name = _.Name,
                Status = _.Status,
                SortOrder = _.SortOrder,
                CourseId = _.CourseId,
            }).ToListAsync());
        }

        [HttpGet("filter")]
        // [ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.VIEW
        public async Task<IActionResult> GetLessonsPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Lessons.AsQueryable().AsNoTracking();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Name.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageSize - 1) * pageSize).Take(pageSize).Select(_ => new LessonViewModel
            {
                Name = _.Name,
                Status = _.Status,
                SortOrder = _.SortOrder,
                CourseId = _.CourseId,
            }).ToListAsync();
            var pagination = new Pagination<LessonViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpPut("{id}")]
        //  [ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.UPDATE)]
        [ValidationFilter]
        public async Task<IActionResult> PutLesson(int id, [FromBody] LessonCreateRequest request)
        {
            var lesson = await _khoaHocDbContext.Lessons.FindAsync(id);
            if (lesson == null)
            {
                _logger.LogError($"Cannot found lesson with id {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found lesson with id {id}"));
            }

            lesson.Name = request.Name;
            lesson.Status = request.Status;
            lesson.SortOrder = request.SortOrder;
            lesson.CourseId = request.CourseId;
            _khoaHocDbContext.Lessons.Update(lesson);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }
            _logger.LogError("Update lesson failed");
            return BadRequest(new ApiBadRequestResponse("Update lesson failed"));
        }

        [HttpDelete("{id}")]
        //[ClaimRequirement(CourseCode.SYSTEM_Course, CommandCode.DELETE)]
        public async Task<IActionResult> DeleteLesson(int id)
        {
            var lesson = await _khoaHocDbContext.Lessons.FindAsync(id);
            if (lesson == null)
            {
                _logger.LogError($"Cannot found lesson with id {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found lesson with id {id}"));
            }
            _khoaHocDbContext.Lessons.Remove(lesson);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result <= 0)
            {
                _logger.LogError("Delete lesson failed");
                return BadRequest(new ApiBadRequestResponse("Delete lesson failed"));
            }

            var lessonViewModel = new LessonViewModel
            {
                Name = lesson.Name,
                Status = lesson.Status,
                SortOrder = lesson.SortOrder,
                CourseId = lesson.CourseId
            };
            return Ok(lessonViewModel);
        }

    }
}
