import 'package:az_fluent_sqflite/src/orm/field_type.dart';

class FieldMapper {
  final String fieldName;
  final FieldType fieldType;
  dynamic value;
  bool isPrimaryKey;
  bool isAutoGenerate;

  String get fieldTypeString {
    if (fieldType == FieldType.Text) return "TEXT";
    if (fieldType == FieldType.DateTime) return "INTEGER";
    if (fieldType == FieldType.Int) return "INTEGER";
    if (fieldType == FieldType.Real) return "REAL";
    if (fieldType == FieldType.Boolean) return "INTEGER";
    return null;
  }

  FieldMapper({this.fieldName, this.fieldType, this.value, this.isPrimaryKey = false, this.isAutoGenerate = false});
  
  dynamic get objectValue {
    if (value == null) return null;
    if (this.fieldType == FieldType.DateTime) {
      if (this.value is int) {
        return DateTime.fromMillisecondsSinceEpoch(this.value);
      }
      if (this.value is DateTime) {
        return this.value as DateTime;
      }
    }
    if (this.fieldType == FieldType.Boolean && this.value is int) {
      return this.value > 0;
    }
    if (this.fieldType == FieldType.Int && this.value is int) {
      return this.value as int;
    }
    if (this.fieldType == FieldType.Real && this.value is double) {
      return this.value as double;
    }
    if (this.fieldType == FieldType.Text && this.value is String) {
      return this.value as String;
    }
    throw new Exception("Value is not valid");
  }

  dynamic get dbValue {
    if (value == null) return null;
    if (this.fieldType == FieldType.DateTime && this.value is DateTime) {
      return (this.value as DateTime).millisecondsSinceEpoch;
    }
    if (this.fieldType == FieldType.Boolean && this.value is bool) {
      return this.value ? 1 : 0;
    }
    if (this.fieldType == FieldType.Int && this.value is int) {
      return this.value as int;
    }
    if (this.fieldType == FieldType.Real && this.value is double) {
      return this.value as double;
    }
    if (this.fieldType == FieldType.Text && this.value is String) {
      return this.value as String;
    }
    throw new Exception("Value is not valid");
  }
}