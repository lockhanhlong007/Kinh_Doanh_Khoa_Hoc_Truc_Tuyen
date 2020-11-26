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
        //[ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.VIEW)]
        public async Task<IActionResult> GetById(string id)
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
       // [ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.CREATE)]
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
        //[ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.VIEW)]
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
        //[ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.VIEW)]
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
        //[ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.UPDATE)]
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

        [HttpDelete("{id}")]
       // [ClaimRequirement(FunctionCode.CONTENT_CATEGORY, CommandCode.DELETE)]
        public async Task<IActionResult> DeleteCategory(string id)
        {
            var category = await _khoaHocDbContext.Categories.FindAsync(id);
            if (category == null)
            {
                return NotFound(new ApiNotFoundResponse($"Category with id: {id} is not found"));
            }
            _khoaHocDbContext.Categories.Remove(category);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok(new CategoryViewModel()
                {
                    Name = category.Name,
                    SortOrder = category.SortOrder,
                    ParentId = category.ParentId,
                    Id = category.Id
                });
            }
            return BadRequest(new ApiBadRequestResponse("Delete category failed"));
        }

    }
}
