import 'package:angular2/core.dart';

@Directive(selector: '[grid-template]')
class GridTemplateDirective {
  TemplateRef templateRef;

  @Input()
  String type;

  @Input('grid-template')
  String templateType;

  GridTemplateDirective(this.templateRef);
}
