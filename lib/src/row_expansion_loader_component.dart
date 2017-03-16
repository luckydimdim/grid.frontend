import 'package:angular2/core.dart';

@Component(selector: '[row-expansion-loader]')
@View(template: '')
class RowExpansionLoader implements OnInit {

  @Input()
  TemplateRef template;

  @Input()
  dynamic rowData;

  ViewContainerRef _viewContainerRef;

  RowExpansionLoader(this._viewContainerRef);

  @override
  ngOnInit() {
    var viewRef = _viewContainerRef.createEmbeddedView(template);
    viewRef.setLocal('\$implicit', rowData );
  }

}