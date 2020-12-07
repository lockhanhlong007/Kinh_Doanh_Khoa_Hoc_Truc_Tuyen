import { ClientRequest, User } from './../models';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from './../../../environments/environment';
import { BehaviorSubject, Observable } from 'rxjs';
import { BaseService } from './base.service';
import { catchError, map } from 'rxjs/operators';
import jwtDecode, { JwtPayload } from 'jwt-decode';
@Injectable({
  providedIn: 'root'
})
export class AuthService extends BaseService {
  private TokenKey = 'auth-token';
  private UserKey = 'auth-user';
  // // Observable navItem source
  // private _authNavStatusSource = new BehaviorSubject<boolean>(false);
  // // Observable navItem stream
  // authNavStatus$ = this._authNavStatusSource.asObservable();

  // private manager = new UserManager(getClientSettings());
  // private user: User | null;

  // constructor() {
  //   super();
  //   this.manager.getUser().then(u => {
  //     this.user = u;
  //     this._authNavStatusSource.next(this.isAuthenticated());
  //   });
  // }
  // login() {
  //   return this.manager.signinPopup;
  // }
  // async completeAuthentication() {
  //   this.user = await this.manager.signinRedirectCallback();
  //   this._authNavStatusSource.next(this.isAuthenticated());
  // }
  // isAuthenticated(): boolean {
  //   return this.user != null && !this.user.expired;
  // }
  // get authorizationHeaderValue(): string {
  //   if (this.user) {
  //     return `${this.user.token_type} ${this.user.access_token}`;
  //   }
  //   return null;
  // }
  // get name(): string {
  //   return this.user != null ? this.user.profile.name : '';
  // }
  // get profile(): Profile {
  //   return this.user != null ? this.user.profile : null;
  // }
  // async signout() {
  //   await this.manager.signoutRedirect();
  // }

  private _sharedHeaders = new HttpHeaders();
  constructor(private http: HttpClient) {
      super();
      this._sharedHeaders = this._sharedHeaders.set('Content-Type', 'application/json');
  }
  isAuthenticated(): boolean {
    return this.getDecodedAccessToken(this.getToken()) != null;
  }
  login(client: ClientRequest): Observable<any>  {
    return this.http.post(`${environment.ApiUrl}/api/TokenAuth/Authenticate`, JSON.stringify(client),
      { headers: this._sharedHeaders }).pipe(catchError(this.handleError));
  }
  signOut() {
    sessionStorage.clear();
  }
  saveToken(token: string) {
    sessionStorage.removeItem(this.TokenKey);
    sessionStorage.setItem(this.TokenKey, token);
  }
  getToken(): string {
    return sessionStorage.getItem(this.TokenKey);
  }
  getDecodedAccessToken(token: string): any {
    try {
        return jwtDecode(token);
    } catch (error) {
        return null;
    }
  }

  // saveUser(user) {
  //   window.sessionStorage.removeItem(this.UserKey);
  //   window.sessionStorage.setItem(this.UserKey, JSON.stringify(user));
  // }

  // getUser() {
  //   return JSON.parse(sessionStorage.getItem(this.UserKey));
  // }
}
