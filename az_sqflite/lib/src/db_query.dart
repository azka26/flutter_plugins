import 'package:az_sqflite/src/model_base.dart';
import 'package:az_sqflite/src/table_map.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db_context.dart';

class DbQuery<T extends ModelBase> {
  final DbContext dbContext;
  ModelBase modelInstance;

  DbQuery({@required this.dbContext, @required T defaultInstance}) {
    this.modelInstance = defaultInstance;
  }

  Future<List<T>> toList() async {
    TableMap table = modelInstance.toTable();
    Transaction transaction = this.dbContext.getTransaction();
    List<Map<String, dynamic>> list;
    if (transaction == null) {
      Database db = await this.dbContext.getDbInstance();
      list = await db.query(table.tableName);
    } 
    else 
    {
      list = await transaction.query(table.tableName);
    }
    
    if (list == null || list.length == 0) return new List<T>();
    List<T> results = new List<T>();
    for (int i = 0; i < list.length; i++) {
      ModelBase newInstance = modelInstance.defaultInstance().rowToObj(list[i]);
      results.add(newInstance);
    }
    return results;
  }

  Future<int> count() async {
    TableMap table = modelInstance.toTable();
    Transaction transaction = this.dbContext.getTransaction();
    List<Map<String, dynamic>> list;
    if (transaction == null) {
      Database db = await this.dbContext.getDbInstance();
      list = await db.query(table.tableName, columns: ["COUNT(${table.primaryField.fieldName}) as row_count"]);
    } 
    else 
    {
      list = await transaction.query(table.tableName, columns: ["COUNT(${table.primaryField.fieldName}) as row_count"]);
    }
    
    if (list == null || list.length == 0) return 0;
    return list[0]["row_count"] as int;
  }
}