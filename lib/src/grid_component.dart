import 'package:angular2/core.dart';
import 'row_expansion_loader_component.dart';
import 'row_component.dart';
import 'column_component.dart';
import 'datasource.dart';
import 'grid_template_directive.dart';

@Component(selector: 'grid')
@View(
    templateUrl: 'grid_component.html',
    directives: const [RowComponent, ColumnComponent, RowExpansionLoader])
class GridComponent implements AfterContentInit {
  @ContentChildren(ColumnComponent)
  QueryList<ColumnComponent> columns;

  @ContentChildren(GridTemplateDirective)
  QueryList<GridTemplateDirective> templates;

  TemplateRef rowExpansionTemplate;

  @Input()
  DataSource dataSource;

  @Input()
  List expandedRows;

  @Input()
  bool expandableRows;

  @override
  ngAfterContentInit() {

    if (templates != null) {
      rowExpansionTemplate = templates.first.templateRef; // TODO: шаблонов м.б. несколько. first не подходит
    }
  }

  toggleRow(dynamic row) {

    if(expandedRows == null) {
      expandedRows = new List();
    }

    int expandedRowIndex = findExpandedRowIndex(row);

    if(expandedRowIndex != -1) {
      expandedRows.remove(row);
      // развернуто
    }
    else {
      //свернуто
      expandedRows = new List();
      expandedRows.add(row);
    }
  }

  int findExpandedRowIndex(dynamic row) {
    int index = -1;

    if(expandedRows != null && expandedRows.length > 0) {
      for(int i = 0; i < expandedRows.length; i++) {
        if(expandedRows[i] == row) {
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

    if (this.columns == null)
      return new List<ColumnComponent>();

    return columns.toList();
  }

  void updateRow(e, i) {
    dataSource.data[i] = e;
  }
}
