import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor() {}
  
  n1: number;
  n2: number;
  solution: number;

  add() {
    this.solution = this.n1 + this.n2;
  }

  subtract(n1: number, n2: number) {
    this.solution = this.n1 - this.n2;
  }

  multiply(n1: number, n2: number) {
    this.solution = this.n1 * this.n2;
  }

  divide(n1: number, n2: number) {
    this.solution = this.n1 / this.n2;
  }

}
