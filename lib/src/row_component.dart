import 'package:angular2/core.dart';
import 'grid_component.dart';
import 'column_body_template_loader_component.dart';

@Component(selector: 'tr[grid-row]', templateUrl: 'row_component.html', directives: const[ColumnBodyTemplateLoader])
class RowComponent implements OnInit {
  final GridComponent grid;

  @Input()
  dynamic data;

  RowComponent(@Inject(GridComponent) this.grid) {}

  @override
  ngOnInit() {}

  dynamic resolveFieldData(data, String field) {
    return data[field];
  }
}
