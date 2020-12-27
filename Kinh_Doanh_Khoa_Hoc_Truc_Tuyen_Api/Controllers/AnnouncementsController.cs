using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.EF;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Spire.Xls;

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

        [HttpGet("private-paging/filter-{filter}")]
        public async Task<Pagination<AnnouncementViewModel>> GetAllUnReadPaging(string filter, Guid userId, int pageIndex, int pageSize)
        {
            IQueryable<Announcement> query;
            if (filter.Equals("false"))
            {
                query = from x in _khoaHocDbContext.Announcements.AsNoTracking()
                        join y in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
                            on x.Id equals y.AnnouncementId
                            into xy
                        from announceUser in xy.DefaultIfEmpty()
                        where x.Status == 1 && announceUser.UserId == userId
                        orderby !announceUser.HasRead descending, x.CreationTime descending
                        select x;
            }
            else
            {
                query = from x in _khoaHocDbContext.Announcements.AsNoTracking()
                        join y in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
                            on x.Id equals y.AnnouncementId
                            into xy
                        from announceUser in xy.DefaultIfEmpty()
                        where announceUser.HasRead == false && x.Status == 1 && announceUser.UserId == userId
                        orderby !announceUser.HasRead descending, x.CreationTime descending
                        select x;
            }
            var lstAnnounce = new List<AnnouncementViewModel>();
            var items = query.Skip(pageSize * (pageIndex - 1)).Take(pageSize);
            foreach (var announcement in items)
            {
                var announceViewModel = new AnnouncementViewModel();
                announceViewModel.UserId = announcement.UserId;
                announceViewModel.Status = announcement.Status;
                announceViewModel.EntityType = announcement.EntityType;
                announceViewModel.CreationTime = announcement.CreationTime;
                announceViewModel.LastModificationTime = announcement.LastModificationTime;
                announceViewModel.Content = announcement.Content;
                announceViewModel.EntityId = announcement.EntityId;
                announceViewModel.Title = announcement.Title;
                announceViewModel.Image = announcement.Image;
                announceViewModel.Id = announcement.Id;
                announceViewModel.TmpHasRead = announcement.AnnouncementUsers
                    .FirstOrDefault(x => x.AnnouncementId == announcement.Id)!.HasRead;
                lstAnnounce.Add(announceViewModel);
            }
            var totalRow = query.Count();
            var model = lstAnnounce;
            return new Pagination<AnnouncementViewModel>
            {
                Items = model,
                TotalRecords = totalRow,
                PageSize = pageSize,
                PageIndex = pageIndex
            };
        }

        [HttpGet("private-no-paging")]
        public List<AnnouncementViewModel> GetAllUnRead(Guid userId) =>
            (from _ in _khoaHocDbContext.Announcements.AsNoTracking()
             join __ in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
           on _.Id equals __.AnnouncementId
              into ___
             from ____ in ___.DefaultIfEmpty()
             where ____.HasRead == false && ____.UserId == userId && _.EntityType.Equals("private")
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

        [HttpGet("public-no-paging")]
        public List<AnnouncementViewModel> GetAllUnReadPublic() =>
            _khoaHocDbContext.Announcements.Where(x => x.Status == 0).OrderByDescending(x => x.CreationTime).ToList().Select(_ => new AnnouncementViewModel
            {
                Status = _.Status,
                UserId = _.UserId,
                CreationTime = _.CreationTime,
                Title = _.Title,
                Content = _.Content,
                LastModificationTime = _.LastModificationTime,
                Id = _.Id,
                Image = _.Image,
                EntityId = _.EntityId,
                EntityType = _.EntityType,
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
        public AnnouncementViewModel GetDetailAnnouncement(Guid announceId, Guid receiveId) => _khoaHocDbContext.Announcements.AsNoTracking()
                   .Join(_khoaHocDbContext.AnnouncementUsers.AsNoTracking(), _ => _.Id, _ => _.AnnouncementId, (_, __) => new { _, __ })
                   .Where(_ => _._.Id.Equals(announceId) && _.__.UserId == receiveId).ToList().Select(_ => new AnnouncementViewModel
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

    }
}
