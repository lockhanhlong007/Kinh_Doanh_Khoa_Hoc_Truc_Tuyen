﻿using System;
using System.Collections.Generic;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Microsoft.AspNetCore.Http;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class LessonCreateRequest
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public IFormFile VideoPath { get; set; }

        public IFormFile Attachment { get; set; }

        public int SortOrder { get; set; }

        public Status Status { get; set; }

        public int CourseId { get; set; }
    }
}