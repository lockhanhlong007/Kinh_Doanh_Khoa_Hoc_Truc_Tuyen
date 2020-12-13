using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class CourseViewModel
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string Image { get; set; }

        public string Content { get; set; }

        public long Price { get; set; }

        public DateTime CreationTime { get; set; }

        public DateTime? LastModificationTime { get; set; }

        public int Status { get; set; }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
    }
}
