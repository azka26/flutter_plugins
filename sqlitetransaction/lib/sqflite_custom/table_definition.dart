import 'field_definition.dart';

class TableDefinition {
  TableDefinition();
  TableDefinition.create({String tableName, Map<String, FieldDefinition> fields}) {
    this.tableName = tableName;
    this.fields = fields;
  }
  
  String _tableName;
  String get tableName {
    return this._tableName;
  }
  set tableName(String value) {
    this._tableName = value;
  }

  Map<String, FieldDefinition> _fields = new Map<String, FieldDefinition>();
  Map<String, FieldDefinition> get fields 
  {
    return this._fields;
  }
  set fields(Map<String, FieldDefinition> value) {
    this._fields = value;
  }
}