import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StatisticsRoutingModule } from './statistics-routing.module';
import { NewUserComponent } from './new-user/new-user.component';
import { RevenueComponent } from './revenue/revenue.component';



@NgModule({
  declarations: [NewUserComponent, RevenueComponent],
  imports: [
    CommonModule,
    StatisticsRoutingModule
  ]
})
export class StatisticsModule { }
