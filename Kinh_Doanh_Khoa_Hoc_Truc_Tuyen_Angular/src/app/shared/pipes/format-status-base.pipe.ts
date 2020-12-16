import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'formatStatusBase'
})
export class FormatStatusBasePipe implements PipeTransform {

  transform(value: any): any {
    if (value === true) {
      return 'Duyệt';
    } else {
      return 'Chưa Duyệt';
    }
  }

}
