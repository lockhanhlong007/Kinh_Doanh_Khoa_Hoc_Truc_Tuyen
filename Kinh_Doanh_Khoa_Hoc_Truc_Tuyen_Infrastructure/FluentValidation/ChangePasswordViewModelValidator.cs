using System;
using System.Collections.Generic;
using System.Text;
using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class ChangePasswordViewModelValidator : AbstractValidator<ChangePasswordViewModel>
    {
        public ChangePasswordViewModelValidator()
        {
            RuleFor(x => x.OldPassword).NotEmpty().WithMessage("Old Password is required");

            RuleFor(x => x.NewPassword).NotEmpty().WithMessage("New Password is required")
                .MinimumLength(6).WithMessage("New Password is at least 6 characters");

            RuleFor(x => x).Custom((request, context) =>
                {
                    if (request.NewPassword != request.ConfirmNewPassword)
                    {
                        context.AddFailure("Confirm password is not match");
                    }
                });

            RuleFor(x => x).Custom((request, context) =>
            {
                if (request.OldPassword == request.NewPassword)
                {
                    context.AddFailure("old password and new password must be different");
                }
            });
        }
    }
}
