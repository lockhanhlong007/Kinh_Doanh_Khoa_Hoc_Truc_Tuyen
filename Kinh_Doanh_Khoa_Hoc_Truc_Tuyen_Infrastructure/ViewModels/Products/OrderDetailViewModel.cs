using System;
using System.Collections.Generic;
using System.Text;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class OrderDetailViewModel
    {
        public int OrderId { set; get; }

        public Guid ActiveCourseId { set; get; }

        public decimal? Price { set; get; }

        public decimal? PromotionPrice { set; get; }

        public string CourseName { get; set; }
    }
}
