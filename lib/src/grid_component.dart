import 'dart:html';
import 'package:angular2/core.dart';
import 'column_header_template_loader_component.dart';
import 'row_expansion_loader_component.dart';
import 'column_body_template_loader_component.dart';
import 'row_component.dart';
import 'column_component.dart';
import 'datasource.dart';
import 'grid_template_directive.dart';
import 'enums.dart';

@Component(selector: 'grid', templateUrl: 'grid_component.html',
    directives: const [
      RowComponent,
      ColumnComponent,
      RowExpansionLoader,
      ColumnBodyTemplateLoader,
      GridTemplateDirective,
      ColumnHeaderTemplateLoader
    ])
class GridComponent
    implements AfterContentInit {

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
  bool expandableRows;

  @Input()
  SortMode sortMode;

  @Output()
  EventEmitter<dynamic> onRowClick = new EventEmitter<dynamic>();

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

  isRowExpanded(dynamic row) {
    return findExpandedRowIndex(row) != -1;
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
      onRowClick.emit(rowData);
    //}
  }

}
