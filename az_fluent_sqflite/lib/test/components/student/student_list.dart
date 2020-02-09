import 'package:az_fluent_sqflite/src/fluent/db_select.dart';
import 'package:az_fluent_sqflite/test/components/student/student_form.dart';
import 'package:az_fluent_sqflite/test/db_context_school.dart';
import 'package:az_fluent_sqflite/test/filters/student_filter.dart';
import 'package:az_fluent_sqflite/test/models/student.dart';
import 'package:az_fluent_sqflite/src/filter/filter_extension.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  DbContextSchool _contextSchool = new DbContextSchool();
  List<Student> _model = new List<Student>();
  String _filterName = "";

  @override
  void initState() {
    super.initState();
    this.loadStudent();
  }

  Future<void> loadStudent() async {
    DbSelect<Student, StudentFilter> select = _contextSchool.students.select();
    List<Student> list;
    if (_filterName != "") {
      list =
          await select.where((filter) => filter.name.fieldEquals(_filterName)).orWhere((filter) => filter.nisn.fieldLike(_filterName)).toList();
    } else {
      list = await select.toList();
      select.toList();
    }

    if (list == null) {
      list = new List<Student>();
    }
    this.setState(() {
      _model = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this._model.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                MaterialButton(
                  child: Text("Add"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new StudentForm(
                              onReload: () {
                                this.loadStudent();
                              },
                            )));
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Filter Name"),
                  onChanged: (value) async {
                    this._filterName = value;
                    await this.loadStudent();
                  },
                )
              ],
            );
          }
          Student student = _model[index - 1];
          return Card(
            child: Column(
              children: <Widget>[
                MaterialButton(
                  child: Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete Confirmation"),
                            content: Text("Delete item?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () async {
                                  await this
                                      ._contextSchool
                                      .students
                                      .delete(student.id);
                                  await this.loadStudent();
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentForm(
                              onReload: () {
                                loadStudent();
                              },
                              studentId: student.id,
                            )));
                  },
                  title: Text(student.name ?? ""),
                  subtitle: Text(student.nisn ?? ""),
                )
              ],
            ),
          );
        });
  }
}
