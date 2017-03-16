import 'package:angular2/core.dart';
import 'row_expansion_loader_component.dart';
import 'row_component.dart';
import 'column_component.dart';
import 'datasource.dart';

@Directive(selector: '[grid-template]')
class GridTemplateDirective {
  TemplateRef templateRef;

  @Input()
  String type;

  @Input('grid-template')
  String templateType;

  GridTemplateDirective(this.templateRef);

}

@Component(selector: 'call-off-order-details')
@View(template: 'CallOffOrderDetailsComponent!')
class CallOffOrderDetailsComponent implements AfterContentInit {
  String Diman;

  @override
  ngAfterContentInit() {
    print('CallOffOrderDetailsComponent: $Diman');
  }
}

@Component(selector: 'grid')
@View(templateUrl: 'grid_component.html',
    directives: const [RowComponent, ColumnComponent, RowExpansionLoader])
class GridComponent
    implements AfterContentInit {

  @ContentChildren(ColumnComponent)
  QueryList<ColumnComponent> columns;


  @ContentChildren(GridTemplateDirective)
  QueryList<GridTemplateDirective> templates;

  TemplateRef rowExpansionTemplate;

  @Input()
  GridDataSource dataSource;

  @override
  ngAfterContentInit() {
    if (columns != null) {
      print('GridComponent: columns count: ${columns.length}');
    }

    if (templates != null) {
      print('GridComponent: templates count: ${templates.length}');

      rowExpansionTemplate = templates.first.templateRef;
    }

  }
}