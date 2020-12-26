using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Extensions;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentsController : ControllerBase
    {

        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<CommentsController> _logger;
        private readonly UserManager<AppUser> _userManager;

        public CommentsController(EKhoaHocDbContext khoaHocDbContext, ILogger<CommentsController> logger, UserManager<AppUser> userManager)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
            _userManager = userManager;
        }

        [HttpGet("{entityType}/{entityId}/filter")]
        public async Task<IActionResult> GetCommentsPaging(int entityId, string entityType, string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Comments.Include(x => x.AppUser).AsNoTracking().Where(x => x.EntityId == entityId && x.EntityType == entityType).AsQueryable();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Content.Contains(filter) || x.UserId.ToString().Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new CommentViewModel()
            {
                Id = x.Id,
                Content = x.Content,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                EntityId = x.EntityId,
                EntityType = x.EntityType,
                UserId = x.UserId,
                OwnerUser = x.AppUser.Name + " (" + x.AppUser.Email + ")"
            }).ToListAsync();
                var pagination = new Pagination<CommentViewModel>
            {
                Items = items,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
                };
            return Ok(pagination);
        }

        [HttpGet("{entityType}/{entityId}/client-pag")]
        public async Task<IActionResult> GetCommentsPagingForClient(int entityId, string entityType, string sortType, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Comments.Include(x => x.AppUser).AsNoTracking().Where(x => x.EntityId == entityId && x.EntityType == entityType).AsQueryable();
            if (!string.IsNullOrEmpty(sortType))
            {
                if (sortType == "new")
                {
                    query = query.OrderByDescending(x => x.CreationTime);
                }
                else
                {
                    query = query.OrderBy(x => x.CreationTime);
                }
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new CommentViewModel()
            {
                Id = x.Id,
                Content = x.Content,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                EntityId = x.EntityId,
                EntityType = x.EntityType,
                UserId = x.UserId,
                OwnerUser = x.AppUser.Name + " (" + x.AppUser.Email + ")"
            }).ToListAsync();
            var pagination = new Pagination<CommentViewModel>
            {
                Items = items,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
            return Ok(pagination);
        }

        [HttpGet("{entityType}/{entityId}/client")]
        public async Task<IActionResult> GetCommentsForClient(int entityId, string entityType, string sortType)
        {
            var query = _khoaHocDbContext.Comments.Include(x => x.AppUser).AsNoTracking().Where(x => x.EntityId == entityId && x.EntityType == entityType).AsQueryable();
            if (!string.IsNullOrEmpty(sortType))
            {
                if (sortType == "new")
                {
                    query = query.OrderByDescending(x => x.CreationTime);
                }
                else
                {
                    query = query.OrderBy(x => x.CreationTime);
                }
            }
            var items = await query.Select(x => new CommentViewModel()
            {
                Id = x.Id,
                Content = x.Content,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                EntityId = x.EntityId,
                EntityType = x.EntityType,
                UserId = x.UserId,
                OwnerUser = x.AppUser.Name + " (" + x.AppUser.Email + ")"
            }).ToListAsync();
            return Ok(items);
        }

        [HttpGet("{commentId}")]
        public async Task<IActionResult> GetCommentDetail(int commentId)
        {
            var comment = await _khoaHocDbContext.Comments.FindAsync(commentId);
            if (comment == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found comment with id: {commentId}"));
            }
            var user = await _userManager.FindByIdAsync(comment.UserId.ToString());
            var commentViewModel = new CommentViewModel
            {
                Id = comment.Id,
                Content = comment.Content,
                CreationTime = comment.CreationTime,
                LastModificationTime = comment.LastModificationTime,
                EntityId = comment.EntityId,
                EntityType = comment.EntityType,
                UserId = comment.UserId,
                OwnerUser = user?.Name + " (" + user?.Email + ")",
            };
            return Ok(commentViewModel);
        }

        [HttpPost("{entityType}/{entityId}")]
        [ValidationFilter]
        public async Task<IActionResult> PostComment([FromBody] CommentCreateRequest request)
        {
            var comment = new Comment
            {
                Content = request.Content,
                EntityType = request.EntityType,
                EntityId = request.EntityId
            };
            if (request.EntityType.Equals("courses"))
            {
                var course = await _khoaHocDbContext.Courses.FindAsync(request.EntityId);
                if (course == null)
                {
                    return BadRequest(new ApiBadRequestResponse($"Cannot found course with id: {request.EntityId}"));
                }
                await _khoaHocDbContext.Comments.AddRangeAsync(comment);
            }
            else
            {
                var lesson = await _khoaHocDbContext.Lessons.FindAsync(request.EntityId);
                if (lesson == null)
                {
                    return BadRequest(new ApiBadRequestResponse($"Cannot found lesson with id: {request.EntityId}"));
                }
             
                await _khoaHocDbContext.Comments.AddRangeAsync(comment);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }

            return BadRequest(new ApiBadRequestResponse("Create comment failed"));
        }

        [HttpPut("{commentId}/{entityType}/{entityId}")]
        [ValidationFilter]
        public async Task<IActionResult> PutComment(int commentId, [FromBody] CommentCreateRequest request)
        {
            var comment = await _khoaHocDbContext.Comments.FindAsync(commentId);
            if (comment == null)
            {
                return BadRequest(new ApiBadRequestResponse($"Cannot found comment with id: {commentId}"));
            }

            var user = await _userManager.FindByIdAsync(comment.UserId.ToString());
            if (user.UserName != User.Identity.Name)
                return Forbid();
            comment.Content = request.Content;
            _khoaHocDbContext.Comments.Update(comment);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }

            return BadRequest(new ApiBadRequestResponse("Update comment failed"));
        }

        [HttpPost("delete-multi-items")]
        [ValidationFilter]
        public async Task<IActionResult> DeleteComment(List<int> request)
        {
            foreach (var commentId in request)
            {
                var comment = await _khoaHocDbContext.Comments.FindAsync(commentId);
                if (comment == null)
                {
                    return NotFound(new ApiNotFoundResponse($"Cannot found the comment with id: {commentId}"));
                }
                _khoaHocDbContext.Comments.Remove(comment);
              
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
                return Ok();
            return BadRequest(new ApiBadRequestResponse($"Delete comment failed"));
        }

    }
}
