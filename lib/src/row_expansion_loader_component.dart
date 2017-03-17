import 'package:angular2/core.dart';
import 'row_api.dart';

@Component(selector: '[row-expansion-loader]')
@View(template: '')
class RowExpansionLoader implements OnInit {
  @Input()
  TemplateRef template;

  @Input()
  dynamic rowData;

  @Output()
  final rowUpdated = new EventEmitter<dynamic>();

  ViewContainerRef _viewContainerRef;

  RowExpansionLoader(this._viewContainerRef);

  @override
  ngOnInit() {
    var rowApi = new RowApi();

    rowApi.update = (d) => updateRow(d);

    var viewRef = _viewContainerRef.createEmbeddedView(template);
    viewRef.setLocal('rowData', rowData);
    viewRef.setLocal('rowApi', rowApi);
  }

  void updateRow(dynamic rowData) {
    rowUpdated.emit(rowData);
  }
}
