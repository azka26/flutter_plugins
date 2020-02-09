import 'package:az_fluent_sqflite/src/base/export.dart';
import 'package:az_fluent_sqflite/test/models/student.dart';

class StudentFilter extends FilterBase<Student> {
  StudentFilter(Student instance) : super(instance);
  final String id = "student_id";
  final String nisn = "student_nisn";
  final String name = "student_name";
}