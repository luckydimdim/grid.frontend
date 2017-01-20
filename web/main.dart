import 'dart:core';

import 'package:grid/grid.dart';
import 'package:resources_loader/resources_loader.dart';

main() {
  var model = new DataSourceSchemaModelWithFieldsArray();
  model.fields = new List<DataSourceSchemaModelField>();

  model.fields.add(
      new DataSourceSchemaModelField(field: "conclusionDate", type: "date"));

  var schema = new DataSourceSchema()..model = model;

  var transportRead = new DataSourceTransportRead()
    ..type = "get"
    ..dataType = "json"
    ..url = "//localhost:5000/api/contract";

  var transport = new DataSourceTransport()..read = transportRead;

  var dataSource = new DataSource()
    ..type = "odata"
    ..schema = schema
    ..transport = transport;

  GridOptions options = new GridOptions()
    ..dataSource = dataSource
    ..columns = new List<GridColumn>()
    ..filterable = true
    //..height = 500
    ..sortable = true;

  options.columns.add(new GridColumn(
      field: "number", title: "№", width: 150, filterable: true));
  options.columns.add(new GridColumn(
      field: "name", title: "Наименование договора", sortable: true));
  options.columns.add(new GridColumn(
      field: "conclusionDate",
      title: "Дата заключения",
      sortable: true,
      format: "{0: MM/dd/yyyy}"));

  ResourcesLoader resourcesLoader = new ResourcesLoader();

  new Grid(resourcesLoader, "#grid", options);
  new Grid(resourcesLoader, "#grid2", options);
}
