﻿using System;
using System.Collections.Generic;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems
{
    public class AnnouncementViewModel
    {
        public Guid Id { get; set; }

        public string Title { set; get; }

        public string Content { set; get; }

        public string Image { get; set; }

        public string EntityType { get; set; }

        public string EntityId { get; set; }

        public Guid UserId { set; get; }

        public DateTime CreationTime { get; set; }

        public DateTime? LastModificationTime { get; set; }

        public Status Status { set; get; }
    }
}