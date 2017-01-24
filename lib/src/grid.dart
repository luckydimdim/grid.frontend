@JS()
library kendoGrid;

import 'package:js/js.dart';
import 'dart:html';
import 'dart:js';
import 'package:resources_loader/resources_loader.dart';



@anonymous
@JS()
class SearchOption {
  external String get type;
  external set type(String v);

  external String get field;
  external set field(String v);

  external String get caption;
  external set caption(String v);

  external factory SearchOption({String type, String field,String caption});
}


@anonymous
@JS()
class ShowOptions {
  external bool get header;
  external set header(bool v);

  external bool get toolbar;
  external set toolbar(bool v);

  external bool get footer;
  external set footer(bool v);

  external bool get lineNumbers;
  external set lineNumbers(bool v);

  external bool get selectColumn;
  external set selectColumn(bool v);

  external bool get expandColumn;
  external set expandColumn(bool v);

}

@anonymous
@JS()
class Column {
  external String get field;
  external set field(String v);

  external String get caption;
  external set caption(String v);

  external String get size;
  external set size(String v);

  external String get attr;
  external set attr(String v);

  external dynamic get render;
  external set render(dynamic v);

  external bool get sortable;
  external set sortable(String v);

  external bool get resizable;
  external set resizable(String v);

  external bool get frozen;
  external set frozen(String v);

  external factory Column({String field, String caption, String size, String attr, dynamic render, bool sortable, bool resizable, bool frozen });
}

@anonymous
@JS()
class SortOption {
  external String get field;
  external set field(String v);

  external String get direction;
  external set direction(String v);


  external factory SortOption({String field, String direction});
}

@anonymous
@JS()
class ColumnGroup {
  external String get caption;
  external set caption(String v);

  external int get span;
  external set span(int v);

  external bool get master;
  external set master(bool v);

  external factory ColumnGroup({String caption, int span, bool master});
}

@anonymous
@JS()
class GridOptions {

  external String get name;
  external set name(String v);

  external bool get multiSelect;
  external set multiSelect(bool v);

  external bool get fixedBody;
  external set fixedBody(bool v);

  external bool get multiSearch;
  external set multiSearch(bool v);

  external String get url;
  external set url(String v);

  external String get method;
  external set method(String v);

  external List<Column> get columns;
  external set columns(List<Column> v);

  external List<ColumnGroup> get columnGroups;
  external set columnGroups(List<ColumnGroup> v);

  external String get header;
  external set header(String v);

  external ShowOptions get show;
  external set show(ShowOptions v);

  external List<SearchOption> get searches;
  external set searches(List<SearchOption> v);

  external factory GridOptions({String name, List<Column> columns, String url, String method, String header,
  List<SearchOption> searches, bool multiSelect, bool fixedBody, List<ColumnGroup> columnGroups, bool multiSearch});
}

@JS()
class JQuery {
  external w2grid(GridOptions options);
  external w2destroy(String name);
}

@JS()
external JQuery $([String query]);

class Grid {
  ResourcesLoaderService _resourcesLoader;
  String _name;

  Grid(this._resourcesLoader, String query, GridOptions options) {
    _name = options.name;

    _resourcesLoader.loadStyle('packages/grid/src/', 'w2ui-1.5.rc1.min.css');

    _resourcesLoader.loadScript(
        'packages/grid/src/', 'w2ui-1.5.rc1.js', false,
        onData: (){
          $(query).w2grid(options);
        }

        );
  }

  Destroy(){
    $().w2destroy(_name);
  }
}
