using FluentValidation;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.ViewModels.Products;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Infrastructure.FluentValidation
{
    public class CourseViewModelRequestValidator : AbstractValidator<CourseCreateRequest>
    {
        public CourseViewModelRequestValidator()
        {
            RuleFor(x => x.Name).NotEmpty().WithMessage("Course Name is required");
            RuleFor(x => x.Content).NotEmpty().WithMessage("Course Content is required");
        }
    }
}
