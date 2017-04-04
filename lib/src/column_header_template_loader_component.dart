import 'package:angular2/core.dart';
import 'column_component.dart';

@Component(selector: 'column-header-template-loader')
@View(template: '')
class ColumnHeaderTemplateLoader implements OnInit, OnDestroy {
  @Input()
  ColumnComponent column;

  ViewContainerRef _viewContainerRef;

  ColumnHeaderTemplateLoader(this._viewContainerRef);

  EmbeddedViewRef _viewRef;

  @override
  ngOnInit() {
    _viewRef = _viewContainerRef.createEmbeddedView(column.headerTemplate);
    _viewRef.setLocal('column', column);
  }

  @override
  ngOnDestroy() {
    if (_viewRef != null) {
      _viewRef.destroy();
    }
  }

}