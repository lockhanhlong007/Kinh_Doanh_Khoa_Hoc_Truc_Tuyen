﻿

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
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {


        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<CategoriesController> _logger;

        public CategoriesController(EKhoaHocDbContext khoaHocDbContext, ILogger<CategoriesController> logger)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }

        [HttpGet("{id}")]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.View)]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _khoaHocDbContext.Categories.FindAsync(id);
            if (result == null)
            {
                return NotFound(new ApiNotFoundResponse($"Category with id: {id} is not found"));
            }

            return Ok(new CategoryViewModel()
            {
                Name = result.Name,
                SortOrder = result.SortOrder,
                ParentId = result.ParentId,
                Id = result.Id
            });
        }

        [HttpPost]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.Create)]
        [ValidationFilter]
        public async Task<IActionResult> PostCategory([FromBody] CategoryCreateRequest request)
        {
            var category = new Category()
            {
                Name = request.Name,
                SortOrder = request.SortOrder,
                ParentId = request.ParentId
            };
            await _khoaHocDbContext.Categories.AddAsync(category);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return CreatedAtAction(nameof(GetById), new { id = category.Id }, request);
            }

            return BadRequest(new ApiBadRequestResponse("Create category failed"));
        }

        [HttpGet]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.View)]
        public async Task<IActionResult> GetCategories()
        {
            return Ok(await _khoaHocDbContext.Categories.Select(x => new CategoryViewModel()
            {
                Name = x.Name,
                SortOrder = x.SortOrder,
                ParentId = x.ParentId,
                Id = x.Id,
            }).ToListAsync());
        }

        [HttpGet("filter")]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.View)]
        public async Task<IActionResult> GetCategoriesPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.Categories.AsNoTracking().AsQueryable();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x => x.Name.Contains(filter) || x.Name.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new CategoryViewModel()
            {
                Name = x.Name,
                SortOrder = x.SortOrder,
                ParentId = x.ParentId,
                Id = x.Id,
            }).ToListAsync();
            var pagination = new Pagination<CategoryViewModel>
            {
                TotalRecords = totalRecords,
                Items = items
            };
            return Ok(pagination);
        }
        
        [HttpPut("{id}")]
        [ValidationFilter]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.Update)]
        public async Task<IActionResult> PutCategory(int id, [FromBody] CategoryCreateRequest request)
        {
            var category = await _khoaHocDbContext.Categories.FindAsync(id);
            if (category == null)
            {
                return NotFound(new ApiNotFoundResponse($"Category with id: {id} is not found"));
            }
            if (id == request.ParentId)
            {
                return BadRequest(new ApiBadRequestResponse("Category cannot be a child itself."));
            }
            category.Name = request.Name;
            category.ParentId = request.ParentId;
            category.SortOrder = request.SortOrder;
            _khoaHocDbContext.Categories.Update(category);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return NoContent();
            }
            return BadRequest(new ApiBadRequestResponse("Update category failed"));
        }
        [HttpGet("{functionId}/parents")]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.View)]
        public async Task<IActionResult> GetFunctionsByParentId(int id)
        {
            var categories = _khoaHocDbContext.Categories.Where(x => x.Id != id).OrderBy(x => x.ParentId).ThenBy(x => x.SortOrder).ThenBy(x => x.SortOrder);
            return Ok(await categories.Select(u => new CategoryViewModel
            {
                Id = u.Id,
                Name = u.Name,
                SortOrder = u.SortOrder,
                ParentId = u.ParentId,
            }).ToListAsync());
        }

        [HttpPost("delete-multi-items")]
        [ClaimRequirement(FunctionConstant.Categories, CommandConstant.Delete)]
        public async Task<IActionResult> DeleteCategory(List<int> ids)
        {
            foreach (var id in ids)
            {
                var category = await _khoaHocDbContext.Categories.FindAsync(id);
                if (category == null)
                {
                    return NotFound(new ApiNotFoundResponse($"Category with id: {id} is not found"));
                }
                _khoaHocDbContext.Categories.Remove(category);
              
            }
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            return BadRequest(new ApiBadRequestResponse("Delete category failed"));
        }

    }
}
