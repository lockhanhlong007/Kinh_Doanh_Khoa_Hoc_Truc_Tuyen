﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize("Bearer")]
    public class CommandsController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;

        public CommandsController(EKhoaHocDbContext khoaHocDbContext)
        {
            _khoaHocDbContext = khoaHocDbContext;
        }


        [HttpGet]
        public async Task<IActionResult> GetCommands()
        {
            var user = User.Identity.Name;
            var commands = _khoaHocDbContext.Commands;
            var commandViewModels = await commands.Select(u => new CommandViewModel()
            {
                Id = u.Id,
                Name = u.Name
            }).ToListAsync();
            return Ok(commandViewModels);
        }
    }
}
