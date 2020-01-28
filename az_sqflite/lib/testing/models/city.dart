import 'package:az_sqflite/src/field_map.dart';
import 'package:az_sqflite/src/field_type.dart';
import 'package:az_sqflite/src/model_base.dart';
import 'package:az_sqflite/src/table_map.dart';
import 'package:az_sqflite/testing/models/province.dart';

import '../regional_context.dart';

class City extends ModelBase {
  String _id;
  String _name;
  Province _province;

  String get id => this._id;
  String get name => this._name;

  Future<Province> loadProvince() async {
    if (this._province != null && this._province.id != null) {
      RegionalContext currentDbContext = dbContext;
      this._province = await currentDbContext.provinces.find(this._province.id);
    }
    return this._province;
  }

  Province get province {
    return this._province;
  }

  set id(String val) => this._id = val;
  set name(String val) => this._name = val;
  set province(Province val) => this._province = val;

  @override
  ModelBase defaultInstance() {
    return new City();
  }

  @override
  ModelBase rowToObj(Map<String, dynamic> map) {
    City city = new City();
    city.id = getValueField("field_id", map);
    city.name = getValueField("field_name", map);
    String valueProvinceId = getValueField("field_province_id", map);
    if (valueProvinceId != null) {
      city.province = new Province();
      city.province.id = valueProvinceId;
    }
    return city;
  }

  @override
  TableMap toTable() {
    return TableMap(
      tableName: "city_table",
      fields: [
        FieldMap(fieldName: "field_id", fieldType: FieldType.Text, isPrimaryKey: true, value: this.id),
        FieldMap(fieldName: "field_name", fieldType: FieldType.Text),
        FieldMap(fieldName: "field_province_id", fieldType: FieldType.Text)
      ]
    );
  }

  @override
  void setPropertyId(value) {
    this.id = value;
  }
}
