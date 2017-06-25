import 'package:angular2/core.dart';
import 'column/column_component.dart';

@Component(selector: 'column-body-template-loader', template: '')
class ColumnBodyTemplateLoader implements OnInit, OnDestroy, OnChanges {
  @Input()
  ColumnComponent column;

  @Input()
  dynamic rowData;

  ViewContainerRef _viewContainerRef;

  ColumnBodyTemplateLoader(this._viewContainerRef);

  EmbeddedViewRef _viewRef;

  @override
  ngOnInit() {
    _viewRef = _viewContainerRef.createEmbeddedView(column.bodyTemplate);
    _viewRef.setLocal('rowData', rowData);
    _viewRef.setLocal('column', column);
  }

  @override
  ngOnDestroy() {
    if (_viewRef != null) {
      _viewRef.destroy();
    }
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (_viewRef != null) {
      _viewRef.setLocal('rowData', rowData);
      _viewRef.setLocal('column', column);
    }
  }
}
