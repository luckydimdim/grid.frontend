import 'dart:core';

import 'package:grid/grid.dart';
import 'package:resources_loader/resources_loader.dart';

main() {

  var columns = new List<Column>();
  columns.add(new Column(field: 'id', caption: 'id', size: '100px'));
  columns.add(new Column(field: 'number', caption: '№', size: '100px'));
  columns.add(new Column(field: '01_01_2017', caption: '01', size: '10px'));
  columns.add(new Column(field: '02_01_2017', caption: '02', size: '10px'));
  columns.add(new Column(field: '03_01_2017', caption: '03', size: '10px'));
  columns.add(new Column(field: '04_01_2017', caption: '04', size: '10px'));
  columns.add(new Column(field: '05_01_2017', caption: '05', size: '10px'));
  columns.add(new Column(field: '06_01_2017', caption: '06', size: '10px'));
  columns.add(new Column(field: '07_01_2017', caption: '07', size: '10px'));
  columns.add(new Column(field: '08_01_2017', caption: '08', size: '10px'));
  columns.add(new Column(field: '09_01_2017', caption: '09', size: '10px'));
  columns.add(new Column(field: '10_01_2017', caption: '10', size: '10px'));

  var groups = new List<ColumnGroup>();

  groups.add(new ColumnGroup(caption: 'safd', span: 1 ));
  groups.add(new ColumnGroup(caption: 'kdjdh', span: 1 ));
  groups.add(new ColumnGroup(caption: 'dfghdfh', span: 10 ));

  var options = new GridOptions()
  ..name = 'grid'
  ..columns = columns
  ..columnGroups = groups
  ..url='http://localhost:5000/api/contract/'
  ..method='GET';

  ResourcesLoaderService resourcesLoader = new ResourcesLoaderService();

  new Grid(resourcesLoader, "#grid", options);
  //new Grid(resourcesLoader, "#grid2", options);
}
