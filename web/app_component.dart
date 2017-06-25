import 'dart:core';
import 'package:angular2/core.dart';
import 'package:master_layout/master_layout_component.dart';

import 'package:grid/grid_component.dart';
import 'package:grid/datasource.dart';
import 'package:grid/column_component.dart';
import 'package:grid/grid_template_directive.dart';

import 'call_off_order_details_component.dart';

@Component(
    selector: 'app',
    templateUrl: 'app_component.html',
    directives: const [
      MasterLayoutComponent,
      GridComponent,
      ColumnComponent,
      GridTemplateDirective,
      CallOffOrderDetailsComponent
    ])
class AppComponent {
  DataSource ds;

  AppComponent() {
    var orders = new List();

    for (var i = 1; i < 20; i++) {
      var o1 = {'Id': i, 'Name': 'Ордер $i'};
      orders.add(o1);
    }

    ds = new DataSource(data: orders);
  }

  rowClicked(dynamic rowData) {
    print('rowClicked! rowData: $rowData');
  }
}
