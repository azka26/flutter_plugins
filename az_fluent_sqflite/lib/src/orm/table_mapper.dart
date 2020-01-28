import 'package:az_fluent_sqflite/src/orm/field_mapper.dart';
import 'package:az_fluent_sqflite/src/orm/field_type.dart';

class TableMapper {
  final String tableName;
  final List<FieldMapper> fields;
  
  Map<String, FieldMapper> _fieldMap;
  Map<String, FieldMapper> get fieldMap 
  {
    if (_fieldMap != null) return this._fieldMap;
    this._fieldMap = new Map<String, FieldMapper>();
    for (int i = 0; i < fields.length; i++) {
      this._fieldMap.putIfAbsent(fields[i].fieldName, () => fields[i]);
    }
    return this._fieldMap;
  }

  bool get isPrimaryKeyAutoGenerate {
    return this.fields.where((f) => f.isAutoGenerate == true && f.isPrimaryKey == true && f.fieldType == FieldType.Int).length > 0;
  }

  Map<String, dynamic> toFieldValue() {
    Map<String, dynamic> mapValue = new Map<String, dynamic>();
    for (int i = 0; i < fields.length; i++) {
      mapValue.putIfAbsent(fields[i].fieldName, fields[i].dbValue);
    }
    return mapValue;
  }

  FieldMapper get primaryField {
    return this.fields.where((f) => f.isPrimaryKey == true).first;
  }

  TableMapper({this.tableName, this.fields});
}