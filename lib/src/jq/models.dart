library jq_models;
import '../JsObjectConverter.dart';

class Column {

  @Reflectable()
  String  text = '';

  @Reflectable()
  String  columnGroup;

  @Reflectable()
  String  cellsAlign;

  @Reflectable()
  String  align;

  @Reflectable()
  String  cellsFormat;

  @Reflectable()
  String  dataField = '';

  @Reflectable()
  bool  pinned = false;
}

class GridOptions {

  @Reflectable()
  bool altRows = true;

  @Reflectable()
  bool editable = true;

  @Reflectable()
  bool checkboxes = true;

  @Reflectable()
  String  width = '100%';

  @Reflectable()
  String  height = '100vh';

  @Reflectable()
  List<Column>  columns;

  //@Reflectable()
  //List<ColumnGroup>  columnGroups = new List<ColumnGroup>();

  @Reflectable()
  SourceOptions source;

  @Reflectable()
  EditSettings  editSettings = new EditSettings();
}

class ColumnGroup {

  @Reflectable()
  String text = '';

  @Reflectable()
  String name = '';

  @Reflectable()
  String align = '';
}

class EditSettings {

  @Reflectable()
  bool saveOnPageChange = true;

  @Reflectable()
  bool saveOnBlur = true;

  @Reflectable()
  bool saveOnSelectionChange = true;

  @Reflectable()
  bool cancelOnEsc = true;

  @Reflectable()
  bool saveOnEnter = true;

  @Reflectable()
  bool editSingleCell = true;

  @Reflectable()
  bool editOnDoubleClick = true;

  @Reflectable()
  bool editOnF2 = true;

}

class DataField {
  @Reflectable()
  String name = '';

  @Reflectable()
  String type = '';
}

class Hierarchy {
  @Reflectable()
  String root = '';

  @Reflectable()
  String record = '';
}

class SourceOptions {

  @Reflectable()
  String dataType = 'json';

  @Reflectable()
  String id;

  @Reflectable()
  String root;

  @Reflectable()
  String record;

  @Reflectable()
  String url;

  @Reflectable()
  String localData;

  @Reflectable()
  List<DataField> dataFields;

  @Reflectable()
  Hierarchy hierarchy;
}