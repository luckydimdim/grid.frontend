import 'dart:async';
import 'dart:core';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:master_layout/master_layout_component.dart';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'package:grid/grid.dart';
import 'package:grid/jq_grid.dart' as jq;
import 'package:grid/JsObjectConverter.dart';


bool get isDebug =>
  (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) != 'true';

@Component(selector: 'app')
@View(
  template: '''
    <master-layout>
      <griiiid></griiiid>
    </master-layout>''',
  directives: const [MasterLayoutComponent, GridComponent])
class AppComponent {}

@Component(selector: 'griiiid')
@View(
  template: '<div id="grid"></div><div id="grid2"></div>')
class GridComponent implements AfterViewInit {
  @override
  Future ngAfterViewInit() async {
    await InitJqGrid();
  }
}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService)]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}

String render(dynamic record, dynamic ind, dynamic col_ind, dynamic data) {
  var code = getProperty(record, 'Code');

  var html = '<a href="#/master/contractView/$code">$data</a>';
  return html;
}

String renderjq(dynamic row, dynamic dataField, dynamic cellValue, dynamic rowData, dynamic cellText) {
  var name = getProperty(rowData, 'Name');

  return 'hi row: $row dataField: $dataField cellValue: $cellValue rowData: $rowData cellText: $cellText data: $name';
}

Future InitJqGrid() async {
  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  var columns = new List<jq.Column>();
  columns.add(new jq.Column()..text = 'Code'..dataField = 'Code'..cellsRenderer = allowInterop(renderjq));
  columns.add(new jq.Column()..text = 'Name'..dataField = 'Name');

  var dataFields = new List<jq.DataField>();
  dataFields.add(new jq.DataField()..name = 'Code'..type = 'number');
  dataFields.add(new jq.DataField()..name = 'Name'..type = 'string');

  var source = new jq.SourceOptions()
    ..url = 'http://cm-ylng-msk-01/cmas-backend/api/contract/1/works'

    ..dataFields = dataFields
      ..id = 'EmployeeID'
      ..dataType = 'json';

  var options = new jq.GridOptions()..columns = columns..source = source..checkboxes = true;

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
    ..method = 'GET';

  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  new Grid(resourcesLoader, "#grid", options);
}