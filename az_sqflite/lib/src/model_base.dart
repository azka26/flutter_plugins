import 'package:az_sqflite/src/field_map.dart';
import 'package:az_sqflite/src/field_type.dart';

import 'db_context.dart';
import 'table_map.dart';

abstract class ModelBase {
  ModelBase defaultInstance();
  ModelBase rowToObj(Map<String, dynamic> map);
  TableMap toTable();
  void setPropertyId(dynamic value);
  DbContext dbContext;

  dynamic getValueField(String fieldName, Map<String, dynamic> map) {
    if (map == null) return null;

    TableMap tableMap = this.toTable();
    FieldMap fieldMap = tableMap.fields.where((field) => field.fieldName == fieldName).first;
    dynamic value = map[fieldMap.fieldName];
    if (value == null) return null;
    if (fieldMap.fieldType == FieldType.DateTime) {
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (fieldMap.fieldType == FieldType.Int) {
      if (value is int) return value;
    }
    if (fieldMap.fieldType == FieldType.Real) {
      if (value is double) return value;
    }
    if (fieldMap.fieldType == FieldType.Text) {
      if (value is String) return value;
    }
    throw new Exception("Value is not valid.");
  }
}