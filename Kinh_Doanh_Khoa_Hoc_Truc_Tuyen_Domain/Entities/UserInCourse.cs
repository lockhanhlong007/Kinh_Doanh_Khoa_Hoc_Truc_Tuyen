using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities
{
    [Table("UserInCourses")]
    public class UserInCourse
    {
        public int CourseId { get; set; }

        public Guid UserId { get; set; }

        public Course Course { get; set; }

        public AppUser AppUser { get; set; }
    }
}