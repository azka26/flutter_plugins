import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';
import 'package:az_fluent_sqflite/src/fluent/db_context.dart';
import 'package:az_fluent_sqflite/src/fluent/db_query.dart';
import 'package:az_fluent_sqflite/src/fluent/db_type_definition.dart';
import 'package:az_fluent_sqflite/src/fluent/db_where.dart';


class DbSelect<T extends ModelBase, U extends FilterBase<T>> {
  DbContext _dbContext;
  ModelBase _instance;
  FilterBase<T> _filter;
  DbQuery<T, U> _query;
  
  DbSelect({DbContext dbContext, T modelInstance, U filterInstance}) {
    this._dbContext = dbContext;
    this._instance = modelInstance;
    this._filter = filterInstance;
    this._query = new DbQuery(dbContext: this._dbContext, instanceModel: this._instance);
  }

  DbWhere<T, U> where(FilterFunction<T, U> filterFunction) {
    TreeFilter treeFilter = filterFunction(this._filter);
    this._query.filter = treeFilter;
    return DbWhere<T, U>(dbContext: this._dbContext, dbQuery: this._query, filterInstance: this._filter, modelInstance: this._instance);
  }

  Future<List<T>> toList() async {
    return await this._query.toList();
  }
}
