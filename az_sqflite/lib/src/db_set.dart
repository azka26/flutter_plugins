import 'package:az_sqflite/src/db_select.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db_context.dart';
import 'field_map.dart';
import 'model_base.dart';
import 'table_map.dart';

class DbSet<T extends ModelBase> {
  final DbContext dbContext;
  ModelBase modelInstance;

  DbSet({@required this.dbContext, @required T defaultInstance}) {
    modelInstance = defaultInstance;
    modelInstance.dbContext = this.dbContext;
  }

  Future<T> find(dynamic id) async {
    List<Map<String, dynamic>> list;
    Transaction transaction = dbContext.getTransaction();
    TableMap tableMap = this.modelInstance.toTable();
    String tableName = tableMap.tableName;
    FieldMap primaryProperty = tableMap.fields.where((field) => field.isPrimaryKey).first;
    if (transaction == null) {
      list = await dbContext.getDbInstance().then((db) => db
          .query(tableName, where: "${primaryProperty.fieldName} = ?", whereArgs: [id]));
    } else {
      list = await transaction
          .query(tableName, where: "${primaryProperty.fieldName} = ?", whereArgs: [id]);
    }
    if (list == null || list.length == 0) return null;
    return modelInstance.defaultInstance().rowToObj(list[0]);
  }
  
  Future<T> insert(T model) async {
    if (model == null) return null;
    ModelBase instance = model;
    TableMap tableMap = instance.toTable();
    Transaction transaction = dbContext.getTransaction();
    int result = 0;
    if (transaction == null) {
      result = await this.dbContext.getDbInstance().then((db) async {
        return await db.insert(tableMap.tableName, tableMap.fieldParameters);
      });
    } else {
      result = await transaction.insert(tableMap.tableName, tableMap.fieldParameters);
    }
    if (result <= 0) return null;
    if (tableMap.pkIsAutoGenerate) {
      instance.setPropertyId(result);
    }
    return instance;
  }

  Future<bool> update(T model, dynamic id) async 
  {
    if (model == null) return false;
    ModelBase instance = model;
    TableMap tableMap = instance.toTable();
    FieldMap pkField = tableMap.primaryField;

    Transaction transaction = dbContext.getTransaction();
    int result = 0;
    if (transaction == null) {
      result = await this.dbContext.getDbInstance().then((db) async {
        return await db.update(tableMap.tableName, tableMap.fieldParameters, where: "${pkField.fieldName} = ?", whereArgs: [id]);
      });
    }
    else {
      result = await transaction.update(tableMap.tableName, tableMap.fieldParameters, where: "${pkField.fieldName} = ?", whereArgs: [id]);
    }
    if (result == 0) return false;
    return true;
  }

  Future<bool> delete(dynamic id) async 
  {
    TableMap tableMap = modelInstance.toTable();
    FieldMap pkField = tableMap.primaryField;

    Transaction transaction = dbContext.getTransaction();
    int result = 0;
    if (transaction == null) {
      result = await this.dbContext.getDbInstance().then((db) async {
        return await db.delete(tableMap.tableName, where: "${pkField.fieldName} = ?", whereArgs: [id]);
      });
    }
    else {
      result = await transaction.delete(tableMap.tableName, where: "${pkField.fieldName} = ?", whereArgs: [id]);
    }
    if (result == 0) return false;
    return true;
  }

  DbSelect<T> select() {
    return new DbSelect(dbContext: this.dbContext, defaultInstance: this.modelInstance);
  }
}