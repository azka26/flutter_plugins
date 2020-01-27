import 'db_context.dart';
import 'table_map.dart';

abstract class ModelBase {
  ModelBase defaultInstance();
  ModelBase rowToObj(Map<String, dynamic> map);
  TableMap toTable();
  void setPropertyId(dynamic value);
  DbContext dbContext;
}