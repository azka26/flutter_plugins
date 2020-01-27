import 'package:az_sqflite/src/field_map.dart';
import 'package:az_sqflite/src/field_type.dart';
import 'package:az_sqflite/src/model_base.dart';
import 'package:az_sqflite/src/table_map.dart';

import 'city.dart';

class Province extends ModelBase {
  String _id;
  String _name;

  String get id => this._id;
  String get name => this._name;

  List<City> _listOfCities;
  List<City> get listOfCities => this._listOfCities;
  set listOfCities(List<City> val) => this._listOfCities = val;

  set id(String val) => this._id = val;
  set name(String val) => this._name = val;

  @override
  ModelBase defaultInstance() {
    return new Province();
  }

  @override
  ModelBase rowToObj(Map<String, dynamic> map) {
    Province province = new Province();
    province.id = map["field_id"];
    province.name = map["field_name"];
    return province;
  }

  @override
  TableMap toTable() {
    return TableMap(
      tableName: "province_table",
      fields: [
        FieldMap(fieldName: "field_id", fieldType: FieldType.Text, isPrimaryKey: true, value: this.id),
        FieldMap(fieldName: "field_name", fieldType: FieldType.Text)
      ]
    );
  }

  @override
  void setPropertyId(value) {
    this.id = value;
  }
}