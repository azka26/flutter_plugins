import 'dart:async';

import 'package:az_fluent_sqflite/src/az_fluent_sqflite.dart';
import 'package:az_fluent_sqflite/test/filters/student_filter.dart';
import 'package:az_fluent_sqflite/test/models/student.dart';
import 'package:sqflite/sqlite_api.dart';

class DbContextSchool extends DbContext {
  DbSet<Student, StudentFilter> students;
  DbContextSchool() : super() 
  {
    this.dbName = "student.db";
    this.dbVersion = 1;
    Student student = new Student();
    this.students = new DbSet(dbContext: this, modelInstance: student, filterInstance: new StudentFilter(student));  
  }

  @override
  FutureOr<void> onConfigure(Database db) {
    // TODO: implement onConfigure
    return null;
  }

  @override
  FutureOr<void> onCreate(Database db, int version) {
    if (version == 1) 
    {
      db.execute(students.createTableDefinition());
    }
    return null;
  }

  @override
  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion) {
    // TODO: implement onDowngrade
    return null;
  }

  @override
  FutureOr<void> onOpen(Database db) {
    // TODO: implement onOpen
    return null;
  }

  @override
  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    return null;
  }
}