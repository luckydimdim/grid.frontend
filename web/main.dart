import 'dart:core';

import 'package:js/js.dart';

import 'package:grid/grid.dart';
import 'package:resources_loader/resources_loader.dart';


String render(dynamic record,dynamic ind, dynamic col_ind, dynamic data){

  /* непонятно как работать с record. не получается вытянуть свойства (ID) */

  var html = '<a href="#/master/contractView">'+ data +'</a>';
  return html;
}

main() {

  var columns = new List<Column>();
  columns.add(new Column(field: 'Code', caption: 'Код этапа', size: '100px', frozen: true));
  columns.add(new Column(field: 'Name', caption: 'Наименование этапа/работы', size: '200px', frozen: true, render: allowInterop(render)));

  var monthColumnWidth = '100px';

  columns.add(new Column(field: '01_2017', caption: 'Январь', size: monthColumnWidth));
  columns.add(new Column(field: '01_2017', caption: 'Февраль', size: monthColumnWidth));
  columns.add(new Column(field: '03_2017', caption: 'Март', size: monthColumnWidth));
  columns.add(new Column(field: '04_2017', caption: 'Апрель', size: monthColumnWidth));
  columns.add(new Column(field: '05_2017', caption: 'Май', size: monthColumnWidth));
  columns.add(new Column(field: '06_2017', caption: 'Июнь', size: monthColumnWidth));
  columns.add(new Column(field: '07_2017', caption: 'Июль', size: monthColumnWidth));
  columns.add(new Column(field: '08_2017', caption: 'Август', size: monthColumnWidth));
  columns.add(new Column(field: '09_2017', caption: 'Сентябрь', size: monthColumnWidth));
  columns.add(new Column(field: '10_2017', caption: 'Октябрь', size: monthColumnWidth));
  columns.add(new Column(field: '11_2017', caption: 'Ноябрь', size: monthColumnWidth));
  columns.add(new Column(field: '12_2017', caption: 'Декабрь', size: monthColumnWidth));

  columns.add(new Column(field: '01_2018', caption: 'Январь', size: monthColumnWidth));
  columns.add(new Column(field: '01_2018', caption: 'Февраль', size: monthColumnWidth));
  columns.add(new Column(field: '03_2018', caption: 'Март', size: monthColumnWidth));
  columns.add(new Column(field: '04_2018', caption: 'Апрель', size: monthColumnWidth));
  columns.add(new Column(field: '05_2018', caption: 'Май', size: monthColumnWidth));
  columns.add(new Column(field: '06_2018', caption: 'Июнь', size: monthColumnWidth));
  columns.add(new Column(field: '07_2018', caption: 'Июль', size: monthColumnWidth));
  columns.add(new Column(field: '08_2018', caption: 'Август', size: monthColumnWidth));
  columns.add(new Column(field: '09_2018', caption: 'Сентябрь', size: monthColumnWidth));
  columns.add(new Column(field: '10_2018', caption: 'Октябрь', size: monthColumnWidth));
  columns.add(new Column(field: '11_2018', caption: 'Ноябрь', size: monthColumnWidth));
  columns.add(new Column(field: '12_2018', caption: 'Декабрь', size: monthColumnWidth));

  var groups = new List<ColumnGroup>();

  groups.add(new ColumnGroup(caption: '', span: 1 ));
  groups.add(new ColumnGroup(caption: '', span: 1 ));
  groups.add(new ColumnGroup(caption: '2017', span: 12 ));
  groups.add(new ColumnGroup(caption: '2018', span: 12 ));

  var options = new GridOptions()
  ..name = 'grid'
  ..columns = columns
  ..columnGroups = groups
  ..url = 'http://cm-ylng-msk-01/cmas-backend/api/contractBudget/months/1'
  ..method='GET';

  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  new Grid(resourcesLoader, "#grid", options);
  //new Grid(resourcesLoader, "#grid2", options);
}


void AddDaysColumns(DateTime dateFrom, DateTime dateTill){

}