﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Claims;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Services;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
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
        public readonly UserManager<AppUser> _userManager;
        private readonly IStorageService _storageService;
        private readonly IConfiguration _configuration;

        public CoursesController(EKhoaHocDbContext khoaHocDbContext, ILogger<CoursesController> logger, UserManager<AppUser> userManager, IStorageService storageService, IConfiguration configuration)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
            _userManager = userManager;
            _storageService = storageService;
            _configuration = configuration;
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var dynamicParameters = new DynamicParameters();
            dynamicParameters.Add("@id", id);
            var result = (await conn.QueryAsync<CourseViewModel>("CourseDetail", dynamicParameters, null, 120, CommandType.StoredProcedure)).FirstOrDefault();
            if (result == null)
            {
                _logger.LogError($"Cannot found Course with id {id}");
                return  NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
            }

            var countStudent = _khoaHocDbContext.ActivateCourses.Include(x => x.AppUser).Count(x => x.CourseId == id && x.AppUser.UserName != result.CreatedUserName && x.Status);
            return Ok(new CourseViewModel
            {
                Name = result.Name,
                Image = _storageService.GetFileUrl(result.Image),
                CategoryId = result.CategoryId,
                Status = result.Status,
                Price = result.Price,
                Description = result.Description,
                Content = result.Content,
                CreationTime = result.CreationTime,
                LastModificationTime = result.LastModificationTime,
                CategoryName = result.CategoryName,
                Id = result.Id,
                DiscountAmount = result.DiscountAmount,
                DiscountPercent = result.DiscountPercent,
                CreatedUserName = result.CreatedUserName,
                CountStudent = countStudent
            });

        }

        [HttpPost]
        [ValidationFilter]
        [ClaimRequirement(FunctionConstant.Courses, CommandConstant.Create)]
        [Consumes("multipart/form-data")]
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
                Price = request.Price,
                CreatedUserName = User.GetUserName()
            };
            if (request.Image != null)
            {
                var originalFileName = ContentDispositionHeaderValue.Parse(request.Image.ContentDisposition).FileName.Trim('"');
                var fileName = $"{originalFileName.Substring(0, originalFileName.LastIndexOf('.'))}{Path.GetExtension(originalFileName)}";
                await _storageService.SaveFileAsync(request.Image.OpenReadStream(), fileName, "images");
                course.Image = "images/" + fileName;
            }
            await _khoaHocDbContext.Courses.AddAsync(course);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            _logger.LogError("Create course is failed");
            return BadRequest(new ApiBadRequestResponse("Create course is failed"));
        }


        [HttpGet("new-courses")]
        public async Task<IActionResult> GetNewCourses()
        {
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var courses = (await conn.QueryAsync<CourseViewModel>("NewCourses", null, null, 120, CommandType.StoredProcedure)).ToList();
            return Ok(courses.Select(_ => new CourseViewModel
            {
                Id = _.Id,
                Name = _.Name.formatData(30),
                Image = _storageService.GetFileUrl(_.Image),
                CategoryId = _.CategoryId,
                Status = _.Status,
                Description = _.Description,
                Content = _.Content,
                Price = _.Price,
                CategoryName = _.CategoryName,
                DiscountAmount = _.DiscountAmount,
                DiscountPercent = _.DiscountPercent,
                CreatedUserName = _.CreatedUserName
            }).ToList());
        }


        [HttpGet("related-courses/{id}")]
        public async Task<IActionResult> GetRelatedCourses(int id)
        {
            var course = await _khoaHocDbContext.Courses.FindAsync(id);
            if (course == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
            }
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var parameters = new DynamicParameters();
            parameters.Add("@categoryId", course.CategoryId);
            parameters.Add("@courseId", course.Id);
            var courses = (await conn.QueryAsync<CourseViewModel>("RelatedCourses", parameters, null, 120, CommandType.StoredProcedure)).ToList();
            return Ok(courses.Select(_ => new CourseViewModel
            {
                Id = _.Id,
                Name = _.Name.formatData(30),
                Image = _storageService.GetFileUrl(_.Image),
                CategoryId = _.CategoryId,
                Status = _.Status,
                Description = _.Description,
                Content = _.Content,
                Price = _.Price,
                CategoryName = _.CategoryName,
                DiscountAmount = _.DiscountAmount,
                DiscountPercent = _.DiscountPercent,
                CreatedUserName = _.CreatedUserName
            }).ToList());
        }


        [HttpGet("filter")]
        public async Task<IActionResult> GetCoursesPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Courses.Include(x => x.Category).OrderByDescending(x => x.Status).AsQueryable();
            if (User != null && User.IsInRole("Teacher"))
            {
                query = query.Where(x => x.CreatedUserName == User.GetUserName());
            }
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Name.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(_ => new CourseViewModel
            {
                Id = _.Id,
                Name = _.Name,
                CategoryId = _.CategoryId,
                Status = _.Status,
                Image = _storageService.GetFileUrl(_.Image),
                Description = _.Description,
                Content = _.Content,
                Price = _.Price,
                CategoryName = _.Category.Name
            }).ToListAsync();
            var pagination = new Pagination<CourseViewModel>
            {
                Items = items,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
            return Ok(pagination);
        }

        [HttpGet("client-filter")]
        public async Task<IActionResult> GetCoursesPagingForClient(int? categoryId, long? priceMin, long? priceMax, string sortBy, string filter, int pageIndex, int pageSize)
        {
            List<CourseViewModel> data;
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            if (categoryId != null)
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@categoryId", categoryId);
                var category =  await _khoaHocDbContext.Categories.FindAsync(categoryId);
                data = category.ParentId == null
                    ? (await conn.QueryAsync<CourseViewModel>("ListCoursesByCategoryParentId", parameters, null, 120,
                        CommandType.StoredProcedure)).ToList()
                    : (await conn.QueryAsync<CourseViewModel>("ListCoursesByCategoryId", parameters, null, 120,
                        CommandType.StoredProcedure)).ToList();
            }
            else
            {
                data = (await conn.QueryAsync<CourseViewModel>("ListCourses", null, null, 120,
                    CommandType.StoredProcedure)).ToList();
            }
            var query = data.AsQueryable();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Name.Contains(filter));
            }

            foreach (var item in query)
            {
                if (item.DiscountPercent > 0)
                {
                    item.SortPrice = item.Price - (item.Price * item.DiscountPercent / 100);
                }
                else if (item.DiscountAmount > 0)
                {
                    item.SortPrice = item.DiscountAmount;

                }
                else
                {
                    item.SortPrice = item.Price;
                }
            }
            if (priceMin != null && priceMax != null)
            {
                query = query.Where(x => x.SortPrice >= priceMin && x.SortPrice <= priceMax);
            }
            query = sortBy switch
            {
                "name" => query.OrderByDescending(x => x.Name),
                "price_low_to_high" => query.OrderBy(x => x.SortPrice),
                "price_high_to_low" => query.OrderByDescending(x => x.SortPrice),
                _ => query.OrderByDescending(x => x.CreationTime)
            };
            var totalRecords = query.Count();
            var courses = query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(c => new CourseViewModel()
            {
                Name = c.Name.formatData(20),
                Status = c.Status,
                CategoryId = c.CategoryId,
                Price = c.Price,
                CreationTime = c.CreationTime,
                LastModificationTime = c.LastModificationTime,
                Image = _storageService.GetFileUrl(c.Image),
                Content = c.Content,
                Description = c.Description,
                Id = c.Id,
                CategoryName = c.CategoryName.formatData(20),
                DiscountAmount = c.DiscountAmount,
                DiscountPercent = c.DiscountPercent,
                CreatedUserName = c.CreatedUserName
            }).ToList();
            var pagination = new Pagination<CourseViewModel>
            {
                Items = courses,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
            return Ok(pagination);
        }

        [HttpPut("{id}")]
        [ClaimRequirement(FunctionConstant.Courses, CommandConstant.Update)]
        [ValidationFilter]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> PutCourse([FromForm] CourseCreateRequest request)
        {
            var course = await _khoaHocDbContext.Courses.FindAsync(request.Id);
            if (course == null)
            {
                _logger.LogError($"Cannot found course with id {request.Id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found course with id {request.Id}"));
            }
            if (request.Image != null)
            {
                var originalFileName = ContentDispositionHeaderValue.Parse(request.Image.ContentDisposition).FileName.Trim('"');
                var fileName = $"{originalFileName.Substring(0, originalFileName.LastIndexOf('.'))}{Path.GetExtension(originalFileName)}";
                await _storageService.SaveFileAsync(request.Image.OpenReadStream(), fileName, "images");
                course.Image = "images/" + fileName;
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

        [HttpPut("approve")]
        [ClaimRequirement(FunctionConstant.Courses, CommandConstant.Update)]
        [ValidationFilter]
        public async Task<IActionResult> PutCourseApprove(List<int> input)
        {
            foreach (var id in input)
            {
                var course = await _khoaHocDbContext.Courses.FindAsync(id);
                if (course == null)
                {
                    _logger.LogError($"Cannot found course with id {id}");
                    return NotFound(new ApiNotFoundResponse($"Cannot found course with id {id}"));
                }
                course.Status = 1;
                _khoaHocDbContext.Courses.Update(course);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }
            _logger.LogError("Update course failed");
            return BadRequest(new ApiBadRequestResponse("Update course failed"));
        }

        [HttpPost("delete-multi-items")]
        [ClaimRequirement(FunctionConstant.Courses, CommandConstant.Delete)]
        public async Task<IActionResult> DeleteCourse(List<int> input)
        {
            foreach (var id in input)
            {
                var course = await _khoaHocDbContext.Courses.FindAsync(id);
                if (course == null)
                {
                    _logger.LogError($"Cannot found Course with id {id}");
                    return NotFound(new ApiNotFoundResponse($"Cannot found Course with id {id}"));
                }
                var activeCourse = _khoaHocDbContext.ActivateCourses.Where(x => x.CourseId == course.Id);
                if (activeCourse.Any())
                {
                    foreach (var item in activeCourse)
                    {
                        var check = await _khoaHocDbContext.OrderDetails.FindAsync(item.Id);
                        if (check != null)
                        {
                            _logger.LogError($"Không thể xóa khóa học này với id là {item.Id}");
                            return BadRequest(new ApiBadRequestResponse($"Không thể xóa khóa học này với id là {item.Id}"));
                        }
                    }
                    _khoaHocDbContext.ActivateCourses.RemoveRange(activeCourse);
                }
                var lessons = _khoaHocDbContext.Lessons.Where(x => x.CourseId == id);
                if (lessons.Any())
                {
                    _khoaHocDbContext.Lessons.RemoveRange(lessons);
                }
                var comments = _khoaHocDbContext.Comments.Where(x => x.EntityId == course.Id && x.EntityType.Equals("Courses"));
                if (comments.Any())
                {
                    _khoaHocDbContext.Comments.RemoveRange(comments);
                }

                _khoaHocDbContext.Courses.Remove(course);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            _logger.LogError("Delete Course failed");
            return BadRequest(new ApiBadRequestResponse("Delete Course failed"));
        }

        [HttpGet("{id}/users")]
        [ClaimRequirement(FunctionConstant.Promotions, CommandConstant.Update)]
        public async Task<IActionResult> GetCourseUsers(int id)
        {
            var courses = await _khoaHocDbContext.Courses.FindAsync(id);
            if (courses == null)
                return NotFound(new ApiNotFoundResponse($"Cannot found courses with id: {id}"));
            var activateCourses = _khoaHocDbContext.ActivateCourses.Include(x => x.AppUser)
                .Where(x => x.CourseId == courses.Id).Select(u => new UserViewModel()
                {
                    UserName = u.AppUser.UserName,
                    Email = u.AppUser.Email,
                    PhoneNumber = u.AppUser.PhoneNumber,
                    Name = u.AppUser.Name,
                    Dob = u.AppUser.Dob,
                    Id = u.UserId,
                    Avatar = u.AppUser.Avatar ?? "/img/defaultAvatar.png",
                    Biography = u.AppUser.Biography
                });
            return Ok(activateCourses);
        }

        [HttpPost("{coursesId}/users")]
        [ClaimRequirement(FunctionConstant.Promotions, CommandConstant.Update)]
        public async Task<IActionResult> PostCourseUsers(int coursesId, List<string> request)
        {
            var courses = await _khoaHocDbContext.Courses.FindAsync(coursesId);
            if (courses == null)
                return NotFound(new ApiNotFoundResponse($"Cannot found courses with id: {coursesId}"));
            foreach (var activeCourse in request.Select(id => new ActivateCourse() { UserId = Guid.Parse(id), CourseId = coursesId, Status = false }))
            {
                await _khoaHocDbContext.ActivateCourses.AddAsync(activeCourse);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse("Create Failed"));
        }

        [HttpPost("{coursesId}/users/delete-multi-items")]
        [ClaimRequirement(FunctionConstant.Promotions, CommandConstant.Update)]
        public async Task<IActionResult> RemoveCourseUsers(int coursesId, List<string> request)
        {

            var courses = await _khoaHocDbContext.Courses.FindAsync(coursesId);
            if (courses == null)
                return NotFound(new ApiNotFoundResponse($"Cannot found courses with id: {coursesId}"));
            foreach (var id in request)
            {
                var activeCourse = _khoaHocDbContext.ActivateCourses.FirstOrDefault(x => x.CourseId == coursesId && x.UserId == Guid.Parse(id));
                _khoaHocDbContext.ActivateCourses.Remove(activeCourse!);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse("Remove Failed"));
        }

        [HttpPut("{coursesId}/users/active")]
        [ClaimRequirement(FunctionConstant.Courses, CommandConstant.Update)]
        [ValidationFilter]
        public async Task<IActionResult> PutActiveCourses (int coursesId, List<string> input)
        {
            var courses = await _khoaHocDbContext.Courses.FindAsync(coursesId);
            if (courses == null)
                return NotFound(new ApiNotFoundResponse($"Cannot found courses with id: {coursesId}"));
            foreach (var id in input)
            {
                var activeCourse = _khoaHocDbContext.ActivateCourses.FirstOrDefault(x => x.CourseId == coursesId && x.UserId == Guid.Parse(id));
                if (activeCourse == null)
                {
                    _logger.LogError($"Cannot found active course with id {id}");
                    return NotFound(new ApiNotFoundResponse($"Cannot found active course with id {id}"));
                }
                activeCourse.Status = true;
                _khoaHocDbContext.ActivateCourses.Update(activeCourse);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            _logger.LogError("Update active course failed");
            return BadRequest(new ApiBadRequestResponse("Update active course failed"));
        }

        [HttpDelete("{id}/image")]
        public async Task<IActionResult> DeleteAttachment(int id)
        {
            var course = await _khoaHocDbContext.Courses.FindAsync(id);
            if (course == null)
                return BadRequest(new ApiBadRequestResponse($"Cannot found courses with id {id}"));
            course.Image = "";
            _khoaHocDbContext.Courses.Update(course);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            return BadRequest(new ApiBadRequestResponse("Delete Image failed"));
        }
    }
}
