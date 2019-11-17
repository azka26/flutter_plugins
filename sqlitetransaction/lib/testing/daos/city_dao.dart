import 'package:sqflite/sqflite.dart';
import 'package:sqlitetransaction/base/dao_base.dart';
import 'package:sqlitetransaction/testing/models/city.dart';
import 'package:sqlitetransaction/testing/models/province.dart';

class CityDao extends DAOBase<City> {
  CityDao(Database db) : super(db: db, tableName: "city", primaryKey: "id");
  
  @override
  City mapToObject(Map<String, dynamic> map) {
    City city = new City();
    city.id = map["id"];
    city.name = map["name"];
    city.province = new Province();
    city.province.id = map["province_id"];
    return city;
  }
}