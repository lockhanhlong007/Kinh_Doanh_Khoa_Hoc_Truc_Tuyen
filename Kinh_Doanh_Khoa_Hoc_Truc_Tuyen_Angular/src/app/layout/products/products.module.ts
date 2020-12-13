import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { CategoriesComponent } from './categories/categories.component';
import { CoursesComponent } from './courses/courses.component';
import { ProductsRoutingModule } from './products-routing.module';
import { CategoriesDetailComponent } from './categories/categories-detail/categories-detail.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ModalModule, BsModalService } from 'ngx-bootstrap/modal';
import { BlockUIModule } from 'primeng/blockui';
import { ButtonModule } from 'primeng/button';
import { CalendarModule } from 'primeng/calendar';
import { CheckboxModule } from 'primeng/checkbox';
import { DropdownModule } from 'primeng/dropdown';
import { InputTextModule } from 'primeng/inputtext';
import { KeyFilterModule } from 'primeng/keyfilter';
import { MessageModule } from 'primeng/message';
import { MessagesModule } from 'primeng/messages';
import { PaginatorModule } from 'primeng/paginator';
import { PanelModule } from 'primeng/panel';
import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { TableModule } from 'primeng/table';
import { TreeTableModule } from 'primeng/treetable';
import { ValidationMessageModule } from '../../shared/modules/validation-message/validation-message.module';
import { FormatDataPipe } from '../../shared/pipes/format-data.pipe';
import { NotificationService } from '../../shared/services';
import { CoursesDetailComponent } from './courses/courses-detail/courses-detail.component';
import { LessonsComponent } from './courses/lessons/lessons.component';
import { LessonsDetailComponent } from './courses/lessons-detail/lessons-detail.component';
import { CommentsComponent } from './courses/comments/comments.component';
import { CommentsDetailComponent } from './courses/comments-detail/comments-detail.component';
import { PromotionsComponent } from './promotions/promotions.component';
import { PromotionsDetailComponent } from './promotions/promotions-detail/promotions-detail.component';
import { RadioButtonModule } from 'primeng/radiobutton';
import { CoursesInPromotionComponent } from './promotions/courses-in-promotion/courses-in-promotion.component';
import { ActiveCoursesComponent } from './courses/active-courses/active-courses.component';
import {EditorModule} from 'primeng/editor';
import {FileUploadModule} from 'primeng/fileupload';
import {InputTextareaModule} from 'primeng/inputtextarea';
import {InputNumberModule} from 'primeng/inputnumber';
import { ConvertPathPipe } from '../../shared/pipes/convert-path.pipe';
import { OrdersComponent } from './orders/orders.component';
import { OrdersDetailComponent } from './orders/orders-detail/orders-detail.component';
import { FormatStatusBasePipe } from '../../shared/pipes/format-status-base.pipe';
import { FormatStatusCoursesPipe } from '../../shared/pipes/format-status-courses.pipe';
@NgModule({
  declarations: [
    CategoriesComponent,
    CoursesComponent,
    FormatDataPipe,
    CategoriesDetailComponent,
    CoursesDetailComponent,
    LessonsComponent,
    LessonsDetailComponent,
    CommentsComponent,
    ConvertPathPipe,
    CommentsDetailComponent,
    PromotionsComponent,
    PromotionsDetailComponent,
    CoursesInPromotionComponent,
    ActiveCoursesComponent,
    OrdersComponent,
    FormatStatusCoursesPipe,
    FormatStatusBasePipe,
    OrdersDetailComponent,
    ],
  imports: [
    CommonModule,
    ProductsRoutingModule,
    PanelModule,
    ButtonModule,
    TableModule,
    PaginatorModule,
    BlockUIModule,
    InputTextModule,
    FileUploadModule,
    ProgressSpinnerModule,
    ValidationMessageModule,
    FormsModule,
    ReactiveFormsModule,
    KeyFilterModule,
    CalendarModule,
    CheckboxModule,
    MessageModule,
    MessagesModule,
    TreeTableModule,
    InputNumberModule,
    DropdownModule,
    InputTextareaModule,
    RadioButtonModule,
    EditorModule,
    ModalModule.forRoot()
  ],
  providers: [
    NotificationService,
    BsModalService,
    DatePipe
  ]
})
export class ProductsModule { }
