import { Injectable } from '@angular/core';

import { HttpClient } from '@angular/common/http';
import { BaseService } from './base.service';

@Injectable({
  providedIn: 'root'
})
export class UtilitiesService extends BaseService {
  constructor(private http: HttpClient) {
    super();
  }
  UnflatteringForLeftMenu = (arr: any[]): any[] => {
    const map = {};
    const roots: any[] = [];
    for ( let i = 0; i < arr.length; i += 1) {
      const node = arr[i];
      node.children = [];
      map[node.id] = i; // use map to look-up the parents
      if (node.parentId !== null) {
        delete node['children'];
        arr[map[node.parentId]].children.push(node);
      } else {
        roots.push(node);
      }
    }
    return roots;
  }
  UnflatteringForTree = (arr: any[]): any[] => {
    const map = {};
    const roots: any[] = [];
    for (let i = 0; i < arr.length; i += 1) {
      const node = {
        data: {
          id: '',
          parentId: '',
          name: '',
          sortOrder: '',
          hasCreate: '',
          hasUpdate: '',
          hasDelete: '',
          hasView: '',
          hasExportExcel: '',
        },
        expanded: true,
        children: []
      };
      node.data = arr[i];
      map[node.data.id] = i; // Khoi Tao Map
      if (node.data.parentId !== null) {
        roots[map[node.data.parentId]].children.push(node);
      } else {
        roots.push(node);
      }
    }
    return roots;
  }
}
