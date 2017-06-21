import 'package:angular2/core.dart';
import 'row_api.dart';

@Component(selector: 'row-expansion-loader', template: '')
class RowExpansionLoader implements OnInit, OnDestroy, OnChanges {
  @Input()
  TemplateRef template;

  @Input()
  dynamic rowData;

  @Input()
  bool creatingMode;

  @Output()
  final rowUpdated = new EventEmitter<dynamic>();

  ViewContainerRef _viewContainerRef;

  RowExpansionLoader(this._viewContainerRef);

  EmbeddedViewRef _viewRef;

  @override
  ngOnInit() {
    var rowApi = new RowApi();

    rowApi.update = (d) => updateRow(d);
    rowApi.creatingMode = creatingMode;

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

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (_viewRef != null) {
      _viewRef.setLocal('rowData', rowData);
    }
  }
}
