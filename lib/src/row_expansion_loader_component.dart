import 'package:angular2/core.dart';
import 'row_api.dart';

@Component(selector: 'row-expansion-loader')
@View(template: '')
class RowExpansionLoader implements OnInit, OnDestroy {
  @Input()
  TemplateRef template;

  @Input()
  dynamic rowData;

  @Output()
  final rowUpdated = new EventEmitter<dynamic>();

  ViewContainerRef _viewContainerRef;

  RowExpansionLoader(this._viewContainerRef);

  EmbeddedViewRef _viewRef;

  @override
  ngOnInit() {
    var rowApi = new RowApi();

    rowApi.update = (d) => updateRow(d);

    _viewRef = _viewContainerRef.createEmbeddedView(template);
    _viewRef.setLocal('rowData', rowData);
    _viewRef.setLocal('rowApi', rowApi);
  }

  @override
  ngOnDestroy() {
    if (_viewRef != null) {
      _viewRef.destroy();
    }

  }

  void updateRow(dynamic rowData) {
    rowUpdated.emit(rowData);
  }
}
