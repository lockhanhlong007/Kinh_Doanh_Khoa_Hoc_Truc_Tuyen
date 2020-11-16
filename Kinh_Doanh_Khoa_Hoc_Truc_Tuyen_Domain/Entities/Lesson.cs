﻿using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Enums;
using Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Interfaces;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Domain.Entities
{
    [Table("Lessons")]
    public class Lesson : ISwitchable, ISortable
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string VideoPath { get; set; }

        public string Attachment { get; set; }

        public int SortOrder { get; set; }

        public Status Status { get; set; }

        public int CourseId { get; set; }

        public Course Course { get; set; }
    }
}