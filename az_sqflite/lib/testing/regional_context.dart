import 'package:az_sqflite/src/db_context.dart';
import 'package:az_sqflite/src/db_set.dart';
import 'package:sqflite/sqflite.dart';

import 'models/city.dart';
import 'models/province.dart';

class RegionalContext extends DbContext {
  DbSet<Province> provinces;
  DbSet<City> cities;

  RegionalContext() {
    super.dbName = "test.db";
    super.version = 1;

    provinces = new DbSet(dbContext: this, defaultInstance: new Province());
    cities = new DbSet(dbContext: this, defaultInstance: new City());
  }

  @override
  Future onConfigure(Database db) {}

  @override
  Future onDatabaseCreated(Database db, int version) async {
    String province =
        "CREATE TABLE province_table (field_id TEXT PRIMARY KEY, field_name TEXT)";
    String city =
        "CREATE TABLE city_table (field_id TEXT PRIMARY KEY, field_name TEXT, field_province_id TEXT)";
    await db.execute(province);
    await db.execute(city);
  }

  @override
  Future onDatabaseUpgrade(Database db, int oldVersion, int newVersion) {}
}
