import { Component, OnDestroy, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { Subscription } from 'rxjs';
import { MessageConstants } from '../../../shared';
import { Pagination } from '../../../shared/models';
import { PromotionsService, NotificationService } from '../../../shared/services';
import { Promotions } from '../../../shared/models/promotions.model';
import { PromotionsDetailComponent } from './promotions-detail/promotions-detail.component';
import { CoursesInPromotionComponent } from './courses-in-promotion/courses-in-promotion.component';
import { environment } from '../../../../environments/environment';

@Component({
  selector: 'app-promotions',
  templateUrl: './promotions.component.html',
  styleUrls: ['./promotions.component.scss']
})
export class PromotionsComponent implements OnInit, OnDestroy {
  private subscription = new Subscription();
  public checkApprove = false;
  // Default
  public bsModalRef: BsModalRef;
  public blockedPanel = false;
  public blockedPanelCourses = false;
  /**
   * Paging
   */
  public pageIndex = 1;
  public pageSize = 5;
  public totalRecords: number;
  public keyword = '';
  public items: any[];
  public selectedItems = [];
  public showCourses = false;
  public courses: any[] = [];
  public selectedCourseItems = [];
  public backendApiUrl = environment.ApiUrl;
  public totalCoursesRecords: number;
  constructor(private promotionsService: PromotionsService,
    private notificationService: NotificationService,
    private modalService: BsModalService) { }

  ngOnInit(): void {
    this.loadData();
  }
  checkChanged(res) {
    return res.findIndex(x => x.status === 1);
  }
  loadData(selectedId = null) {
    this.blockedPanel = true;
    this.subscription.add(this.promotionsService.getAllPaging(this.keyword, this.pageIndex, this.pageSize)
      .subscribe((response: Pagination<Promotions>) => {
        this.processLoadData(selectedId, response);
      }, () => {
        setTimeout(() => { this.blockedPanel = false; }, 1000);
      }));
  }
  private processLoadData(selectedId = null, response: Pagination<Promotions>) {
    this.items = response.items;
    this.pageIndex = this.pageIndex;
    this.pageSize = this.pageSize;
    this.totalRecords = response.totalRecords;
    if (this.selectedItems.length === 0 && this.items.length > 0) {
      this.selectedItems.push(this.items[0]);
    }
    if (selectedId != null && this.items.length > 0) {
      this.selectedItems = this.items.filter(x => x.Id === selectedId);
    }
    setTimeout(() => { this.blockedPanel = false; }, 1000);
  }
  pageChanged(event: any): void {
    this.pageIndex = event.page + 1;
    this.pageSize = event.rows;
    this.loadData();
  }

  showHideCourseTable() {
    if (this.showCourses) {
      if (this.selectedItems.length === 1) {
        this.loadCourses();
      }
    }
  }
  loadCourses() {
    this.blockedPanelCourses = true;
    if (this.selectedItems != null && this.selectedItems.length > 0) {
      const promotionId = this.selectedItems[0].id;
      this.promotionsService.getPromotionCourses(promotionId).subscribe((response: any) => {
        this.courses = response;
        this.totalCoursesRecords = response.length;
        if (this.selectedCourseItems.length === 0 && this.courses.length > 0) {
          this.selectedCourseItems.push(this.courses[0]);
        }
        setTimeout(() => { this.blockedPanelCourses = false; }, 1000);
      }, () => {
        setTimeout(() => { this.blockedPanelCourses = false; }, 1000);
      });
    } else {
      this.selectedCourseItems = [];
      setTimeout(() => { this.blockedPanelCourses = false; }, 1000);
    }
  }
  onRowSelect() {
    this.selectedCourseItems = [];
    this.totalCoursesRecords = 0;
    this.courses = [];
    if (this.selectedItems.length === 1 && this.showCourses) {
      this.loadCourses();
    }
  }

  onRowUnselect() {
    this.selectedCourseItems = [];
    this.totalCoursesRecords = 0;
    this.courses = [];
    if (this.selectedItems.length === 1 && this.showCourses) {
      this.loadCourses();
    }
  }

  showAddModal() {
    this.bsModalRef = this.modalService.show(PromotionsDetailComponent, {
      class: 'modal-lg',
      backdrop: 'static'
    });
    this.bsModalRef.content.saved.subscribe(() => {
      this.bsModalRef.hide();
      this.loadData();
      this.selectedItems = [];
    });
  }
  showEditModal() {
  if (this.selectedItems.length === 0) {
    this.notificationService.showError(MessageConstants.Not_Choose_Any_Record);
    return;
  }
  const initialState = {
    entityId: this.selectedItems[0].id
  };
  this.bsModalRef = this.modalService.show(PromotionsDetailComponent,
    {
      initialState: initialState,
      class: 'modal-lg',
      backdrop: 'static'
    });
  this.bsModalRef.content.saved.subscribe((response) => {
    this.bsModalRef.hide();
    this.loadData(response.id);
  });

  }

  deleteItems() {
    const ids = [];
    this.selectedItems.map(data => {
      ids.push(data.id);
    });
    this.notificationService.showConfirmation(MessageConstants.Confirm_Delete,
      () => this.deleteItemsConfirm(ids));
  }
  deleteItemsConfirm(ids: any[]) {
    this.blockedPanel = true;
    this.subscription.add(this.promotionsService.delete(ids).subscribe(() => {
      this.notificationService.showSuccess(MessageConstants.Delete_Ok);
      this.loadData();
      this.selectedItems = [];
      setTimeout(() => { this.blockedPanel = false; }, 1000);
    }, error => {
      this.notificationService.showError(error);
      setTimeout(() => { this.blockedPanel = false; }, 1000);
    }));
  }
  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }

  addCoursesInPromotion() {
    if (this.selectedItems.length === 0) {
      this.notificationService.showError(MessageConstants.Not_Choose_Any_Record);
      return;
    }
    const existingCoursesId = [];
    this.courses.map(res => {
      existingCoursesId.push(res.id);
    });
    const initialState = {
      existingCourses: existingCoursesId,
      promotionId: this.selectedItems[0].id
    };
    this.bsModalRef = this.modalService.show(CoursesInPromotionComponent,
      {
        initialState: initialState,
        class: 'modal-lg',
        backdrop: 'static'
      });
    this.bsModalRef.content.chosenEvent.subscribe(() => {
      this.bsModalRef.hide();
      this.loadCourses();
      this.selectedCourseItems = [];
    });
  }

  removeCoursesInPromotion() {
    this.notificationService.showConfirmation(MessageConstants.Confirm_Delete,
      () => this.deleteCoursesInPromotionConfirm(this.selectedCourseItems));
  }

  deleteCoursesInPromotionConfirm(selectedCourses) {
    this.blockedPanelCourses = true;
    const Ids = [];
    selectedCourses.map(res => {
      Ids.push(res.id);
    });
    this.promotionsService.removePromotionInCourses(this.selectedItems[0].id, Ids).subscribe(() => {
      this.loadCourses();
      this.selectedCourseItems = [];
      this.notificationService.showSuccess(MessageConstants.Delete_Ok);
      setTimeout(() => { this.blockedPanelCourses = false; }, 1000);
    }, error => {
      this.notificationService.showError(error);
      setTimeout(() => { this.blockedPanelCourses = false; }, 1000);
    });
  }


}