import 'dart:async';
import 'dart:core';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'package:grid/grid.dart';
import 'package:grid/jq_grid.dart' as jq;
import 'package:grid/JsObjectConverter.dart';

import 'package:resources_loader/resources_loader.dart';

String render(dynamic record, dynamic ind, dynamic col_ind, dynamic data) {
  var code = getProperty(record, 'Code');

  var html = '<a href="#/master/contractView/$code">$data</a>';
  return html;
}

String renderjq(dynamic row, dynamic dataField, dynamic cellValue, dynamic rowData, dynamic cellText) {

  var name  = getProperty(rowData, 'Name');
 // var name  = rowData.Name;

  return 'hi row: $row dataField: $dataField cellValue: $cellValue rowData: $rowData cellText: $cellText data: $name';
}

main() async {

  //InitW2uiGrid();
  InitJqGrid();
}

Future InitJqGrid() async {

  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  var columns = new List<jq.Column>();
  columns.add(new jq.Column()..text = 'Code'..dataField='Code'..cellsRenderer = allowInterop(renderjq));
  columns.add(new jq.Column()..text = 'Name'..dataField='Name');

  var dataFields = new List<jq.DataField>();
  dataFields.add(new jq.DataField()..name='Code'..type='number');
  dataFields.add(new jq.DataField()..name='Name'..type='string');

  var source = new jq.SourceOptions()
    //..url = 'http://localhost:5000/api/contract/1/works'
    ..url = 'http://cm-ylng-msk-01/cmas-backend/api/contract/1/works'

    ..dataFields = dataFields
      ..id = 'EmployeeID'
      ..dataType='json';

  var options = new jq.GridOptions()..columns = columns..source=source..checkboxes=true;

  var grid = new jq.jqGrid(resourcesLoader, '#grid', JsObjectConverter.convert(options));

  await grid.Init();

}

void InitW2uiGrid() {
  var columns = new List<Column>();
  columns.add(new Column(
      field: 'Code', caption: 'Код этапа', size: '100px', frozen: true));
  columns.add(new Column(
      field: 'Name',
      caption: 'Наименование этапа/работы',
      size: '200px',
      frozen: true,
      render: allowInterop(render)));

  var monthColumnWidth = '100px';

  columns.add(
      new Column(field: '01_2017', caption: 'Январь', size: monthColumnWidth));
  columns.add(
      new Column(field: '01_2017', caption: 'Февраль', size: monthColumnWidth));
  columns.add(
      new Column(field: '03_2017', caption: 'Март', size: monthColumnWidth));
  columns.add(
      new Column(field: '04_2017', caption: 'Апрель', size: monthColumnWidth));
  columns.add(
      new Column(field: '05_2017', caption: 'Май', size: monthColumnWidth));
  columns.add(
      new Column(field: '06_2017', caption: 'Июнь', size: monthColumnWidth));
  columns.add(
      new Column(field: '07_2017', caption: 'Июль', size: monthColumnWidth));
  columns.add(
      new Column(field: '08_2017', caption: 'Август', size: monthColumnWidth));
  columns.add(new Column(
      field: '09_2017', caption: 'Сентябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '10_2017', caption: 'Октябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '11_2017', caption: 'Ноябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '12_2017', caption: 'Декабрь', size: monthColumnWidth));

  columns.add(
      new Column(field: '01_2018', caption: 'Январь', size: monthColumnWidth));
  columns.add(
      new Column(field: '01_2018', caption: 'Февраль', size: monthColumnWidth));
  columns.add(
      new Column(field: '03_2018', caption: 'Март', size: monthColumnWidth));
  columns.add(
      new Column(field: '04_2018', caption: 'Апрель', size: monthColumnWidth));
  columns.add(
      new Column(field: '05_2018', caption: 'Май', size: monthColumnWidth));
  columns.add(
      new Column(field: '06_2018', caption: 'Июнь', size: monthColumnWidth));
  columns.add(
      new Column(field: '07_2018', caption: 'Июль', size: monthColumnWidth));
  columns.add(
      new Column(field: '08_2018', caption: 'Август', size: monthColumnWidth));
  columns.add(new Column(
      field: '09_2018', caption: 'Сентябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '10_2018', caption: 'Октябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '11_2018', caption: 'Ноябрь', size: monthColumnWidth));
  columns.add(
      new Column(field: '12_2018', caption: 'Декабрь', size: monthColumnWidth));

  var groups = new List<ColumnGroup>();

  groups.add(new ColumnGroup(caption: '', span: 1));
  groups.add(new ColumnGroup(caption: '', span: 1));
  groups.add(new ColumnGroup(caption: '2017', span: 12));
  groups.add(new ColumnGroup(caption: '2018', span: 12));

  var options = new GridOptions()
    ..name = 'grid'
    ..columns = columns
    ..columnGroups = groups
    ..url = 'http://cm-ylng-msk-01/cmas-backend/api/contractBudget/months/1'
    //..url = 'http://localhost:5000/api/contractBudget/months/1'
    ..method = 'GET';

  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  new Grid(resourcesLoader, "#grid", options);
}
