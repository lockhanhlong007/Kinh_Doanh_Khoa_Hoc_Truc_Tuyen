﻿using System;
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
    public class UsersController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;

        private readonly EKhoaHocDbContext _khoaHocDbContext;

        private readonly RoleManager<AppRole> _roleManager;

        private readonly ILogger<UsersController> _logger;
        public UsersController(UserManager<AppUser> userManager, EKhoaHocDbContext khoaHocDbContext, RoleManager<AppRole> roleManager, ILogger<UsersController> logger)
        {
            _userManager = userManager;
            _khoaHocDbContext = khoaHocDbContext;
            _roleManager = roleManager;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }

        [HttpPost]
        // [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.CREATE)]
        [ValidationFilter]
        public async Task<IActionResult> PostUser(UserCreateRequest request)
        {
            var user = new AppUser
            {
                Id = Guid.NewGuid(),
                Email = request.Email,
                Dob = DateTime.Parse(request.Dob),
                UserName = request.UserName,
                Name = request.Name,
                PhoneNumber = request.PhoneNumber,
                Avatar = request.Avatar ?? "/img/defaultAvatar.png",
                Biography = request.Biography
            };
            var result = await _userManager.CreateAsync(user, request.Password);
            if (result.Succeeded)
            {
                return CreatedAtAction(nameof(GetById), new { id = user.Id }, request);
            }
            _logger.LogError("Create user failed");
            return BadRequest(new ApiBadRequestResponse(result));
        }

        [HttpGet("{id}")]
       // [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.VIEW)]
        public async Task<IActionResult> GetById(string id)
        {
            var result = await _userManager.FindByIdAsync(id);
            if (result == null)
            {
                _logger.LogError($"Cannot found user with id: {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found user with id: {id}"));
            }

            return Ok(new UserViewModel
            {
                Dob = result.Dob,
                Email = result.Email,
                Id = result.Id,
                Name = result.Name,
                PhoneNumber = result.PhoneNumber,
                UserName = result.UserName,
                Avatar = result.Avatar ?? "/img/defaultAvatar.png",
                Biography = result.Biography
            });
        }

        [HttpGet]
       // [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.VIEW)]
        public async Task<IActionResult> GetUsers()
        {
            var user = await _userManager.Users.Select(x => new UserViewModel
            {
                UserName = x.UserName,
                Email = x.Email,
                PhoneNumber = x.PhoneNumber,
                Name = x.Name,
                Dob = x.Dob,
                Id = x.Id,
                Avatar = x.Avatar ?? "/img/defaultAvatar.png",
                Biography = x.Biography
            }).ToListAsync();
            if (user.Any())
            {
                return Ok(user);
            }
            _logger.LogError("Cannot found user");
            return NotFound(new ApiNotFoundResponse("Cannot found user"));
        }

        [HttpGet("filter")]
       // [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.VIEW)]
        public async Task<IActionResult> GetUsersPaging(string filter, int pageIndex, int pageSize)
        {
            var query = _userManager.Users;
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x =>
                    x.Email.Contains(filter) || x.UserName.Contains(filter) || x.PhoneNumber.Contains(filter));
            }

            var totalRecords = await query.CountAsync();
            var items = await query.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(u => new UserViewModel
            {
                UserName = u.UserName,
                Email = u.Email,
                PhoneNumber = u.PhoneNumber,
                Name = u.Name,
                Dob = u.Dob,
                Id = u.Id,
                Avatar = u.Avatar ?? "/img/defaultAvatar.png",
                Biography = u.Biography
            }).ToListAsync();
            var pagination = new Pagination<UserViewModel>
            {
                Items = items,
                TotalRecords = totalRecords
            };
            return Ok(pagination);
        }

        [HttpPut("{id}")]
      //  [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.UPDATE)]
      public async Task<IActionResult> PutUser(string id, [FromBody] UserCreateRequest request)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                _logger.LogError($"Cannot found user with id: {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found user with id: {id}"));
            }

            user.Name = request.Name;
            user.Dob = DateTime.Parse(request.Dob);
            user.Avatar = request.Avatar ?? "/img/defaultAvatar.png";
            user.Biography = request.Biography;
            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
            {
                return NoContent();
            }
            _logger.LogError("Update user failed");
            return BadRequest(new ApiBadRequestResponse(result));
        }

        [HttpPut("{id}/change-password")]
        //  [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.UPDATE)]
        [ValidationFilter]
        public async Task<IActionResult> PutUserPassword(string id, [FromBody] UserPasswordChangeRequest request)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                _logger.LogError($"Cannot found user with id: {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found user with id: {id}"));
            }

            var result = await _userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);
            if (result.Succeeded)
            {
                return NoContent();
            }

            _logger.LogError("Change password failed");
            return BadRequest(new ApiBadRequestResponse(result));
        }

        [HttpDelete("{id}")]
       // [ClaimRequirement(FunctionCode.SYSTEM_USER, CommandCode.DELETE)]
       // [ApiValidationFilter]
        public async Task<IActionResult> DeleteUser(string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                _logger.LogError($"Cannot found user with id: {id}");
                return NotFound(new ApiNotFoundResponse($"Cannot found user with id: {id}"));

            }
            var adminUsers = await _userManager.GetUsersInRoleAsync(SystemConstants.Admin);
            if (adminUsers.All(x => x.Id == Guid.Parse(id)))
            {
                _logger.LogError("You cannot remove the only admin user remaining.");
                return BadRequest(new ApiBadRequestResponse("You cannot remove the only admin user remaining."));
            }
            var result = await _userManager.DeleteAsync(user);
            if (result.Succeeded)
            {
                var userViewModel = new UserViewModel
                {
                    Id = user.Id,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    Name = user.Name,
                    Dob = user.Dob,
                    UserName = user.UserName,
                    Avatar = user.Avatar ?? "/img/defaultAvatar.png",
                    Biography = user.Biography
                };
                return Ok(userViewModel);
            }
            _logger.LogError("Delete user failed");
            return BadRequest(new ApiBadRequestResponse(result));
        }

       [HttpGet("{userId}/menu")]
       public async Task<IActionResult> GetMenuByUserPermission(string userId)
       {
           var user = await _userManager.FindByIdAsync(userId);
           var roles = await _userManager.GetRolesAsync(user);
           var query = from f in _khoaHocDbContext.Functions
               join p in _khoaHocDbContext.Permissions on f.Id equals p.FunctionId
               join r in _roleManager.Roles on p.RoleId equals r.Id
               join c in _khoaHocDbContext.Commands on p.CommandId equals c.Id
               where roles.Contains(r.Name) && c.Id == "View"
               select new FunctionViewModel
               {
                   Id = f.Id,
                   Name = f.Name,
                   ParentId = f.ParentId,
                   SortOrder = f.SortOrder,
                   Url = f.Url,
                   Icon = f.Icon
               };
           var data = await query.Distinct()
               .OrderBy(x => x.ParentId)
               .ThenBy(x => x.SortOrder)
               .ToListAsync();
           return Ok(data);
       }
    }
}
