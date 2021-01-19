import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, catchError } from 'rxjs/operators';
import { environment } from '../../../environments/environment';
import { ManageFileCreateRequest, ManageFiles, Pagination } from '../models';
import { BaseService } from './base.service';

@Injectable({
  providedIn: 'root'
})
export class ManageFilesService extends BaseService  {
  private _sharedHeaders = new HttpHeaders();
  constructor(private http: HttpClient) {
    super();
    this._sharedHeaders = this._sharedHeaders.set('Content-Type', 'application/json');
  }

  postBackupFile(entity: ManageFileCreateRequest) {
    return this.http.post(`${environment.ApiUrl}/api/manageFiles/backup-file`, entity, { headers: this._sharedHeaders })
    .pipe(
        catchError(this.handleError)
    );
  }

  postRestoreFile(id: number) {
    return this.http.post(`${environment.ApiUrl}/api/manageFiles/restore-file-${id}`, { headers: this._sharedHeaders })
    .pipe(
        catchError(this.handleError)
    );
  }

  putBackupFile(id: number, entity: ManageFileCreateRequest) {
    return this.http.put(`${environment.ApiUrl}/api/manageFiles/backup-file-${id}`, entity, { headers: this._sharedHeaders })
    .pipe(
        catchError(this.handleError)
    );
  }
  getDetail(id) {
    return this.http.get<ManageFiles>(`${environment.ApiUrl}/api/manageFiles/backup-file-${id}`, { headers: this._sharedHeaders })
        .pipe(catchError(this.handleError));
  }

  getAllPaging(filter, pageIndex, pageSize) {
    return this.http.get<Pagination<ManageFiles>>(`${environment.ApiUrl}/api/manageFiles/backup-file/filter?pageIndex=${pageIndex}&pageSize=${pageSize}&filter=${filter}`, { headers: this._sharedHeaders })
        .pipe(map((response: Pagination<ManageFiles>) => {
            return response;
        }), catchError(this.handleError));
  }
}
