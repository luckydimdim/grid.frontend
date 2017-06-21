import 'package:angular2/core.dart';
import 'grid_template_directive.dart';
import 'column_body_template_loader_component.dart';

@Component(
    selector: 'grid-column',
    template: '',
    directives: const [ColumnBodyTemplateLoader])
class ColumnComponent implements AfterContentInit {
  @Input()
  String header;

  @Input()
  String field;

  @Input()
  String sortField;

  @Input()
  bool expander = false;

  @Input()
  String style;

  @Input()
  String styleClass;

  @Input()
  String width;

  @Input()
  bool sortable = false;

  @ContentChildren(GridTemplateDirective)
  QueryList<GridTemplateDirective> templates;

  TemplateRef bodyTemplate;
  TemplateRef headerTemplate;

  @override
  ngAfterContentInit() {
    if (templates != null) {
      for (GridTemplateDirective template in templates) {
        if (template.templateType == 'body') {
          bodyTemplate = template.templateRef;
        } else if (template.templateType == 'header') {
          headerTemplate = template.templateRef;
        }
      }
    }
  }
}
