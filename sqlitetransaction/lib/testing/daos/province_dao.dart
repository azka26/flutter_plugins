import 'package:sqflite/sqflite.dart';
import 'package:sqlitetransaction/base/dao_base.dart';
import 'package:sqlitetransaction/testing/models/city.dart';
import 'package:sqlitetransaction/testing/models/province.dart';

class ProvinceDAO extends DAOBase<Province> {
  ProvinceDAO(Database db) : super(db: db, tableName: "province", primaryKey: "id");
  @override
  Province mapToObject(Map<String, dynamic> map) {
    Province province = new Province();
    province.id = map["id"];
    province.name = map["name"];
    return province;
  }
}