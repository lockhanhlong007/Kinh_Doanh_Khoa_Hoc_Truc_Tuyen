import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormatDataPipe } from './format-data.pipe';
import { ConvertPathPipe } from './convert-path.pipe';
import { FormatStatusCoursesPipe } from './format-status-courses.pipe';
import { FormatStatusBasePipe } from './format-status-base.pipe';

@NgModule({
    imports: [CommonModule],
    declarations: [FormatDataPipe, ConvertPathPipe, FormatStatusCoursesPipe, FormatStatusBasePipe]
})
export class SharedPipesModule {}
