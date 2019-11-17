import 'package:sqlitetransaction/sqflite_custom/sqflite_custom.dart';
import 'package:sqlitetransaction/sqflite_custom/table_definition.dart';

class Structure {
  static List<TableDefinition> getDefinition() {
    return [
      TableDefinition.create(tableName: "province", fields: {
        "id": FieldDefinition.create(type: FieldType.INTEGER, isPrimary: true),
        "name": FieldDefinition.create(type: FieldType.TEXT)
      }),
      TableDefinition.create(tableName: "city", fields: {
        "id": FieldDefinition.create(type: FieldType.INTEGER, isPrimary: true),
        "name": FieldDefinition.create(type: FieldType.TEXT),
        "province_id": FieldDefinition.create(type: FieldType.TEXT)
      })
    ];
  }
}
