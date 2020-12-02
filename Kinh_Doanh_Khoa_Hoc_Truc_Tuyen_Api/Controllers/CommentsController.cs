using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using KnowledgeSpace.BackendServer.Authorization;
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





        [HttpGet("{entityType}/{entityId}/comments/filter")]
        [ClaimRequirement(FunctionConstant.Comments, CommandConstant.View)]
        public async Task<IActionResult> GetCommentsPaging(int entityId, string entityType, string filter, int pageIndex,
            int pageSize)
        {
            var query = _khoaHocDbContext.Comments.AsNoTracking().Where(x => x.EntityId == entityId && x.EntityType == entityType).AsQueryable();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Content.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new CommentViewModel
            {
                Id = x.Id,
                Content = x.Content,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                EntityId = x.EntityId,
                EntityType = x.EntityType,
                UserId = x.UserId
            }).ToListAsync();
            var pagination = new Pagination<CommentViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpGet("{entityType}/{entityId}/comments/{commentId}")]
        [ClaimRequirement(FunctionConstant.Comments, CommandConstant.View)]
        public async Task<IActionResult> GetCommentDetail(int commentId)
        {
            var comment = await _khoaHocDbContext.Comments.FindAsync(commentId);
            if (comment == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found comment with id: {commentId}"));
            }
            var commentViewModel = new CommentViewModel
            {
                Id = comment.Id,
                Content = comment.Content,
                CreationTime = comment.CreationTime,
                LastModificationTime = comment.LastModificationTime,
                EntityId = comment.EntityId,
                EntityType = comment.EntityType,
                UserId = comment.UserId
            };
            return Ok(commentViewModel);
        }

        [HttpPost("{entityType}/{entityId}/comments")]
        [ClaimRequirement(FunctionConstant.Comments, CommandConstant.Create)]
        [ValidationFilter]
        public async Task<IActionResult> PostComment(int entityId, [FromBody] CommentCreateRequest request)
        {
            var comment = new Comment
            {
                Content = request.Content,
                EntityType = request.EntityType,
                EntityId = request.EntityId
            };
            if (request.EntityType.Equals("Course"))
            {
                var course = await _khoaHocDbContext.Courses.FindAsync(entityId);
                if (course == null)
                {
                    return BadRequest(new ApiBadRequestResponse($"Cannot found course with id: {entityId}"));
                }
                await _khoaHocDbContext.Comments.AddRangeAsync(comment);
            }
            else
            {
                var lesson = await _khoaHocDbContext.Lessons.FindAsync(entityId);
                if (lesson == null)
                {
                    return BadRequest(new ApiBadRequestResponse($"Cannot found course with id: {entityId}"));
                }
             
                await _khoaHocDbContext.Comments.AddRangeAsync(comment);
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return CreatedAtAction(nameof(GetCommentDetail), new { id = entityId, type = request.EntityType, commentId = comment.Id }, request);
            }

            return BadRequest(new ApiBadRequestResponse("Create comment failed"));
        }

        [HttpPut("{entityType}/{entityId}/comments/{commentId}")]
        [ClaimRequirement(FunctionConstant.Comments, CommandConstant.Update)]
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

            return BadRequest(new ApiBadRequestResponse($"Update comment failed"));
        }

        [HttpDelete("{entityType}/{entityId}/comments/{commentId}")]
        [ClaimRequirement(FunctionConstant.Comments, CommandConstant.Delete)]
        [ValidationFilter]
        public async Task<IActionResult> DeleteComment(int commentId)
        {
            var comment = await _khoaHocDbContext.Comments.FindAsync(commentId);
            if (comment == null)
            {
                return NotFound(new ApiNotFoundResponse($"Cannot found the comment with id: {commentId}"));
            }
            _khoaHocDbContext.Comments.Remove(comment);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result <= 0) return BadRequest(new ApiBadRequestResponse($"Delete comment failed"));
            var commentViewModel = new CommentViewModel
            {
                Content = comment.Content,
                EntityType = comment.EntityType,
                EntityId = comment.EntityId,
                Id = comment.Id,
                UserId = comment.UserId
            };
            return Ok(commentViewModel);
        }

    }
}
