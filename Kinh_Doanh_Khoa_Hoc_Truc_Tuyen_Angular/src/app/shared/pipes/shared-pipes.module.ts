import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormatDataPipe } from './format-data.pipe';

@NgModule({
    imports: [CommonModule],
    declarations: [FormatDataPipe]
})
export class SharedPipesModule {}
