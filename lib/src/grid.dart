@JS()
library kendoGrid;

import 'package:js/js.dart';
import 'dart:html';
import 'package:resources_loader/resources_loader.dart';

@anonymous
@JS()
class GridColumn {
  external String get field;
  external set field(String v);

  external String get title;
  external set title(String v);

  external int get width;
  external set width(int v);

  external bool get filterable;
  external set filterable(bool v);

  external bool get lockable;
  external set lockable(bool v);

  external bool get sortable;
  external set sortable(bool v);

  external String get format;
  external set format(String v);

  external factory GridColumn(
      {String field,
      String title,
      int width,
      bool filterable,
      bool lockable,
      bool sortable,
      String format});
}

@anonymous
@JS()
class GridOptions {
  external List<GridColumn> get columns;
  external set columns(List<GridColumn> v);

  external bool get sortable;
  external set sortable(bool v);

  external bool get filterable;
  external set filterable(bool v);

  external int get height;
  external set height(int v);

  external DataSource get dataSource;
  external set dataSource(DataSource v);

  external factory GridOptions(
      {List<GridColumn> columns,
      bool sortable,
      bool filterable,
      int height,
      DataSource dataSource});
}

@anonymous
@JS()
class DataSourceTransportRead {
  external String get url;
  external set url(String v);

  external String get type;
  external set type(String v);

  external String get dataType;
  external set dataType(String v);

  external factory DataSourceTransportRead(
      {String url, String type, String dataType});
}

@anonymous
@JS()
class DataSourceTransport {
  external DataSourceTransportRead get read;
  external set read(DataSourceTransportRead v);

  external factory DataSourceTransport({DataSourceTransportRead read});
}

@anonymous
@JS()
class DataSourceSchemaModelField {
  external String get field;
  external set field(String v);

  external String get type;
  external set type(String v);

  external factory DataSourceSchemaModelField({String field, String type});
}

@anonymous
@JS()
class DataSourceSchemaModelWithFieldsArray {
  external List<DataSourceSchemaModelField> get fields;
  external set fields(List<DataSourceSchemaModelField> v);

  external factory DataSourceSchemaModelWithFieldsArray(
      {List<DataSourceSchemaModelField> fields});
}

@anonymous
@JS()
class DataSourceSchema {
  external DataSourceSchemaModelWithFieldsArray get model;
  external set model(DataSourceSchemaModelWithFieldsArray v);

  external factory DataSourceSchema(
      {DataSourceSchemaModelWithFieldsArray model});
}

@anonymous
@JS()
class DataSource {
  external String get type;
  external set type(String v);

  external DataSourceTransport get transport;
  external set transport(DataSourceTransport v);

  external DataSourceSchema get schema;
  external set schema(DataSourceSchema v);

  external factory DataSource(
      {String type, DataSourceTransport transport, DataSourceSchema schema});
}

@JS('kendo.ui.Grid')
class _KendoGrid {
  external _KendoGrid(String query, GridOptions options);
}

class Grid {
  _KendoGrid _kendoGrid;
  ResourcesLoaderService _resourcesLoader;

  Grid(this._resourcesLoader, String query, GridOptions options) {
    bool minificated = true;

    _resourcesLoader.loadStyle('packages/grid/src/', 'kendo.common-bootstrap.min.css');
    _resourcesLoader.loadStyle('packages/grid/src/', 'kendo.bootstrap.min.css');

    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.core.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.data.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.columnsorter.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.calendar.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.popup.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.datepicker.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.userevents.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.numerictextbox.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.list.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.dropdownlist.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.binder.min.js', false);
    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.filtermenu.min.js', false);

    _resourcesLoader.loadScript(
        'packages/grid/src/', 'kendo.grid.min.js', false,
        onData: () => new _KendoGrid(query, options));
  }
}
