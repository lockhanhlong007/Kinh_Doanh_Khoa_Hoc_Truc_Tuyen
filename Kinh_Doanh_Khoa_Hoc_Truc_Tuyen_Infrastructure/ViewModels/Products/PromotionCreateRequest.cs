using System;
using System.Collections.Generic;
using System.Text;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class PromotionCreateRequest
    {
        public DateTime FromDate { set; get; }

        public DateTime ToDate { set; get; }

        public bool ApplyForAll { set; get; }

        public int? DiscountPercent { set; get; }

        public decimal? DiscountAmount { set; get; }

        public Status Status { set; get; }

        public string Name { set; get; }
    }
}
