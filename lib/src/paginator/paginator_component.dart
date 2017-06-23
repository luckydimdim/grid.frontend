import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';

import './paginator_state.dart';

@Component(selector: 'paginator', templateUrl: 'paginator_component.html')
class PaginatorComponent {
  final StreamController _onPageChange = new StreamController.broadcast();

  /**
   * Number of page links to display.
   */
  @Input()
  int pageLinkSize = 5;

  /**
   * Callback to invoke when page changes, the event object contains information about the new state
   */
  @Output()
  Stream get onPageChange => _onPageChange.stream;

  /**
   * Inline style of the component.
   */
  @Input()
  String style;

  /**
   * Style class of the component.
   */
  @Input()
  String styleClass;

  /**
   * Array of integer values to display inside rows per page dropdown.
   * [rowsPerPageOptions]="[10,20,30]"
   */
  @Input()
  List<int> rowsPerPageOptions;

  List<int> pageLinks;

  int _totalRecords = 0;

  int _first = 0;

  int _rows = 0;

  @Input()
  int get totalRecords => this._totalRecords;

  void set totalRecords(int val) {
    this._totalRecords = val;
    this.updatePageLinks();
  }

  @Input()
  int get first => this._first;

  void set first(int val) {
    this._first = val;
    this.updatePageLinks();
  }

  @Input()
  int get rows => this._rows;

  void set rows(int val) {
    this._rows = val;
    this.updatePageLinks();
  }

  bool isFirstPage() {
    return this.getPage() == 0;
  }

  bool isLastPage() {
    return this.getPage() == this.getPageCount() - 1;
  }

  int getPageCount() {
    return (this.totalRecords / this.rows).ceil() || 1;
  }

  List<int> calculatePageLinkBoundaries() {
    var numberOfPages = this.getPageCount();

    var visiblePages = min(this.pageLinkSize, numberOfPages);

    //calculate range, keep current in middle if necessary
    var start = max(0, (this.getPage() - ((visiblePages) / 2)).ceil),
        end = min(numberOfPages - 1, start + visiblePages - 1);

    //check when approaching to last page
    var delta = this.pageLinkSize - (end - start + 1);
    start = max(0, start - delta);

    return [start, end];
  }

  void updatePageLinks() {
    this.pageLinks = [];
    var boundaries = this.calculatePageLinkBoundaries();
    var start = boundaries[0];
    var end = boundaries[1];

    for (var i = start; i <= end; i++) {
      this.pageLinks.add(i + 1);
    }
  }

  void changePage(int p, Event event) {
    var pc = this.getPageCount();

    if (p >= 0 && p < pc) {
      this.first = this.rows * p;

      var state = new PaginatorState()
        ..page = p
        ..first = this.first
        ..rows = this.rows
        ..pageCount = pc;

      this.updatePageLinks();

      this._onPageChange.add(state);
    }

    if (event != null) {
      event.preventDefault();
    }
  }

  int getPage() {
    return (this.first / this.rows).floor();
  }

  void changePageToFirst(Event event) {
    this.changePage(0, event);
  }

  void changePageToPrev(Event event) {
    this.changePage(this.getPage() - 1, event);
  }

  void changePageToNext(Event event) {
    this.changePage(this.getPage() + 1, event);
  }

  void changePageToLast(Event event) {
    this.changePage(this.getPageCount() - 1, event);
  }

  void onRppChange(Event event) {
    this.rows = this.rowsPerPageOptions[event.target.selectedIndex];
    this.changePageToFirst(event);
  }
}
