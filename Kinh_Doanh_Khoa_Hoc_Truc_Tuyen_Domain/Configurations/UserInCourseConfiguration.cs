using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Configurations
{
    public class UserInCourseConfiguration : IEntityTypeConfiguration<UserInCourse>
    {
        public void Configure(EntityTypeBuilder<UserInCourse> builder)
        {
            builder.HasKey(x => new { x.CourseId, x.UserId });
            builder.HasOne(x => x.AppUser).WithMany(x => x.AppUserInCourses).HasForeignKey(x => x.UserId);
            builder.HasOne(x => x.Course).WithMany(x => x.AppUserInCourses).HasForeignKey(x => x.CourseId);
        }
    }
}