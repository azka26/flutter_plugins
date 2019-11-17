import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqlitetransaction/sqflite_custom/sqflite_custom.dart';
import 'table_definition.dart';

class DBProvider 
{
  static Map<String, Database> _db = new Map<String, Database>();
  static Future<Database> getDatabase(String name, int version, {List<TableDefinition> tables}) async 
  {
    if (DBProvider._db != null && DBProvider._db.containsKey(name)) {
      return DBProvider._db[name];
    }

    String dbPath = await getDatabasesPath();
    dbPath = p.join(dbPath, name);


    Database dbOpen = await openDatabase(
      dbPath,
      version: version,
      onCreate: (Database db, int version) async {
        if (tables != null) {
          for (int i = 0; i < tables.length; i++) {
            await db.execute(DBProvider._createTableSQL(tables[i]));
          }
        }
      }
    );

    DBProvider._db.putIfAbsent(name, () => dbOpen);
    return DBProvider._db[name];
  }

  static String _createTableSQL(TableDefinition table) {
    if (table.fields == null || table.fields.length == 0) return "";
    String fieldStr = "";
    table.fields.forEach((fieldName, definition) {
      if (definition.isPrimaryKey && definition.type != FieldType.INTEGER) {
        throw new Exception("Primary Key must be type of Integer");
      }

      if (fieldStr != "") {
        fieldStr += ", ";
      }
      
      if (definition.type == FieldType.TEXT)
      {
        fieldStr += "$fieldName TEXT";
      }
      else if (definition.type == FieldType.INTEGER)
      {
        fieldStr += "$fieldName INTEGER";
      }
      else if (definition.type == FieldType.NUMERIC)
      {
        fieldStr += "$fieldName NUMERIC";
      }
      else if (definition.type == FieldType.REAL)
      {
        fieldStr += "$fieldName REAL";
      }
      else 
      {
        throw new Exception("Type ${definition.toString()} not supported.");
      }

      if (definition.isPrimaryKey) {
        fieldStr += " PRIMARY KEY";
      }
    });
  
    return "CREATE TABLE ${table.tableName} ($fieldStr);";
  }
}

