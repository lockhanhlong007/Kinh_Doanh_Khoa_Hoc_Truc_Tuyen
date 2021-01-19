using System;
using System.ComponentModel.DataAnnotations;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_WebPortal.Models
{
    public class ResetPasswordViewModel
    {
        [Required]
        public Guid UserId { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "Mật khẩu phải có ít nhất 6 ký từ và tối đa 100 ký tự", MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "Mật khẩu và xác nhận mật khẩu không chính xác")]
        public string ConfirmPassword { get; set; }

        public string Token { get; set; }
    }
}