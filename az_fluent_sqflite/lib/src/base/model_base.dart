import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';
import 'package:az_fluent_sqflite/src/orm/table_mapper.dart';

abstract class ModelBase 
{
  void setInsertedId(int value) {
    
  }

  ModelBase defaultInstance();
  ModelBase toObject(Map<String, FieldMapper> map);
  TableMapper toRow();
  TableMapper rowToObject(Map<String, dynamic> map) 
  {
    TableMapper tableMap = this.toRow();
    tableMap.fields.forEach((item) => item.value = null);
    map.forEach((key, value) {
      tableMap.fieldMap[key].value = value;
    });
    return tableMap;
  }
}