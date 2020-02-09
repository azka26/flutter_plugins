import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';

class Student extends ModelBase {
  int _id;
  String _nisn;
  String _name;
  DateTime _birthDate;
  int _height;
  int _weight;

  int get id => this._id;
  set id(int value) => this._id = value;

  String get nisn => this._nisn;
  set nisn(String value) => this._nisn = value;

  String get name => this._name;
  set name(String value) => this._name = value;

  DateTime get birthDate => this._birthDate;
  set birthDate(DateTime value) => this._birthDate = value;

  int get height => this._height;
  set height(int value) => this._height = value;

  int get weight => this._weight;
  set weight(int value) => this._weight = value;

  @override
  ModelBase defaultInstance() {
    // TODO: implement defaultInstance
    return new Student();
  }

  @override
  ModelBase toObject(Map<String, FieldMapper> map) {
    Student student = new Student();
    student.id = map["student_id"].objectValue;
    student.nisn = map["student_nisn"].objectValue;
    student.name = map["student_name"].objectValue;
    student.birthDate = map["student_birth_date"].objectValue;
    student.height = map["student_height"].objectValue;
    student.weight = map["student_weight"].objectValue;
    return student;
  }

  @override
  TableMapper toRow() {
    return TableMapper(
      tableName: "student_table",
      fields: [
        new FieldMapper(fieldName: "student_id", fieldType: FieldType.Int, isAutoGenerate: true, isPrimaryKey: true, value: this.id),
        new FieldMapper(fieldName: "student_nisn", fieldType: FieldType.Text, value: this.nisn),
        new FieldMapper(fieldName: "student_name", fieldType: FieldType.Text, value: this.name),
        new FieldMapper(fieldName: "student_birth_date", fieldType: FieldType.DateTime, value: this.birthDate),
        new FieldMapper(fieldName: "student_height", fieldType: FieldType.Int, value: this.height),
        new FieldMapper(fieldName: "student_weight", fieldType: FieldType.Int, value: this.weight)
      ]
    );
  }
  
}