using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using KnowledgeSpace.BackendServer.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StatisticsController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<StatisticsController> _logger;
        public readonly UserManager<AppUser> _userManager;
        private readonly IConfiguration _configuration;
        public StatisticsController(EKhoaHocDbContext khoaHocDbContext, ILogger<StatisticsController> logger, UserManager<AppUser> userManager, IConfiguration configuration)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
            _userManager = userManager;
            _configuration = configuration;
        }

        [HttpGet("new-register")]
        [ClaimRequirement(FunctionConstant.NewUser, CommandConstant.View)]
        public async Task<IActionResult> GetNewRegisters(string dateFrom, string dateTo)
        {
            var data = await _khoaHocDbContext.Users.Where(x => x.CreationTime.Date >= DateTime.Parse(dateFrom).Date && x.CreationTime.Date <= DateTime.Parse(dateTo).Date)
                .GroupBy(x => x.CreationTime.Date)
                .Select(g => new DateStatisticViewModel()
                {
                    Date = g.Key.ToString(),
                    NumberOfValue = g.Count()
                })
                .ToListAsync();

            return Ok(data);
        }

        [HttpGet("revenue-daily")]
        [ClaimRequirement(FunctionConstant.Revenue, CommandConstant.View)]
        public async Task<IActionResult> GetRevenueDaily(string dateFrom, string dateTo)
        {
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var dynamicParameters = new DynamicParameters();
            dynamicParameters.Add("@fromDate", dateFrom);
            dynamicParameters.Add("@toDate", dateTo);
            var result = await conn.QueryAsync<RevenueViewModel>("GetRevenueDaily", dynamicParameters, null, 120, CommandType.StoredProcedure);
            return Ok(result.ToList());
        }
        [HttpGet("count-sales-daily")]
        [ClaimRequirement(FunctionConstant.Revenue, CommandConstant.View)]
        public async Task<IActionResult> GetCountSalesDaily(string dateFrom,string dateTo)
        {
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var dynamicParameters = new DynamicParameters();
            dynamicParameters.Add("@fromDate", dateFrom);
            dynamicParameters.Add("@toDate", dateTo);
            var result = await conn.QueryAsync<RevenueViewModel>("GetCountSalesDaily", dynamicParameters, null, 120, CommandType.StoredProcedure);
            return Ok(result.ToList());
        }
    }
}
