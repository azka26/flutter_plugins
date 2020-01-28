import 'dart:async';

import 'package:az_fluent_sqflite/src/fluent/db_context.dart';
import 'package:az_fluent_sqflite/src/fluent/db_set.dart';
import 'package:az_fluent_sqflite/test/filters/province_filter.dart';
import 'package:az_fluent_sqflite/test/models/province.dart';
import 'package:sqflite/sqflite.dart';

class RegionContext extends DbContext {
  RegionContext() : super() {
    super.dbName = "test";
    super.dbVersion = 1;
    this.provinces = DbSet<Province, ProvinceFilter>(
      dbContext: this,
      modelInstance: Province(),
      filterInstance: ProvinceFilter(Province()),
    );
  }

  @override
  FutureOr<void> onConfigure(Database db) {
    db.execute(this.provinces.createTableDefinition());
  }

  DbSet<Province, ProvinceFilter> provinces;
}
