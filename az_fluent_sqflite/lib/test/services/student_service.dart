import 'package:az_fluent_sqflite/test/db_context_school.dart';
import 'package:az_fluent_sqflite/test/models/student.dart';

class StudentService {
  DbContextSchool _school = new DbContextSchool();

  Future<Student> insert(Student student) async {
    Student result;
    await _school.usingTransaction(() async {
      result = await _school.students.insert(student);
      if (result == null) return false;
      return true;
    });
    if (result != null) {
      return result;
    }
    return null;
  }

  Future<bool> update(Student student, int id) async {
    student.id = id;
    return await _school.usingTransaction(() async {
      return await _school.students.update(student, id);
    });
  }

  Future<bool> delete(int id) async {
    return await _school.usingTransaction(() async {
      return await _school.students.delete(id);
    });
  }
}