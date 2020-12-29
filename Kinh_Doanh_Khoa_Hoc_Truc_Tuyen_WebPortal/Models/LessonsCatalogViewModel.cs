﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class LessonsCatalogViewModel
    {
        public CourseViewModel CourseViewModel { get; set; }

        public LessonViewModel LessonViewModel { get; set; }

        public List<LessonViewModel> LessonViewModels { get; set; }

        public List<CommentViewModel> CommentViewModels { get; set; }
    }
}
