import 'package:angular2/core.dart';
import '../grid/grid_component.dart';
import '../column_header_template_loader_component.dart';
import '../column/column_component.dart';

@Component(
    selector: 'tr[column-headers]',
    templateUrl: 'column_headers_component.html',
    styleUrls: const ['column_headers_component.css'],
    directives: const [ColumnHeaderTemplateLoader])
class ColumnHeadersComponent {
  final GridComponent grid;

  @Input('column-headers')
  List<ColumnComponent> columns;

  ColumnHeadersComponent(@Inject(GridComponent) this.grid);

  Map<String, bool> getColumnClasses(ColumnComponent column) {
    var result = <String, bool>{};

    if (column.sortable) result['ui-sortable-column'] = true;

    return result;
  }
}
