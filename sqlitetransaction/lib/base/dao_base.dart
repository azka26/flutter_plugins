import 'package:sqflite/sqflite.dart';
import 'model_base.dart';
import '../specification/specification.dart';

abstract class DAOBase<T extends ModelBase> {
  final Database db;
  final String tableName;
  final String primaryKey;
  DAOBase({this.db, this.tableName, this.primaryKey});

  Future<int> insert(T model) async {
    int id = await db.insert(this.tableName, model.mapToField(), conflictAlgorithm: ConflictAlgorithm.rollback);
    return id; 
  }

  Future<bool> update(T model, int id) async {
    int affectedRow = await db.update(this.tableName, model.mapToField(), where: "${this.primaryKey} = ?", whereArgs: [id], conflictAlgorithm: ConflictAlgorithm.rollback);
    return affectedRow > 0;
  }

  Future<bool> delete(int id) async 
  {
    int affectedRow = await db.delete(this.tableName, where: "${this.primaryKey} = ?", whereArgs: [id]);
    return affectedRow > 0;
  }

  Future<T> getObject(int id) async 
  {
    List<Map<String, dynamic>> listMap = await db.query(this.tableName, where: "${this.primaryKey} = ?", whereArgs: [id]);
    if (listMap == null || listMap.length == 0) return null;
    return this.mapToObject(listMap[0]);
  }

  Future<List<T>> getList({Specification specification, int limit, int offset}) async {
    List<Map<String, dynamic>> listMap = await db.query(
      this.tableName, 
      where: specification == null ? null : specification.getSQL(), 
      whereArgs: specification == null ? null : specification.getSQLParameter(),
      limit: limit,
      offset: offset
    );
    if (listMap == null || listMap.length == 0) return null;
    List<T> result = new List<T>();
    for (int i = 0; i < listMap.length; i++) {
      result.add(this.mapToObject(listMap[i]));
    }
    return result;
  }

  T mapToObject(Map<String, dynamic> map);
}