﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Services;
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
        public readonly IStorageService _storageService;

        public AnnouncementsController(EKhoaHocDbContext khoaHocDbContext, ILogger<CategoriesController> logger, IStorageService storageService)
        {
            _khoaHocDbContext = khoaHocDbContext;
            _logger = logger ?? throw new ArgumentException(nameof(logger));
            _storageService = storageService;
        }

        [HttpGet("private-paging/filter")]
        public Pagination<AnnouncementViewModel> GetAllUnReadPaging(string filter, string userId, int pageIndex, int pageSize)
        {
            IQueryable<Announcement> query;
            if (filter.Equals("true"))
            {
                query = from x in _khoaHocDbContext.Announcements.AsNoTracking()
                        join y in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
                            on x.Id equals y.AnnouncementId
                            into xy
                        from announceUser in xy.DefaultIfEmpty()
                        where x.Status == 1 && announceUser.UserId == Guid.Parse(userId)
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
                        where announceUser.HasRead == false && x.Status == 1 && announceUser.UserId == Guid.Parse(userId)
                        orderby !announceUser.HasRead descending, x.CreationTime descending
                        select x;
            }
            var lstAnnounce = new List<AnnouncementViewModel>();
            var items = query.Skip(pageSize * (pageIndex - 1)).Take(pageSize);
            foreach (var announcement in items.ToList())
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
                announceViewModel.Image = _storageService.GetFileUrl(announcement.Image);
                announceViewModel.Id = announcement.Id;
                var announceUser = _khoaHocDbContext.AnnouncementUsers
                    .FirstOrDefault(x => x.AnnouncementId == announcement.Id);
                if (announceUser != null)
                {
                    announceViewModel.TmpHasRead = announceUser.HasRead;
                }
                else
                {
                    announceViewModel.TmpHasRead = true;
                }
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
        public List<AnnouncementViewModel> GetAllUnRead(string userId) =>
            (from _ in _khoaHocDbContext.Announcements.AsNoTracking()
             join __ in _khoaHocDbContext.AnnouncementUsers.AsNoTracking()
           on _.Id equals __.AnnouncementId
              into ___
             from ____ in ___.DefaultIfEmpty()
             where ____.HasRead == false && ____.UserId == Guid.Parse(userId) && _.EntityType.Equals("private")
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
                 Image = _storageService.GetFileUrl(_._.Image),
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
                Image = _storageService.GetFileUrl(_.Image),
                EntityId = _.EntityId,
                EntityType = _.EntityType,
            }).ToList();

        [HttpPost("mark-read")]
        public async Task<bool> MarkAsRead(AnnouncementMarkReadRequest request)
        {
            var result = false;
            var announce = await _khoaHocDbContext.AnnouncementUsers.AsNoTracking().FirstOrDefaultAsync(_ => _.AnnouncementId == Guid.Parse(request.AnnounceId) && _.UserId == Guid.Parse(request.UserId));
            if (announce != null)
            {
                if (announce.HasRead == false)
                {
                    announce.HasRead = true;
                    _khoaHocDbContext.AnnouncementUsers.Update(announce);
                    await _khoaHocDbContext.SaveChangesAsync();
                    result = true;
                }
            }
            
            return result;
        }

        [HttpGet("{announceId}")]
        public AnnouncementViewModel GetDetailAnnouncement(string announceId, string receiveId) => _khoaHocDbContext.Announcements.AsNoTracking()
                   .Join(_khoaHocDbContext.AnnouncementUsers.AsNoTracking(), _ => _.Id, _ => _.AnnouncementId, (_, __) => new { _, __ })
                   .Where(_ => _._.Id.Equals(Guid.Parse(announceId)) && _.__.UserId == Guid.Parse(receiveId)).ToList().Select(_ => new AnnouncementViewModel
                   {
                       Id = _._.Id,
                       Title = _._.Title,
                       Content = _._.Content,
                       Image = _storageService.GetFileUrl(_._.Image),
                       UserId = _._.UserId,
                       CreationTime = _._.CreationTime,
                       LastModificationTime = _._.LastModificationTime,
                       Status = _._.Status,
                       EntityType = _._.EntityType,
                       EntityId = _._.EntityId
                   }).FirstOrDefault();

    }
}
