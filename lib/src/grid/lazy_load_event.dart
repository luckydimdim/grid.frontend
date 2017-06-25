import 'filter_metadata.dart';

class LazyLoadEvent {
  int first;
  int rows;
  String sortField;
  int sortOrder;
  Map<String, FilterMetadata> filters;
}
