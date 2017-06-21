import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import '../column_header_template_loader_component.dart';
import '../row_expansion_loader_component.dart';
import '../column_body_template_loader_component.dart';
import '../row/row_component.dart';
import '../column_component.dart';
import '../datasource.dart';
import '../grid_template_directive.dart';
import '../enums.dart';
import '../column_headers/column_headers_component.dart';
import 'package:angular_utils/directives.dart';

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
      ColumnHeadersComponent
    ])
class GridComponent implements AfterContentInit {
  @ContentChildren(ColumnComponent)
  QueryList<ColumnComponent> columns;

  @ContentChildren(GridTemplateDirective)
  QueryList<GridTemplateDirective> templates;

  TemplateRef rowExpansionTemplate;

  @Input()
  String tableStyleClass;

  @Input()
  DataSource dataSource;

  @Input()
  List expandedRows;

  @Input()
  List creatingModeRows;

  @Input()
  bool expandableRows;

  @Input()
  SortMode sortMode = SortMode.single;

  @Input()
  int sortOrder = 1;

  @Input()
  String sortField;

  @Input()
  bool lazy = false;

  @Input()
  int first = 0;

  @Output()
  Stream get onRowClick => _onRowClick.stream;

  final StreamController _onRowClick = new StreamController.broadcast();

  ColumnComponent sortColumn;

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
    print('sort! $event ${column.field}');

    if (!column.sortable) return;

    String columnSortField = column.sortField ?? column.field;

    // если поле поменялось, то сбрасываем сортировка на умолчание. Иначе, меняем направление
    this.sortOrder =
        (this.sortField == columnSortField) ? this.sortOrder * -1 : 1;

    this.sortField = columnSortField;

    this.sortColumn = column;

    if (this.lazy) {
      throw new Exception(
          'not implemented'); // TODO: this.onLazyLoad.emit(this.createLazyLoadMetadata());
    } else {
      if (this.sortMode == SortMode.multiple)
        this.sortMultiple();
      else
        this.sortSingle();
    }

    //TODO:
    /*this.onSort.emit({
      field: this.sortField,
      order: this.sortOrder,
      multisortmeta: this.multiSortMeta
    });*/
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
      } else {
        result = (value1 < value2) ? -1 : (value1 > value2) ? 1 : 0;
      }

      return (this.sortOrder * result);
    });

    this.first = 0;
  }
}
