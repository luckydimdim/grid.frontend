import 'package:angular2/core.dart';
import 'grid_component.dart';

@Component(selector: '[grid-row]')
@View(templateUrl: 'row_component.html')
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
