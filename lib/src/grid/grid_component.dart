import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:angular2/core.dart';
import '../column_header_template_loader_component.dart';
import '../row_expansion_loader_component.dart';
import '../column_body_template_loader_component.dart';
import '../row/row_component.dart';
import '../column/column_component.dart';
import '../datasource.dart';
import '../grid_template_directive.dart';
import '../enums.dart';
import '../column_headers/column_headers_component.dart';
import 'package:angular_utils/directives.dart';
import '../paginator/paginator_state.dart';
import '../paginator/paginator_component.dart';
import 'lazy_load_event.dart';
import 'filter_metadata.dart';
import 'page_changed_event.dart';
import 'filter_event.dart';
import 'sort_event.dart';

@Component(
    selector: 'grid',
    templateUrl: 'grid_component.html',
    directives: const [
      RowComponent,
      ColumnComponent,
      RowExpansionLoader,
      ColumnBodyTemplateLoader,
      GridTemplateDirective,
      ColumnHeaderTemplateLoader,
      CmLoadingSpinComponent,
      ColumnHeadersComponent,
      PaginatorComponent
    ])
class GridComponent implements AfterContentInit, OnInit {
  @ContentChildren(ColumnComponent)
  QueryList<ColumnComponent> columns;

  @ContentChildren(GridTemplateDirective)
  QueryList<GridTemplateDirective> templates;

  TemplateRef rowExpansionTemplate;

  /**
   * Filters
   * <field,FilterMetadata>
   */
  @Input()
  Map<String, FilterMetadata> filters = new Map<String, FilterMetadata>();

  /**
   * Array of integer values to display inside rows per page dropdown of paginator
   */
  @Input()
  List<int> rowsPerPageOptions;

  /**
   * Whether to show it even there is only one page.
   */
  @Input()
  bool alwaysShowPaginator = true;

  /**
   * Number of page links to display in paginator.
   */
  @Input()
  int pageLinks = 5;

  /**
   * When specified as true, enables the pagination.
   */
  @Input()
  bool paginator = false;

  /**
   * Number of total records, defaults to length of value when not defined.
   */
  @Input()
  int totalRecords;

  /**
   * Number of rows to display per page.
   */
  @Input()
  int rows = 10;

  /**
   * Style class of the table element.
   */
  @Input()
  String tableStyleClass;

  DataSource _dataSource;

  DataSource get dataSource => _dataSource;

  @Input()
  void set dataSource(DataSource val) {
    this._dataSource = val;
    handleDataChange();
  }

  /**
   * Collection of rows to display as expanded.
   */
  @Input()
  List expandedRows;

  /**
   *
   */
  @Input()
  List creatingModeRows;

  /**
   * Activates expandable rows feature when true.
   */
  @Input()
  bool expandableRows;

  /**
   * Defines whether sorting works on single column or on multiple columns.
   */
  @Input()
  SortMode sortMode = SortMode.single;

  /**
   * Order to sort the data by default.
   */
  @Input()
  int sortOrder = 1;

  /**
   * Name of the field to sort data by default.
   */
  @Input()
  String sortField;

  /**
   * Defines if data is loaded and interacted with in lazy manner.
   */
  @Input()
  bool lazy = false;

  @Input()
  int filterDelay = 300;

  @Output()
  Stream get onRowClick => _onRowClick.stream;
  final StreamController _onRowClick = new StreamController.broadcast();

  @Output()
  Stream get onLazyLoad => _onLazyLoad.stream;
  final StreamController _onLazyLoad = new StreamController.broadcast();

  @Output()
  Stream get onPage => _onPage.stream;
  final StreamController _onPage = new StreamController.broadcast();

  @Output()
  Stream get onSort => _onSort.stream;
  final StreamController _onSort = new StreamController.broadcast();

  @Output()
  Stream get onFilter => _onFilter.stream;
  final StreamController _onFilter = new StreamController.broadcast();

  ColumnComponent sortColumn;

  int _first = 0;

  int get first => this._first;

  Timer filterTimeout;

  @Input()
  void set first(int val) {
    var shouldPaginate = this._first != val;

    this._first = val;

    if (shouldPaginate) {
      this.paginate();
    }
  }

  final StreamController _firstChange = new StreamController.broadcast();

  @Output()
  Stream get firstChange => _firstChange.stream;

  List dataToRender;
  List filteredValue;

  void paginate() {
    if (this.lazy) {
      this._onLazyLoad.add(this.createLazyLoadMetadata());
    } else
      this.updateDataToRender(this.filteredValue ?? this.dataSource?.data);

    this._onPage.add(new PageChangedEvent()
      ..first = this.first
      ..rows = this.rows);
  }

  void onPageChange(PaginatorState event) {
    this._first = event.first;
    this._firstChange.add(this.first);
    this.rows = event.rows;
    this.paginate();
  }

  @override
  ngAfterContentInit() {
    if (templates != null) {
      for (GridTemplateDirective template in templates) {
        if (template.templateType == 'rowexpansion') {
          rowExpansionTemplate = template.templateRef;
        }
      }
    }
  }

  @override
  ngOnInit() {
    if (this.lazy) {
      this._onLazyLoad.add(this.createLazyLoadMetadata());
    }
  }

  void handleDataChange() {
    if (this.paginator) {
      this.updatePaginator();
    }

    if (!this.lazy) {
      /*TODO: if(this.hasFilter()) {
        this._filter();
      }*/

      if (this.sortField != null) {
        /*if(this.sortColumn == null && this.columns != null) {
          this.sortColumn = this.columns.firstWhere(col => col.field == this.sortField && col.sortable === 'custom');
        }*/

        if (this.sortMode == SortMode.single)
          this.sortSingle();
        else if (this.sortMode == SortMode.multiple) this.sortMultiple();
      }
    }

    this.updateDataToRender(this.filteredValue ?? this.dataSource?.data);
  }

  updatePaginator() {
    //total records
    this.totalRecords = this.lazy
        ? this.totalRecords
        : (this.dataSource.data != null ? this.dataSource.data.length : 0);

    //first
    if (this.totalRecords != 0 && this.first >= this.totalRecords) {
      var numberOfPages = (this.totalRecords / this.rows).ceil();
      this._first = max((numberOfPages - 1) * this.rows, 0);
    }
  }

  updateDataToRender(List ds) {
    if (this.paginator && ds != null) {
      this.dataToRender = [];
      int startIndex = this.lazy ? 0 : this.first;
      int endIndex = startIndex + this.rows;

      for (int i = startIndex; i < endIndex; i++) {
        if (i >= ds.length) {
          break;
        }

        this.dataToRender.add(ds[i]);
      }
    } else {
      this.dataToRender = ds;
    }
  }

  toggleRow(dynamic row) {
    if (expandedRows == null) {
      expandedRows = new List();
    }

    var key = _getKey(row);

    int expandedRowIndex = findExpandedRowIndex(row);

    if (expandedRowIndex != -1) {
      expandedRows.remove(key);
    } else {
      expandedRows = new List();
      expandedRows.add(key);
    }
  }

  toggleCreatingMode(dynamic row) {
    if (creatingModeRows == null) {
      creatingModeRows = new List();
    }

    var key = _getKey(row);

    int creatingModeRowIndex = findCreatingModeRowIndex(row);

    if (creatingModeRowIndex != -1) {
      creatingModeRows.remove(key);
    } else {
      creatingModeRows = new List();
      creatingModeRows.add(key);
    }
  }

  dynamic _getKey(dynamic row) {
    var key = row;

    if (dataSource.primaryField != null) {
      key = row[dataSource.primaryField];
    }

    return key;
  }

  int findExpandedRowIndex(dynamic row) {
    int index = -1;

    var key = _getKey(row);

    if (expandedRows != null && expandedRows.length > 0) {
      for (int i = 0; i < expandedRows.length; i++) {
        if (expandedRows[i] == key) {
          index = i;
          break;
        }
      }
    }

    return index;
  }

  int findCreatingModeRowIndex(dynamic row) {
    int index = -1;

    var key = _getKey(row);

    if (creatingModeRows != null && creatingModeRows.length > 0) {
      for (int i = 0; i < creatingModeRows.length; i++) {
        if (creatingModeRows[i] == key) {
          index = i;
          break;
        }
      }
    }

    return index;
  }

  isRowExpanded(dynamic row) {
    return findExpandedRowIndex(row) != -1;
  }

  isRowInCreatingMode(dynamic row) {
    return findCreatingModeRowIndex(row) != -1;
  }

  List<ColumnComponent> visibleColumns() {
    if (this.columns == null) return new List<ColumnComponent>();

    return columns.toList();
  }

  void updateRow(e, i) {
    dataSource.data[i] = e;
  }

  trackByFn(index, item) {
    return _getKey(item);
  }

  void handleRowClick(MouseEvent event, dynamic rowData) {
    //String targetName = event.target.toString().toUpperCase();

    //if (targetName == 'TD' || targetName == 'SPAN') {
    // Событие не кидаем если, например, кликнули по кнопке в строке
    _onRowClick.add(rowData);
    //}
  }

  void sort(Event event, ColumnComponent column) {
    if (!column.sortable) return;

    String columnSortField = column.sortField ?? column.field;

    // если поле поменялось, то сбрасываем сортировка на умолчание. Иначе, меняем направление
    this.sortOrder =
        (this.sortField == columnSortField) ? this.sortOrder * -1 : 1;

    this.sortField = columnSortField;

    this.sortColumn = column;

    if (this.lazy) {
      this._first = 0;
      this._onLazyLoad.add(this.createLazyLoadMetadata());
    } else {
      if (this.sortMode == SortMode.multiple)
        this.sortMultiple();
      else
        this.sortSingle();
    }

    this._onSort.add(new SortEvent()
      ..field = this.sortField
      ..order = this.sortOrder);

    this.updateDataToRender(this.filteredValue ?? this.dataSource?.data);
  }

  bool isSorted(ColumnComponent column) {
    if (!column.sortable) {
      return false;
    }

    String columnSortField = column.sortField ?? column.field;

    if (this.sortMode == SortMode.single) {
      return (this.sortField != null && columnSortField == this.sortField);
    } else {
      throw new Exception('not implemented');
    }
  }

  int getSortOrder(ColumnComponent column) {
    int order = 0;

    String columnSortField = column.sortField ?? column.field;

    if (this.sortMode == SortMode.single) {
      if (this.sortField != null && columnSortField == this.sortField) {
        order = this.sortOrder;
      }
    } else {
      throw new Exception('not implemented');
    }

    return order;
  }

  void sortMultiple() {
    throw new Exception('not implemented');
  }

  dynamic resolveFieldData(dynamic data, String field) {
    if (data == null || field == null) return null;

    return data[field];
  }

  void sortSingle() {
    if (dataSource.data == null) return;

    dataSource.data.sort((data1, data2) {
      var value1 = this.resolveFieldData(data1, this.sortField);
      var value2 = this.resolveFieldData(data2, this.sortField);

      int result = 0;

      if (value1 == null && value2 != null)
        result = -1;
      else if (value1 != null && value2 == null)
        result = 1;
      else if (value1 == null && value2 == null)
        result = 0;
      else if (value1 is String && value2 is String) {
        result = (value1 as String).compareTo(value2);
      } else if (value1 is DateTime && value2 is DateTime) {
        result = (value1 as DateTime).compareTo(value2);
      } else {
        result = (value1 < value2) ? -1 : (value1 > value2) ? 1 : 0;
      }

      return (this.sortOrder * result);
    });

    this.first = 0;
  }

  LazyLoadEvent createLazyLoadMetadata() {
    var result = new LazyLoadEvent()
      ..first = this.first
      ..rows = this.rows
      ..sortOrder = this.sortOrder
      ..filters = this.filters
      ..sortField = this.sortField;

    return result;
  }

  void onFilterInputClick(Event event) {
    event.stopPropagation();
  }

  void onFilterKeyup(dynamic value, String field, String matchMode) {
    if (this.filterTimeout != null) {
      this.filterTimeout.cancel();
    }

    this.filterTimeout =
        new Timer(new Duration(milliseconds: this.filterDelay), () {
      this.filter(value, field, matchMode);
      this.filterTimeout.cancel();
      this.filterTimeout = null;
    });
  }

  void filter(dynamic value, String field, String matchMode) {
    if (!this.isFilterBlank(value))
      this.filters[field] = new FilterMetadata(value, matchMode);
    else if (this.filters[field] != null) // empty
      this.filters.remove(field);

    this._filter();
  }

  bool isFilterBlank(dynamic filter) {
    if (filter != null) {
      if ((filter is String && filter.trim().length == 0) ||
          (filter is List && filter.length == 0))
        return true;
      else
        return false;
    }
    return true;
  }

  dynamic filterConstraints(String filterMatchMode) {
    var startsWith = (dynamic value, dynamic filter) {
      if (filter == null || filter.trim() == '') return true;

      if (value == null) {
        return false;
      }

      var filterValue = filter.toLowerCase();

      return value.toString().toLowerCase().startsWith(filterValue);
    };

    var contains = (dynamic value, dynamic filter) {
      if (filter == null ||
          (filter is String && (filter as String).trim() == '')) {
        return true;
      }

      if (value == null) {
        return false;
      }

      return value.toString().toLowerCase().indexOf(filter.toLowerCase()) != -1;
    };

    var endsWith = (dynamic value, dynamic filter) {
      if (filter == null || filter.trim() == '') {
        return true;
      }

      if (value == null) {
        return false;
      }

      var filterValue = filter.toString().toLowerCase();
      return value.toString().toLowerCase().indexOf(
              filterValue, value.toString().length - filterValue.length) !=
          -1;
    };

    var equals = (dynamic value, dynamic filter) {
      if (filter == null || (filter is String && filter.trim() == '')) {
        return true;
      }

      if (value == null) {
        return false;
      }

      return value.toString().toLowerCase() == filter.toString().toLowerCase();
    };

    var notEquals = (dynamic value, dynamic filter) {
      return value != filter;
    };

    var _in = (dynamic value, dynamic filter) {
      if (filter == null || filter.length == 0) {
        return true;
      }

      if (value == null) {
        return false;
      }

      for (int i = 0; i < filter.length; i++) {
        if (filter[i] == value) return true;
      }

      return false;
    };

    var _default = (dynamic value, dynamic filter) {
      return false;
    };

    switch (filterMatchMode.toLowerCase()) {
      case 'startswith':
        return startsWith;
      case 'contains':
        return contains;
      case 'endswith':
        return endsWith;
      case 'equals':
        return equals;
      case 'notequals':
        return notEquals;
      case 'in':
        return _in;
      default:
        return _default;
    }
  }

  void _filter() {
    this._first = 0;

    if (this.lazy) {
      this._onLazyLoad.add(this.createLazyLoadMetadata());
    } else {
      this.filteredValue = [];

      for (int i = 0; i < this.dataSource.data.length; i++) {
        bool localMatch = true;

        for (int j = 0; j < this.columns.length; j++) {
          ColumnComponent col = this.columns.elementAt(j);
          FilterMetadata filterMeta = this.filters[col.field];

          //local
          if (filterMeta != null) {
            dynamic filterValue = filterMeta.value;
            String filterField = col.field;
            String filterMatchMode = filterMeta.matchMode ?? 'contains';

            dynamic dataFieldValue =
                this.resolveFieldData(this.dataSource.data[i], filterField);

            var filterConstraint = this.filterConstraints(filterMatchMode);

            if (!filterConstraint(dataFieldValue, filterValue)) {
              localMatch = false;
            }

            if (!localMatch) {
              break;
            }
          }
        }

        bool matches = localMatch;

        if (matches) {
          this.filteredValue.add(this.dataSource.data[i]);
        }
      }

      if (this.filteredValue.length == this.dataSource.data.length) {
        this.filteredValue = null;
      }

      if (this.paginator) {
        this.totalRecords = this.filteredValue != null
            ? this.filteredValue.length
            : this.dataSource.data != null ? this.dataSource.data.length : 0;
      }

      this.updateDataToRender(this.filteredValue ?? this.dataSource.data);
    }

    this._onFilter.add(new FilterEvent()
      ..filters = this.filters
      ..filteredValue = this.filteredValue ?? this.dataSource.data);
  }
}
