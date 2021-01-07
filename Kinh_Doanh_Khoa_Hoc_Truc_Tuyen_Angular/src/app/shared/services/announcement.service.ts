import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { UtilitiesService } from '.';
import { AnnouncementMarkReadRequest, Announcement, Pagination } from '../models';
import { BaseService } from './base.service';


@Injectable({
  providedIn: 'root'
})
export class AnnouncementService extends BaseService {
  private _sharedHeaders = new HttpHeaders();
  constructor(private http: HttpClient, private utilitiesService: UtilitiesService) {
    super();
    this._sharedHeaders = this._sharedHeaders.set('Content-Type', 'application/json');
  }

  updateMaskAsRead(entity: AnnouncementMarkReadRequest) {
    return this.http.put(`${environment.ApiUrl}/api/announcements/mark-read`, entity, {headers: this._sharedHeaders})
    .pipe(catchError(this.handleError));
  }

  getDetail(id, userId) {
    return this.http.get<Announcement>(`${environment.ApiUrl}/api/announcements/${id}?receiveId=${userId}&announceId=${id}`,
    {headers: this._sharedHeaders})
    .pipe(catchError(this.handleError));
  }

  getAllPaging(filter, userId, pageIndex, pageSize) {
    return this.http.get<Pagination<Announcement>>(`${environment.ApiUrl}/api/announcements/private-paging/filter?userId=${userId}&pageIndex=${pageIndex}&pageSize=${pageSize}&filter=${filter}`, {headers: this._sharedHeaders})
    .pipe(map((response: Pagination<Announcement>) => {
      return response;
    }), catchError(this.handleError));
  }
}
