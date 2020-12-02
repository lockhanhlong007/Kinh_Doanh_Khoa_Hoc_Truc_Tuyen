
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Microsoft.AspNetCore.Identity;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF
{
    public class DbInitializer
    {
        private readonly EKhoaHocDbContext _applicationDbContext;
        private readonly UserManager<AppUser> _userManager;
        private readonly RoleManager<AppRole> _roleManager;
        private const string AdminRoleName = "Admin";
        private const string TeacherRoleName = "Teacher";
        private const string StudentRoleName = "Student";

        public DbInitializer(EKhoaHocDbContext applicationDbContext,
          UserManager<AppUser> userManager,
          RoleManager<AppRole> roleManager)
        {
            _applicationDbContext = applicationDbContext;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public async Task Seed()
        {
            #region Roles
            if (!_roleManager.Roles.Any())
            {
                await _roleManager.CreateAsync(new AppRole
                {
                    Id = Guid.NewGuid(),
                    Name = AdminRoleName,
                    NormalizedName = AdminRoleName.ToUpper(),
                });
                await _roleManager.CreateAsync(new AppRole
                {
                    Id = Guid.NewGuid(),
                    Name = TeacherRoleName,
                    NormalizedName = TeacherRoleName.ToUpper(),
                });
                await _roleManager.CreateAsync(new AppRole
                {
                    Id = Guid.NewGuid(),
                    Name = StudentRoleName,
                    NormalizedName = StudentRoleName.ToUpper(),
                });
            }
            #endregion

            #region Users
            if (!_userManager.Users.Any())
            {
                var result = await _userManager.CreateAsync(new AppUser
                {
                    Id = Guid.NewGuid(),
                    UserName = "admin",
                    Name = "Trần Bảo Long",
                    Email = "lockhanhlong007@gmail.com",
                    Avatar = "/img/defaultAvatar.png",
                    EmailConfirmed = true,
                    Dob = new DateTime(1999,7,11),
                    PhoneNumber = "0965453699",
                    LockoutEnabled = false
                }, "123@qwe");
                if (result.Succeeded)
                {
                    var user = await _userManager.FindByNameAsync("admin");
                    await _userManager.AddToRoleAsync(user, AdminRoleName);
                }
                var result1 = await _userManager.CreateAsync(new AppUser
                {
                    Id = Guid.NewGuid(),
                    UserName = "teacher1",
                    Name = "Trần Bảo Long",
                    Email = "teacher1@gmail.com",
                    EmailConfirmed = true,
                    Avatar = "/img/defaultAvatar.png",
                    Biography = "Hiện anh đang đảm nhận vai trò Technical Architect tại một trong những công ty outsource cho thị trường Âu, Mỹ hàng đầu tại Việt Nam.",
                    Dob = new DateTime(1999, 7, 11),
                    PhoneNumber = "0765432688",
                    LockoutEnabled = false
                }, "123@qwe");
                if (result1.Succeeded)
                {
                    var user = await _userManager.FindByNameAsync("teacher1");
                    await _userManager.AddToRoleAsync(user, TeacherRoleName);
                }
                var result2 = await _userManager.CreateAsync(new AppUser
                {
                    Id = Guid.NewGuid(),
                    UserName = "student1",
                    Name = "Trần Bảo Long",
                    Email = "student1@gmail.com",
                    EmailConfirmed = true,
                    PhoneNumber = "0865432688",
                    Avatar = "/img/defaultAvatar.png",
                    Dob = new DateTime(1999, 7, 11),
                    LockoutEnabled = false
                }, "123@qwe");
                if (result2.Succeeded)
                {
                    var user = await _userManager.FindByNameAsync("student1");
                    await _userManager.AddToRoleAsync(user, StudentRoleName);
                }
                var result3 = await _userManager.CreateAsync(new AppUser
                {
                    Id = Guid.NewGuid(),
                    UserName = "user1",
                    Name = "Trần Bảo Long",
                    Email = "user1@gmail.com",
                    Avatar = "/img/defaultAvatar.png",
                    EmailConfirmed = false,
                    PhoneNumber = "0965432688",
                    Dob = new DateTime(1999, 7, 11),
                    LockoutEnabled = false
                }, "123@qwe");
                if (result3.Succeeded)
                {
                    var user = await _userManager.FindByNameAsync("user1");
                    await _userManager.AddToRoleAsync(user, StudentRoleName);
                }
            }
            #endregion

            #region Functions
            if (!_applicationDbContext.Functions.Any())
            {
                await _applicationDbContext.Functions.AddRangeAsync(new List<Function>
                {
                    new Function {Id = "DashBoard", Name = "Trang chủ", ParentId = null, SortOrder = 1, Url = "/dashboard",Icon="fa-dashboard" },

                    new Function {Id = "Products",Name = "Sản Phẩm",ParentId = null, SortOrder = 2, Url = "/products",Icon="fa-table" },

                    new Function {Id = "Categories",Name = "Danh mục",ParentId ="Product", SortOrder = 1, Url = "/products/categories",Icon="fa-edit"  },
                    new Function {Id = "Courses",Name = "Khóa Học",ParentId = "Product", SortOrder = 2, Url = "/products/knowledge-bases",Icon="fa-edit" },
                    new Function {Id = "Comments",Name = "Bình Luận",ParentId = "Product", SortOrder = 3, Url = "/products/comments",Icon="fa-edit" },

                    new Function {Id = "Statistics",Name = "Thống kê", ParentId = null, SortOrder = 3, Url = "/statistics",Icon="fa-bar-chart-o" },

                    new Function {Id = "NewUser",Name = "Đăng ký",ParentId = "Statistics", SortOrder = 1, Url = "/statistics/new-user",Icon = "fa-wrench"},
                    new Function {Id = "Revenue",Name = "Doanh thu",ParentId = "Statistics", SortOrder = 2, Url = "/statistics/revenue",Icon = "fa-wrench"},

                    new Function {Id = "System", Name = "Hệ thống", ParentId = null, SortOrder = 4, Url = "/systems",Icon="fa-th-list" },
                    new Function {Id = "User", Name = "Người dùng",ParentId = "System", SortOrder = 1, Url = "/systems/users",Icon="fa-desktop"},
                    new Function {Id = "Role", Name = "Nhóm quyền",ParentId = "System", SortOrder = 2, Url = "/systems/roles",Icon="fa-desktop"},
                    new Function {Id = "Function", Name = "Chức năng",ParentId = "System", SortOrder = 3, Url = "/systems/functions",Icon="fa-desktop"},
                    new Function {Id = "Permission", Name = "Quyền hạn",ParentId = "System", SortOrder = 4, Url = "/systems/permissions",Icon="fa-desktop"},
                });
                await _applicationDbContext.SaveChangesAsync();
            }
            #endregion

            #region Commands
            if (!_applicationDbContext.Commands.Any())
            {
                await _applicationDbContext.Commands.AddRangeAsync(new List<Command>
                {
                    new Command {Id = "View", Name = "Xem"},
                    new Command {Id = "Create", Name = "Thêm"},
                    new Command {Id = "Update", Name = "Sửa"},
                    new Command {Id = "Delete", Name = "Xoá"},
                    new Command {Id = "ExportExcel", Name = "Xuất Excel"},
                });
                await _applicationDbContext.SaveChangesAsync();
            }
            #endregion

            #region Commands In Functions
            var functions = _applicationDbContext.Functions;
            if (!_applicationDbContext.CommandInFunctions.Any())
            {
                foreach (var function in functions)
                {
                    var createAction = new CommandInFunction
                    {
                        CommandId = "Create",
                        FunctionId = function.Id
                    };
                    await _applicationDbContext.CommandInFunctions.AddAsync(createAction);

                    var updateAction = new CommandInFunction
                    {
                        CommandId = "Update",
                        FunctionId = function.Id
                    };
                    await _applicationDbContext.CommandInFunctions.AddAsync(updateAction);
                    
                    var deleteAction = new CommandInFunction
                    {
                        CommandId = "Delete",
                        FunctionId = function.Id
                    };
                    await _applicationDbContext.CommandInFunctions.AddAsync(deleteAction);

                    var viewAction = new CommandInFunction
                    {
                        CommandId = "View",
                        FunctionId = function.Id
                    };
                    await _applicationDbContext.CommandInFunctions.AddAsync(viewAction);
                }
                var exportAction = new List<CommandInFunction>
                {
                    new CommandInFunction
                    {
                        CommandId = "ExportExcel",
                        FunctionId = "Revenue"
                    },
                    new CommandInFunction
                    {
                        CommandId = "ExportExcel",
                        FunctionId = "NewUser"
                    }
                };
                await _applicationDbContext.CommandInFunctions.AddRangeAsync(exportAction);
                await _applicationDbContext.SaveChangesAsync();
            }
            #endregion

            #region Permissions
            if (!_applicationDbContext.Permissions.Any())
            {
                var adminRole = await _roleManager.FindByNameAsync(AdminRoleName);
                foreach (var function in functions)
                {
                    await _applicationDbContext.Permissions.AddAsync(new Permission(function.Id, adminRole.Id, "Create"));
                    await _applicationDbContext.Permissions.AddAsync(new Permission(function.Id, adminRole.Id, "Update"));
                    await _applicationDbContext.Permissions.AddAsync(new Permission(function.Id, adminRole.Id, "Delete"));
                    await _applicationDbContext.Permissions.AddAsync(new Permission(function.Id, adminRole.Id, "View"));
                    await _applicationDbContext.Permissions.AddAsync(new Permission(function.Id, adminRole.Id, "ExportExcel"));
                }
                
                var teacherRole = await _roleManager.FindByNameAsync(TeacherRoleName);
                await _applicationDbContext.Permissions.AddAsync(new Permission("Courses", teacherRole.Id, "Create"));
                await _applicationDbContext.Permissions.AddAsync(new Permission("Courses", teacherRole.Id, "Delete"));
                await _applicationDbContext.Permissions.AddAsync(new Permission("Courses", teacherRole.Id, "View"));
            }
            await _applicationDbContext.SaveChangesAsync();
            #endregion
        }
    }
}
