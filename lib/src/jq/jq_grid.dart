@JS()
library jqGrid;

import 'dart:async';
import 'package:js/js.dart';
import 'package:resources_loader/resources_loader.dart';


@JS()
class JQuery {
  external jqxTreeGrid(Object options);

  @JS('jqx.dataAdapter')
  external dataAdapter(Object source);

  external on(String event, dynamic function);
}

@JS()
external JQuery $([String query]);

class jqGrid {
  ResourcesLoaderService _resourcesLoader;
  Object options;
  String query;

  jqGrid(this._resourcesLoader, this.query, this.options) { }

  Future<bool> Init() async {
    _resourcesLoader.loadStyle('packages/grid/src/jq/', 'jqx.base.css');
    _resourcesLoader.loadStyle('packages/grid/src/jq/', 'jqx.bootstrap.css');
    _resourcesLoader.loadStyle('packages/grid/src/jq/', 'my.css');

    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxcore.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxbuttons.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxscrollbar.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxdatatable.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxdata.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxcheckbox.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxlistbox.js', false);
    await _resourcesLoader.loadScriptAsync('packages/grid/src/jq/', 'jqxtreegrid.js', false);

    $(this.query).jqxTreeGrid(this.options);

    return true;
  }
}