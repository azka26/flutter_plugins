import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

typedef transactionScope = Future<bool> Function();

abstract class DbContext {
  Database _database;
  Transaction _transaction;
  String dbName;
  int version;
  
  Future onDatabaseCreated(Database db, int version);
  Future onDatabaseUpgrade(Database db, int oldVersion, int newVersion);
  Future onConfigure(Database db);

  Future<Database> getDbInstance() async {
    if (_database != null && _database.isOpen) {
      return this._database;
    }
    String defaultDir = await getDatabasesPath();
    String path = join(defaultDir, this.dbName);
    this._database = await openDatabase(
      path,
      version: version,
      onConfigure: (Database db) async {
        await onConfigure(db);
      },
      onCreate: (Database db, int version) async {
        await onDatabaseCreated(db, version);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await onDatabaseUpgrade(db, oldVersion, newVersion);
      },
    );
    return this._database;
  }

  Transaction getTransaction() {
    return _transaction;
  }

  Future<int> rawInsert(String sql, [List<dynamic> arguments]) {
    Transaction transaction = getTransaction();
    if (transaction == null) {
      return this.getDbInstance().then((db) {
        return db.rawInsert(sql, arguments);
      });
    }

    return transaction.rawInsert(sql, arguments);
  }

  Future<int> rawUpdate(String sql, [List<dynamic> arguments]) {
    Transaction transaction = getTransaction();
    if (transaction == null) {
      return this.getDbInstance().then((db) {
        return db.rawUpdate(sql, arguments);
      });
    }

    return transaction.rawUpdate(sql, arguments);
  }

  Future<int> rawDelete(String sql, [List<dynamic> arguments]) {
    Transaction transaction = getTransaction();
    if (transaction == null) {
      return this.getDbInstance().then((db) {
        return db.rawDelete(sql, arguments);
      });
    }
    
    return transaction.rawDelete(sql, arguments);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic> arguments]) {
    Transaction transaction = getTransaction();
    if (transaction == null) {
      return this.getDbInstance().then((db) {
        return db.rawQuery(sql, arguments);
      });
    }
    return transaction.rawQuery(sql, arguments);
  }

  Future<bool> usingTransaction(transactionScope scope) async {
    return await this.getDbInstance().then((db) async => await db.transaction((trans) async {
      this._transaction = trans;
      bool result = await scope();
      if (!result) {
        throw new Exception("Rollback");
      }
      return result;
    }));
  }
}