import 'package:angular2/core.dart';

@Component(selector: 'grid-column')
@View(template: '')
class ColumnComponent {
  @Input()
  String header;

  @Input()
  String field;
}
