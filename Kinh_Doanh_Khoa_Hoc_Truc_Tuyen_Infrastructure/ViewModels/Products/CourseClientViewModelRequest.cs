using System;
using System.Collections.Generic;
using System.Text;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products
{
    public class CourseClientViewModelRequest
    {
        public int? CategoryId { get; set; }
        public int PageIndex { get; set; }

        public int PageSize { get; set; }

        public long? PriceMin { get; set; }

        public long? PriceMax { get; set; }

        public string SortBy { get; set; }

        public string Filter { get; set; }
    }
}
