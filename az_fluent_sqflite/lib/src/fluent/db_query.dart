import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';
import 'package:az_fluent_sqflite/src/fluent/db_context.dart';
import 'package:sqflite/sqflite.dart';

class DbQuery<T extends ModelBase, U extends FilterBase<T>> {
  DbContext _dbContext;
  ModelBase _instance;
  TreeFilter filter;

  DbQuery({DbContext dbContext, T instanceModel}) {
    this._dbContext = dbContext;
    this._instance = instanceModel;
  }

  Future<List<T>> toList() async {
    Transaction transaction = this._dbContext.transaction;
    List<Map<String, dynamic>> list;
    SQLFilter sqlFilter = filter == null ? null : filter.toSQL();
    TableMapper tableMapper = this._instance.toRow();

    if (transaction == null) {
      Database db = await this._dbContext.database;
      list = await db.query(tableMapper.tableName, where: sqlFilter?.sql, whereArgs: sqlFilter?.parameters);
    }
    else {
      list = await transaction.query(tableMapper.tableName, where: sqlFilter?.sql, whereArgs: sqlFilter?.parameters);
    }

    if (list == null) return new List<T>();
    List<T> results = new List<T>();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      ModelBase newInstance = _instance.defaultInstance();
      TableMapper mapper = newInstance.rowToObject(map);
      newInstance = newInstance.toObject(mapper.fieldMap);
      results.add(newInstance);
    }
    return results;
  }
}