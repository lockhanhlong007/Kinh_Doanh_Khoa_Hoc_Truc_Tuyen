using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnnouncementsController : ControllerBase
    {
        private readonly EKhoaHocDbContext _khoaHocDbContext;
        private ILogger<CategoriesController> _logger;

        public AnnouncementsController(EKhoaHocDbContext khoaHocDbContext, ILogger<CategoriesController> logger)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
        }
        #region Mobile
        [HttpGet("{filter}")]
        public async Task<Pagination<AnnouncementViewModel>> GetAllUnReadPaging(bool filter,Guid userId, int pageIndex, int pageSize)
        {
            var query = from x in _khoaHocDbContext.Announcements.AsNoTracking()
                join y in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
                    on x.Id equals y.AnnouncementId
                    into xy
                from announceUser in xy.DefaultIfEmpty()
                where announceUser.HasRead == false && (announceUser.UserId == null || announceUser.UserId == userId)
                select x;
            if (filter)
            {
                query = query.Where(x => x.EntityType.Equals("public")).AsNoTracking();
            }
            var totalRow = query.Count();
            var model = await query.OrderByDescending(x => x.CreationTime).Skip(pageSize * (pageIndex - 1)).Take(pageSize).Select(x => new AnnouncementViewModel()
            {
                UserId = x.UserId,
                Status = x.Status,
                EntityType = x.EntityType,
                CreationTime = x.CreationTime,
                LastModificationTime = x.LastModificationTime,
                Content = x.Content,
                EntityId = x.EntityId,
                Title = x.Title,
                Image = x.Image,
                Id = x.Id
            }).ToListAsync();
            return new Pagination<AnnouncementViewModel>
            {
                Items = model,
                TotalRecords = totalRow,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
        }

        [HttpGet]
        public List<AnnouncementViewModel> GetAllUnRead(Guid userId) =>
            (from _ in _khoaHocDbContext.Announcements.AsNoTracking()
                join __ in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
              on _.Id equals __.AnnouncementId
                 into ___
             from ____ in ___.DefaultIfEmpty()
             where ____.HasRead == false && (____.UserId == null || ____.UserId == userId)
             orderby _.CreationTime descending
             select new { _, ____ }).ToList().Select(_ => new AnnouncementViewModel
             {
                 Status = _._.Status,
                 UserId = _._.UserId,
                 CreationTime = _._.CreationTime,
                 Title = _._.Title,
                 Content = _._.Content,
                 LastModificationTime = _._.LastModificationTime,
                 Id = _._.Id,
                 Image = _._.Image,
                 EntityId = _._.EntityId,
                 EntityType = _._.EntityType,
             }).ToList();



        [HttpPost]
        public async Task<bool> MarkAsRead(string announceId, Guid userId)
        {
            var result = false;
            var announce = await _khoaHocDbContext.AnnouncementUsers.AsNoTracking().FirstOrDefaultAsync(_ => _.AnnouncementId == Guid.Parse(announceId) && _.UserId == userId);
            if (announce != null)
            {
                if (announce.HasRead == false)
                {
                    announce.HasRead = true;
                    result = true;
                }
            }
            return result;
        }

        [HttpGet("{id}")]
        public AnnouncementViewModel GetDetailAnnouncement(Guid id, Guid receiveId) => _khoaHocDbContext.Announcements.AsNoTracking()
                   .Join(_khoaHocDbContext.AnnouncementUsers.AsNoTracking(), _ => _.Id, _ => _.AnnouncementId, (_, __) => new { _, __ })
                   .Where(_ => _._.Id.Equals(id) && _.__.UserId == receiveId).ToList().Select(_ => new AnnouncementViewModel
                   {
                       Id = _._.Id,
                       Title = _._.Title,
                       Content = _._.Content,
                       Image = _._.Image,
                       UserId = _._.UserId,
                       CreationTime = _._.CreationTime,
                       LastModificationTime = _._.LastModificationTime,
                       Status = _._.Status,
                       EntityType = _._.EntityType,
                       EntityId = _._.EntityId
                   }).FirstOrDefault();


        #endregion Mobile
    }
}
