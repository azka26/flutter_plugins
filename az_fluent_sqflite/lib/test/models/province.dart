import 'package:az_fluent_sqflite/src/base/export.dart';
import 'package:az_fluent_sqflite/src/orm/export.dart';
import 'package:az_fluent_sqflite/src/orm/table_mapper.dart';

class Province extends ModelBase {
  int _id;
  String _name;

  set id(int val) => this._id = val;
  set name(String val) => this._name = val;
  int get id => this._id;
  String get name => this._name;

  @override
  ModelBase defaultInstance() {
    return new Province();
  }

  @override
  ModelBase toObject(Map<String, FieldMapper> map) {
    Province instance = new Province();
    instance.id = map["field_id"].objectValue;
    instance.name = map["field_name"].objectValue;
    return instance;
  }

  @override
  TableMapper toRow() {
    return TableMapper(
      tableName: "province_table",
      fields: [
        FieldMapper(fieldName: "field_id", fieldType: FieldType.Int, isAutoGenerate: true, isPrimaryKey: true, value: this.id),
        FieldMapper(fieldName: "field_name", fieldType: FieldType.Text, value: this.name)
      ]
    );
  }

  @override
  void setInsertedId(int value) {
    this.id = value;
  }
}