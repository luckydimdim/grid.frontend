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
    var o1 = {'Id': '1', 'Name': 'Ордер 1'};
    var o2 = {'Id': '2', 'Name': 'Ордер 2'};

    var orders = new List();
    orders.add(o1);
    orders.add(o2);

    ds = new DataSource(data: orders);
  }

  rowClicked(dynamic rowData) {
    print('rowClicked! rowData: $rowData');
  }
}
