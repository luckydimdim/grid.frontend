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

  @override
  ngAfterContentInit() {

    if (templates != null) {
      rowExpansionTemplate = templates.first.templateRef; // TODO: шаблонов м.б. несколько. first не подходит
    }
  }
}
