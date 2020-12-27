using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class ActiveCourseViewModel
    {
        [Required(ErrorMessage = "Yêu Cầu Nhập Mã Kích Hoạt", AllowEmptyStrings = false)]
        public string Code { get; set; }
        public string NameDash { get; set; }
    }
}
