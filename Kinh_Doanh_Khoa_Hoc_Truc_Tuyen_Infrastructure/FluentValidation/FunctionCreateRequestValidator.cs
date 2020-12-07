using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Systems;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class FunctionCreateRequestValidator : AbstractValidator<FunctionCreateRequest>
    {
        public FunctionCreateRequestValidator()
        {
            RuleFor(x => x.Id).NotEmpty().WithMessage("Id value is required").MaximumLength(50)
                .WithMessage("Function Id cannot over limit 50 characters");
            RuleFor(x => x.Name).NotEmpty().WithMessage("Name value is required").MaximumLength(200)
                .WithMessage("Url cannot over limit 200 characters");
            RuleFor(x => x.Url).NotEmpty().WithMessage("Url value is required").MaximumLength(200)
                .WithMessage("Url cannot over limit 200 characters");
        }
    }
}
