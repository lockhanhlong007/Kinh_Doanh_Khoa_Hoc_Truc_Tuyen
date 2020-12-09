import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import { CategoriesComponent } from './categories/categories.component';
import { CommentsComponent } from './comments/comments.component';
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

@NgModule({
  declarations: [
    CategoriesComponent,
    CommentsComponent,
    CoursesComponent,
    FormatDataPipe,
    CategoriesDetailComponent,
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
    DropdownModule,
    ModalModule.forRoot()
  ],
  providers: [
    NotificationService,
    BsModalService,
    DatePipe
  ]
})
export class ProductsModule { }
