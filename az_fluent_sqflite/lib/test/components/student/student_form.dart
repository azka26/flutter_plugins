import 'package:az_fluent_sqflite/test/models/student.dart';
import 'package:az_fluent_sqflite/test/services/student_service.dart';
import 'package:flutter/material.dart';

typedef OnReload = Function();

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();

  final OnReload onReload;
  final int studentId;

  StudentForm({Key key, this.onReload, this.studentId}) : super(key: key);
}

class _StudentFormState extends State<StudentForm> {
  StudentService _studentService = new StudentService();
  Student _model = new Student();
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Student Form"),
      ),
      body: Form(
        key: _formState,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) {
                  if (val == null || val == "") return "NISN is required.";
                  return null;
                },
                decoration: InputDecoration(labelText: "NISN"),
                onSaved: (value) {
                  this._model.nisn = value;
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val == null || val == "") return "Name is required.";
                  return null;
                },
                decoration: InputDecoration(labelText: "Name"),
                onSaved: (value) {
                  this._model.name = value;
                },
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
          child: Text("Save"),
          onPressed: () async {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              if (widget.studentId == null) {
                _studentService.insert(_model).then((result) {
                  if (result != null) {
                    widget.onReload();
                    Navigator.of(context).pop();
                  }
                });
              } else {
                _studentService.update(_model, this.widget.studentId).then((result) {
                  if (result) {
                    widget.onReload();
                    Navigator.of(context).pop();
                  }
                });
              }
            }
          },
        ),
        MaterialButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
