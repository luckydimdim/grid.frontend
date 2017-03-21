import 'package:angular2/core.dart';
import 'column_component.dart';

@Component(selector: 'column-body-template-loader')
@View(template: '')
class ColumnBodyTemplateLoader implements OnInit, OnDestroy {
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

}