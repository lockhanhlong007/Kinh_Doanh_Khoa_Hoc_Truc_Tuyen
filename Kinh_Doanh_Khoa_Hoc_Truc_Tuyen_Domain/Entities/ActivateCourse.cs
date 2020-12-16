using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Interfaces;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities
{
    [Table("ActivateCourses")]
    public class ActivateCourse : ISwitchable
    {
        public Guid Id { get; set; }

        public Guid UserId { get; set; }

        public int CourseId { get; set; }

        public bool Status { get; set; }

        public Course Course { get; set; }

        public AppUser AppUser { get; set; }

        public List<OrderDetail> OrderDetails { get; set; }
    }
}
