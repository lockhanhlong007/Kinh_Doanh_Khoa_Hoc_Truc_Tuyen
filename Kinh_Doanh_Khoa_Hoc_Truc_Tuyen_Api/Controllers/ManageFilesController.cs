using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Claims;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Filter;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Helpers;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Services;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.Common;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ManageFilesController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;

        private ILogger<OrdersController> _logger;

        private readonly IStorageService _storageService;

        private readonly IConfiguration _configuration;

        public ManageFilesController(EKhoaHocDbContext khoaHocDbContext, ILogger<OrdersController> logger, IStorageService storageService, IConfiguration configuration)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
            _storageService = storageService;
            _configuration = configuration;
        }

        [HttpPost("backup-file")]
        [ValidationFilter]
        [ClaimRequirement(FunctionConstant.BackupRestore, CommandConstant.Create)]
        public async Task<IActionResult> PostBackupFile(ManageFileCreateRequest request)
        {
            if (request.FileName.Contains("."))
            {
                _logger.LogError("Không được thêm đuôi file cho tên file");
                return BadRequest(new ApiBadRequestResponse("Không được thêm đuôi file cho tên file"));
            }
            if (request.FileName.Contains("-"))
            {
                _logger.LogError("Không được thêm dấu gạch ngang cho tên file");
                return BadRequest(new ApiBadRequestResponse("Không được thêm dấu gạch ngang cho tên file"));
            }
            var saveFileName = request.FileName + "-" + DateTime.Now.ToString("dd_MM_yyyy_HH_mm_ss") + "_Full.bak";
            var filePath = _storageService.GetFileDirectory("backup-restore-files", saveFileName);
            var query = $@"backup database {_configuration["DatabaseName"]} to disk = '{filePath}' with init";
            var file = new ManageFile()
            {
                FileName = saveFileName,
                FilePath = "backup-restore-files/" + saveFileName,
                CountRestore = 0
            };
            await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            if (conn.State == ConnectionState.Closed)
            {
                await conn.OpenAsync();
            }
            var resultQuery = await conn.ExecuteAsync(query, null, null, 120, CommandType.Text);
            await _khoaHocDbContext.ManageFiles.AddAsync(file);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            _logger.LogError("Sao lưu thất bại");
            return BadRequest(new ApiBadRequestResponse("Sao lưu thất bại"));

        }

        [HttpGet("backup-file/filter")]
        [ClaimRequirement(FunctionConstant.BackupRestore, CommandConstant.View)]
        public IActionResult GetBackupFilePaging(string filter, int pageIndex, int pageSize)
        {
            var query = _khoaHocDbContext.ManageFiles.AsEnumerable();
            if (!string.IsNullOrEmpty(filter))
            {
                query = query.Where(x =>x.FileName.ToLower().Contains(filter) ||
                    x.FileName.convertToUnSign().ToLower().Contains(filter.convertToUnSign().ToLower()));
            }
            var data = query.ToList();
            var totalRecords = data.Count();
            var items = data.Skip((pageIndex - 1) * pageSize).Take(pageSize).Select(x => new ManageFileViewModel
            {
               FileName = x.FileName,
               CountRestore = x.CountRestore,
               LastModificationTime = x.LastModificationTime,
               CreationTime = x.CreationTime,
               FilePath = _storageService.GetFileUrl(x.FilePath),
               Id = x.Id
            }).ToList();
            var pagination = new Pagination<ManageFileViewModel>
            {
                Items = items,
                TotalRecords = totalRecords,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
            return Ok(pagination);
        }

        [HttpPost("restore-file-{id}")]
        [ClaimRequirement(FunctionConstant.BackupRestore, CommandConstant.Create)]
        public async Task<IActionResult> PostRestoreFile(int id)
        {
            try
            {
                var fileDetail = await _khoaHocDbContext.ManageFiles.FirstOrDefaultAsync(x => x.Id == id);
                if (fileDetail == null)
                {
                    _logger.LogError($"Không tìm thấy file với id: {id}");
                    return BadRequest(new ApiNotFoundResponse($"Không tìm thấy file với id: {id}"));
                }

                fileDetail.CountRestore += 1;
                _khoaHocDbContext.ManageFiles.Update(fileDetail);
                await _khoaHocDbContext.SaveChangesAsync();
                var restorePath = _storageService.GetFileDirectory("backup-restore-files", fileDetail.FileName);
                var query = $@"alter database {_configuration["DatabaseName"]} set offline with rollback immediate
                               restore database {_configuration["DatabaseName"]} from disk = '{restorePath}' with replace
                               alter database {_configuration["DatabaseName"]} set online";
                await using SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                if (conn.State == ConnectionState.Closed)
                {
                    await conn.OpenAsync();
                }
                var resultQuery = await conn.ExecuteAsync(query, null, null, 120, CommandType.Text);
                if (resultQuery != -1)
                {
                    _logger.LogError($"Lỗi restore");
                    return BadRequest(new ApiBadRequestResponse("Lỗi restore"));
                }
                return Ok();
            }
            catch (Exception e)
            {
                _logger.LogError(e.Message);
                return BadRequest(new ApiBadRequestResponse($"Lỗi restore: " + e.Message));
            }
        }

        [HttpPut("backup-file-{id}")]
        [ClaimRequirement(FunctionConstant.BackupRestore, CommandConstant.Update)]
        public async Task<IActionResult> PutBackupFile(int id, ManageFileCreateRequest request)
        {
            if (request.FileName.Contains("."))
            {
                _logger.LogError("Không được thêm đuôi file cho tên file");
                return BadRequest(new ApiBadRequestResponse("Không được thêm đuôi file cho tên file"));
            }
            if (request.FileName.Contains("-"))
            {
                _logger.LogError("Không được thêm dấu gạch ngang cho tên file");
                return BadRequest(new ApiBadRequestResponse("Không được thêm dấu gạch ngang cho tên file"));
            }
            var fileDetail = await _khoaHocDbContext.ManageFiles.FirstOrDefaultAsync(x => x.Id == id);
            if (fileDetail == null)
            {
                _logger.LogError($"Không tìm thấy {request.FileName} với id: {id}");
                return BadRequest(new ApiNotFoundResponse($"Không tìm thấy {request.FileName} với id: {id}"));
            }
            var saveFileName =  request.FileName + "-" + DateTime.Now.ToString("dd_MM_yyyy_HH_mm_ss") + "_Full.bak";
            await _storageService.RenameFileFolderAsync(saveFileName, fileDetail.FileName, "backup-restore-files");
            fileDetail.FileName = saveFileName; // file abc.bak
            fileDetail.FilePath = _storageService.GetFileUrl(saveFileName); // localhost/ABC/abc.bak
            _khoaHocDbContext.ManageFiles.Update(fileDetail);
            var result = await _khoaHocDbContext.SaveChangesAsync();
            if (result > 0)
            {
                return Ok();
            }
            _logger.LogError("Đổi tên file thất bại");
            return BadRequest(new ApiBadRequestResponse("Đổi tên file thất bại"));
        }

        [HttpGet("backup-file-{id}")]
        [ClaimRequirement(FunctionConstant.BackupRestore, CommandConstant.Update)]
        public async Task<IActionResult> GetBackupFile(int id)
        {

            var fileDetail = await _khoaHocDbContext.ManageFiles.FirstOrDefaultAsync(x => x.Id == id);
            if (fileDetail == null)
            {
                _logger.LogError($"Không tìm thấy file với id: {id}");
                return BadRequest(new ApiNotFoundResponse($"Không tìm thấy file với id: {id}"));
            }
            var result = new ManageFileViewModel()
            {
                LastModificationTime = fileDetail.LastModificationTime,
                CreationTime = fileDetail.CreationTime,
                FileName = fileDetail.FileName,
                FilePath = _storageService.GetFileUrl(fileDetail.FilePath),
                CountRestore = fileDetail.CountRestore,
                Id = fileDetail.Id
            };
            return Ok(result);
        }

    }
}
