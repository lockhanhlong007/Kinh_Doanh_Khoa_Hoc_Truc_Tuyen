import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CategoriesComponent } from './categories/categories.component';
import { CommentsComponent } from './comments/comments.component';
import { CoursesComponent } from './courses/courses.component';
import { ProductsRoutingModule } from './products-routing.module';



@NgModule({
  declarations: [CategoriesComponent, CommentsComponent, CoursesComponent],
  imports: [
    CommonModule,
    ProductsRoutingModule
  ]
})
export class ProductsModule { }
