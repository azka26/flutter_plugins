import 'package:flutter/material.dart';

import 'field_map.dart';
import 'field_type.dart';

class TableMap {
  final String tableName;
  final List<FieldMap> fields;
  Map<String, dynamic> get fieldParameters {
    Map<String, dynamic> map = new Map<String, dynamic>();
    for (int i = 0; i < fields.length; i++) {
      map.putIfAbsent(fields[i].fieldName, () => fields[i].dbValue);
    }
    return map;
  }

  bool get pkIsAutoGenerate {
    for (int i = 0; i < fields.length; i++) {
      FieldMap field = fields[i];
      if (field.isPrimaryKey && field.isAutoGenerate && field.fieldType == FieldType.Int) {
        return true;
      }
    }
    return false;
  }

  FieldMap get primaryField {
    for (int i = 0; i < fields.length; i++) {
      FieldMap field = fields[i];
      if (field.isPrimaryKey) {
        return field;
      }
    }
    return null;
  }
  
  TableMap({@required this.tableName, @required this.fields});
}