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
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
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
    //[Authorize("Bearer")]
    public class RolesController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;

        private readonly RoleManager<AppRole> _roleManager;

        private readonly EKhoaHocDbContext _khoaHocDbContext;

        private readonly ILogger<RolesController> _logger;

        public RolesController(RoleManager<AppRole> roleManager, EKhoaHocDbContext khoaHocDbContext, UserManager<AppUser> userManager, ILogger<RolesController> logger)
        {
            _roleManager = roleManager;
            _khoaHocDbContext = khoaHocDbContext;
            _userManager = userManager;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }

        [HttpGet("{id}")]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.View)]
        public async Task<IActionResult> GetById(string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role == null)
            {
                _logger.LogError($"Cannot find role with id: {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot find role with id: {id}"));
            }
            return Ok(new RoleViewModel
            {
                Id = role.Id,
                Name = role.Name
            });
        }

        [HttpPost]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.Update)]
        public async Task<IActionResult> PostRole(string name)
        {
            var role = new AppRole
            {
                Id = Guid.NewGuid(),
                Name = name,
                NormalizedName = name.ToUpper()
            };
            var result = await _roleManager.CreateAsync(role);
            if (result.Succeeded)
            {
                return CreatedAtAction(nameof(GetById), new { id = role.Id }, new RoleViewModel());
            }

            return BadRequest(new ApiBadRequestResponse(result));
        }

        [HttpGet]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.View)]
        public async Task<IActionResult> GetRoles()
        {
            return Ok(await _roleManager.Roles.Select(x => new RoleViewModel
            {
                Name = x.Name,
                Id = x.Id
            }).ToListAsync());
        }

        [HttpGet("filter")]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.View)]
        public async Task<IActionResult> GetRolesPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _roleManager.Roles;
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x=> x.Name.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(r => new RoleViewModel
            {
                Name = r.Name,
                Id = r.Id
            }).ToListAsync();
            var pagination = new Pagination<RoleViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpPut("{id}")]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.Update)]
        public async Task<IActionResult> PutRole(RoleViewModel roleViewModel)
        {
            var role = await _roleManager.FindByIdAsync(roleViewModel.Id.ToString());
            if (role == null)
            {
                _logger.LogError($"Cannot find role with id: {roleViewModel.Id}");
                return NotFound(new ApiNotFoundResponse($"Cannot find role with id: {roleViewModel.Id}"));
            }

            role.Name = roleViewModel.Name;
            role.NormalizedName = roleViewModel.Name.ToUpper();
            var result = await _roleManager.UpdateAsync(role);
            if (result.Succeeded)
            {
                return NoContent();
            }
            _logger.LogError("Update role failed");
            return BadRequest(new ApiBadRequestResponse(result));
        }

        [HttpPost("delete-multi-items")]
        [ClaimRequirement(FunctionConstant.Role, CommandConstant.Delete)]
        public async Task<IActionResult> DeleteRole(List<string> ids)
        {
            if (ids.Contains("Admin"))
            {
                _logger.LogError("Cannot delete role: Admin");
                return BadRequest(new ApiBadRequestResponse($"Cannot delete role: Admin"));

            }
            foreach (var id in ids)
            {

                var role = await _roleManager.FindByIdAsync(id);
                if (role == null)
                {
                    _logger.LogError($"Cannot find role with id: {id}");
                    return NotFound(new ApiNotFoundResponse($"Cannot find role with id: {id}"));
                }

                var userInRole = (await _userManager.GetUsersInRoleAsync(role.Name)).ToList();
                if (userInRole.Count > 0)
                {
                    userInRole.ForEach(async u => await _userManager.RemoveFromRoleAsync(u, role.Name));
                }

                var permission = _khoaHocDbContext.Permissions.Where(x => x.RoleId.Equals(Guid.Parse(id)));
                if (permission.Any())
                {
                    _khoaHocDbContext.Permissions.RemoveRange(permission);
                    await _khoaHocDbContext.SaveChangesAsync();
                }
                var result = await _roleManager.DeleteAsync(role);
                if (result.Succeeded)
                {
                    _logger.LogError("Delete role failed");
                    return BadRequest(new ApiBadRequestResponse(result));
                }
            } 
            return Ok();
        }

        [HttpGet("{roleId}/permissions")]
        [ClaimRequirement(FunctionConstant.Permission, CommandConstant.View)]
        public async Task<IActionResult> GetPermissionByRoleId(string roleId)
        {
            var permissions = from p in _khoaHocDbContext.Permissions
                              join c in _khoaHocDbContext.Commands on p.CommandId equals c.Id
                              where p.RoleId == Guid.Parse(roleId)
                              select new PermissionViewModel
                              {
                                  RoleId = p.RoleId,
                                  CommandId = p.CommandId,
                                  FunctionId = p.FunctionId
                              };
            return Ok(await permissions.ToListAsync());
        }

        [HttpPut("{roleId}/permissions")]
        [ClaimRequirement(FunctionConstant.Permission, CommandConstant.View)]
        [ValidationFilter]
        public async Task<IActionResult> PutPermissionByRoleId(Guid roleId, [FromBody] UpdatePermissionRequest request)
        {
            try
            {
                var newPermissions = request.Permissions.Select(p => new Permission(p.FunctionId, roleId, p.CommandId)).ToList();
                var existingPermissions = await _khoaHocDbContext.Permissions.AsNoTracking().Where(x => x.RoleId.Equals(roleId)).ToListAsync();
                if (existingPermissions.Any())
                {
                    _khoaHocDbContext.Permissions.RemoveRange(existingPermissions);
                }
                await _khoaHocDbContext.AddRangeAsync(newPermissions);
                var result =  await _khoaHocDbContext.SaveChangesAsync();
                if (result > 0)
                {
                    return NoContent();
                }
                _logger.LogError("Save permission failed");
                return BadRequest(new ApiBadRequestResponse("Save permission failed"));
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return BadRequest(new ApiBadRequestResponse(e.Message));
            }
        }
    }
}
