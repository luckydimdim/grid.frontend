import 'package:angular2/core.dart';
import '../grid_template_directive.dart';
import '../column_body_template_loader_component.dart';

@Component(
    selector: 'grid-column',
    template: '',
    directives: const [ColumnBodyTemplateLoader])
class ColumnComponent implements AfterContentInit {
  /**
   * Header text of a column.
   */
  @Input()
  String header;

  /**
   * Property of a row data.
   */
  @Input()
  String field;

  /**
   * Property of a row data used for sorting, defaults to field.
   */
  @Input()
  String sortField;

  /**
   * Displays an icon to toggle row expansion.
   */
  @Input()
  bool expander = false;

  /**
   * Inline style of the column.
   */
  @Input()
  String style;

  /**
   * Style class of the column.
   */
  @Input()
  String styleClass;

  @Input()
  String width;

  /**
   * Defines if a column is sortable.
   */
  @Input()
  bool sortable = true;

  /**
   * Defines if a column can be filtered.
   */
  @Input()
  bool filter = false;

  /**
   * Defines filterMatchMode; "startsWith", "contains", "endsWidth", "equals", "notEquals" and "in".
   */
  @Input()
  String filterMatchMode;

  /**
   * Type of the filter input field.
   */
  @Input()
  String filterType;

  /**
   * Defines placeholder of the input fields.
   */
  @Input()
  String filterPlaceholder;

  @Input()
  int filterMaxlength;

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
