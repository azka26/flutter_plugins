import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';
import 'package:az_fluent_sqflite/src/fluent/db_context.dart';
import 'package:az_fluent_sqflite/src/fluent/db_select.dart';
import 'package:sqflite/sqflite.dart';

class DbSet<T extends ModelBase, U extends FilterBase<T>> {
  DbContext _dbContext;
  ModelBase _instance;
  FilterBase<T> _filter;
  
  DbSet({DbContext dbContext, T modelInstance, U filterInstance}) {
    this._dbContext = dbContext;
    this._instance = modelInstance;
    this._filter = filterInstance;
  }

  Future<T> insert(T model) async {
    if (model == null) return null;
    ModelBase mdl = model;
    Transaction transaction = _dbContext.transaction;
    TableMapper tableMapper = mdl.toRow();
    int result = 0;
    if (transaction == null)
    {
      Database db = await _dbContext.database;
      result = await db.insert(tableMapper.tableName, tableMapper.toFieldValue());
    }
    else
    {
      result = await transaction.insert(tableMapper.tableName, tableMapper.toFieldValue());
    }
    if (result == 0) return null;
    if (tableMapper.isPrimaryKeyAutoGenerate) 
    {
      mdl.setInsertedId(result);
    }

    return mdl;
  }

  Future<bool> update(T model, dynamic id) async {
    if (model == null || id == null) return false;
    ModelBase mdl = model;
    TableMapper tableMapper = mdl.toRow();
    FieldMapper primaryField = tableMapper.primaryField;
    int result = 0;
    
    Transaction transaction = _dbContext.transaction;
    if (transaction == null) {
      Database db = await _dbContext.database;
      result = await db.update(tableMapper.tableName, tableMapper.toFieldValue(), where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    } 
    else 
    {
      result = await transaction.update(tableMapper.tableName, tableMapper.toFieldValue(), where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    } 
    return result > 0;
  }

  Future<bool> delete(dynamic id) async
  {
    if (id == null) return false;
    TableMapper tableMapper = _instance.toRow();
    FieldMapper primaryField = tableMapper.primaryField;
    int result = 0;
    
    Transaction transaction = _dbContext.transaction;
    if (transaction == null) {
      Database db = await _dbContext.database;
      result = await db.delete(tableMapper.tableName, where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    } 
    else 
    {
      result = await transaction.delete(tableMapper.tableName, where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    }
    return result > 0;
  }

  Future<T> find(dynamic id) async {
    if (id == null) return null;
    TableMapper tableMapper = _instance.toRow();
    FieldMapper primaryField = tableMapper.primaryField;
    Transaction transaction = _dbContext.transaction;
    List<Map<String, dynamic>> list;
    if (transaction == null) {
      Database db = await _dbContext.database;
      list = await db.query(tableMapper.tableName, where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    } 
    else 
    {
      list = await transaction.query(tableMapper.tableName, where: "${primaryField.fieldName} = ?", whereArgs: [id]);
    }
    if (list == null || list.length == 0) return null;

    ModelBase result = _instance.defaultInstance();
    TableMapper resultMapper = result.rowToObject(list[0]);
    return result.toObject(resultMapper.fieldMap);
  }

  DbSelect<T, U> select() {
    return new DbSelect(dbContext: this._dbContext, modelInstance: this._instance, filterInstance: this._filter);
  }

  String createTableDefinition() {
    TableMapper mapper = this._instance.toRow();
    List<String> fields = new List<String>();
    for (int i = 0; i < mapper.fields.length; i++) {
      FieldMapper fieldMapper = mapper.fields[i];
      if (fieldMapper.isPrimaryKey) {
        if (fieldMapper.isAutoGenerate && fieldMapper.fieldType == FieldType.Int) {
          fields.add("${fieldMapper.fieldName} ${fieldMapper.fieldTypeString} PRIMARY KEY AUTOINCREMENT");  
        }
        else {
          fields.add("${fieldMapper.fieldName} ${fieldMapper.fieldTypeString} PRIMARY KEY");
        }
      }
      else {
        fields.add("${fieldMapper.fieldName} ${fieldMapper.fieldTypeString}");
      }
    }

    return "CREATE TABLE ${mapper.tableName} (${fields.join(" , ")})";
  }
}