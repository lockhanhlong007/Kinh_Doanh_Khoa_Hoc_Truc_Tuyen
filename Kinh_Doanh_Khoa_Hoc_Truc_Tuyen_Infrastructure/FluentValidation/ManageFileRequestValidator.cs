using System;
using System.Collections.Generic;
using System.Text;
using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class ManageFileRequestValidator : AbstractValidator<ManageFile>
    {
        public ManageFileRequestValidator()
        {
            RuleFor(x => x.FileName).NotEmpty().WithMessage("Yêu cầu nhập tên file");
        }
    }
}