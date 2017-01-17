@JS()
library kendoGrid;

import 'package:js/js.dart';
import 'dart:html';

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

  external factory GridColumn({String field, String title, int width, bool filterable, bool lockable, bool sortable, String format});
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


  external factory GridOptions({List<GridColumn> columns, bool sortable, bool filterable, int height, DataSource dataSource});

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

  external factory DataSourceTransportRead({String url, String type, String dataType});
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
class DataSourceSchemaModelWithFieldsArray{
   external List<DataSourceSchemaModelField> get fields;
   external set fields(List<DataSourceSchemaModelField> v);

   external factory DataSourceSchemaModelWithFieldsArray({List<DataSourceSchemaModelField> fields});
}

@anonymous
@JS()
class DataSourceSchema {

  external DataSourceSchemaModelWithFieldsArray get model;
  external set model(DataSourceSchemaModelWithFieldsArray v);

  external factory DataSourceSchema({DataSourceSchemaModelWithFieldsArray model});
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

  external factory DataSource({String type, DataSourceTransport transport, DataSourceSchema schema});

}

@JS('kendo.ui.Grid')
class _KendoGrid {
  external _KendoGrid(String query, GridOptions options);
}

class Grid  {

  _KendoGrid _kendoGrid;

  Grid(String query, GridOptions options){

    bool minificated = true;

    var commonLink = new LinkElement()
      ..type = 'text/css'
      ..rel = 'stylesheet'
      ..href = 'packages/grid/src/kendo.common.min.css';
    document.head.append(commonLink);
    
    var defaultLink = new LinkElement()
      ..type = 'text/css'
      ..rel = 'stylesheet'
      ..href = 'packages/grid/src/kendo.default.min.css';
    document.head.append(defaultLink);
    
    var coreScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.core.min.js';
    document.body.append(coreScript);

    var dataScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.data.min.js';
    document.body.append(dataScript);

    var columnsorterScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.columnsorter.min.js';
    document.body.append(columnsorterScript);

    var calendarScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.calendar.min.js';
    document.body.append(calendarScript);

    var popupScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.popup.min.js';
    document.body.append(popupScript);

    var datepickerScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.datepicker.min.js';
    document.body.append(datepickerScript);

    var usereventsScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.userevents.min.js';
    document.body.append(usereventsScript);

    var numerictextboxScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.numerictextbox.min.js';
    document.body.append(numerictextboxScript);

    var listScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.list.min.js';
    document.body.append(listScript);

    var dropdownlistScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.dropdownlist.min.js';
    document.body.append(dropdownlistScript);

    var binderScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.binder.min.js';
    document.body.append(binderScript);

    var filtermenuScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.filtermenu.min.js';
    document.body.append(filtermenuScript);

    var gridScript = new ScriptElement()
      ..async = false
      ..type = 'text/javascript'
      ..src = 'packages/grid/src/kendo.grid'+ (minificated?'.min':'')+'.js';
    document.body.append(gridScript);

    gridScript.onLoad.listen((e) {
      _kendoGrid = new _KendoGrid(query, options);
    });

  }
}
