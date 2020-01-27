import 'package:az_sqflite/src/db_context.dart';
import 'package:az_sqflite/src/db_query.dart';
import 'package:flutter/cupertino.dart';

import 'model_base.dart';

class DbSelect<T extends ModelBase> {
  final DbContext dbContext;
  ModelBase modelInstance;

  DbSelect({@required this.dbContext, @required T defaultInstance}) {
    this.modelInstance = defaultInstance;
  }

  Future<List<T>> toList() async {
    DbQuery<T> query = new DbQuery(dbContext: this.dbContext, defaultInstance: this.modelInstance);
    return await query.toList();
  }

  Future<int> count() async {
    DbQuery<T> query = new DbQuery(dbContext: this.dbContext, defaultInstance: this.modelInstance);
    return await query.count();
  }
}
