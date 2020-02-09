import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

typedef TransactionScope = Future<bool> Function();
abstract class DbContext {
  String dbName;
  int dbVersion;
  Database _db;
  Transaction _transaction;

  FutureOr<void> onConfigure(Database db);
  FutureOr<void> onCreate(Database db, int version);
  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion);
  FutureOr<void> onOpen(Database db);
  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion);
  
  Future<Database> get database async 
  {
    if (this._db != null && this._db.isOpen) {
      return this._db;
    }

    String path = await getDatabasesPath();
    path = join(path, dbName + ".db");
    this._db = await openDatabase(
      path, 
      version: this.dbVersion,
      onOpen: this.onOpen,
      onConfigure: this.onConfigure,
      onCreate: this.onCreate,
      onDowngrade: this.onDowngrade,
      onUpgrade: this.onUpgrade
    );
    return this._db;
  }

  Transaction get transaction 
  {
    return this._transaction;
  }

  Future<bool> usingTransaction(TransactionScope scope) async
  {
    Database db = await this.database;
    return db.transaction((ts) async {
      this._transaction = ts;
      bool scopeResult = await scope();
      if (!scopeResult) {
        throw("Transaction Rollback.");
      }
      return scopeResult;
    }).then((result) {
      this._transaction = null;
      return result;
    }, onError: (error) {
      this._transaction = null;
      throw(error);
    });
  }
}