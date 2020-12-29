using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class CourseDetailClientViewModel
    {
        public CourseViewModel CourseViewModel { get; set; }

        public UserViewModel UserViewModel { get; set; }

        public List<LessonViewModel> LessonViewModels { get; set; }

        public List<CommentViewModel> CommentViewModels { get; set; }

        public List<CourseViewModel> RelatedCourses { get; set; }
    }
}
