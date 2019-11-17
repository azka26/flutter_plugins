import 'package:sqflite/sqlite_api.dart';
import 'package:sqlitetransaction/sqflite_custom/db_provider.dart';
import 'package:sqlitetransaction/testing/db_structure.dart';

class DataAccess {
  static Database _db;
  static Future<Database> getAppDB() async {
    if (DataAccess._db != null) {
      return DataAccess._db;
    }

    DataAccess._db = await DBProvider.getDatabase("test.db", 1, tables: Structure.getDefinition());
    return DataAccess._db;
  }
}