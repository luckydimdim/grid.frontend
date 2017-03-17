import 'dart:core';
import 'package:angular2/core.dart';

@Component(selector: 'call-off-order-details')
@View(templateUrl: 'call_off_order_details_component.html')
class CallOffOrderDetailsComponent implements AfterContentInit {
  @Input()
  dynamic rowData;

  @Output()
  final rowUpdated = new EventEmitter<dynamic>();

  String name = '';

  @override
  ngAfterContentInit() {
    name = rowData['Name'];
  }

  nameChanged(String value) {
    rowData['Name'] = value;
    rowUpdated.emit(rowData);
  }
}
