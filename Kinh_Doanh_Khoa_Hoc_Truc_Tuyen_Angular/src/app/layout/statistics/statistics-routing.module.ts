import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RevenueComponent } from './revenue/revenue.component';
import { NewUserComponent } from './new-user/new-user.component';


const routes: Routes = [
    {
        path: '',
        component: RevenueComponent
    },
    {
        path: 'revenue',
        component: RevenueComponent
    },
    {
        path: 'new-user',
        component: NewUserComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class StatisticsRoutingModule { }
