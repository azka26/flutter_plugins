import 'dart:math';

import 'package:flutter/material.dart';

typedef OnBackCallbackFunction = void Function(String val);

class TestForm extends StatefulWidget {
  final OnBackCallbackFunction onBack;
  TestForm({ Key key, this.onBack }) : super(key: key);

  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { 
        Random rand = new Random();
        this.widget.onBack("TEST_RANDOM_" + rand.nextInt(100).toString()); 
        return Future.value(true);
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text("TEST"),
      ),
    ),) ;
  }
}