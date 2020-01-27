import 'package:flutter/material.dart';
import 'field_type.dart';

class FieldMap {
  final String fieldName;
  final FieldType fieldType;
  final bool isPrimaryKey;
  final bool isAutoGenerate;

  dynamic value;

  dynamic get dbValue {
    if (this.value == null) return this.value;
    if (fieldType == FieldType.DateTime) {
      if (this.value is DateTime) return (this.value as DateTime).millisecondsSinceEpoch;
    }

    if (fieldType == FieldType.Int) {
      if (this.value is int) return this.value;
    }

    if (fieldType == FieldType.Real) {
      if (this.value is double) return this.value;
    }

    if (fieldType == FieldType.Text) {
      if (this.value is String) return this.value;
    }

    throw new Exception("Value is not valid at field = ${this.fieldName}.");
  }

  FieldMap({@required this.fieldName, @required this.fieldType, this.isPrimaryKey = false, this.isAutoGenerate = false, this.value});
}