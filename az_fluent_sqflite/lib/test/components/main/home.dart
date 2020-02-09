import 'package:az_fluent_sqflite/test/components/student/student_form.dart';
import 'package:az_fluent_sqflite/test/components/student/student_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  Widget homePage() {
    return Text("Home");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      this.homePage(),
      new StudentList()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Demo SQFLite"),
      ),
      body: pages[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index) {
          this.setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Student"))
        ]
      ),
    );
  }
}