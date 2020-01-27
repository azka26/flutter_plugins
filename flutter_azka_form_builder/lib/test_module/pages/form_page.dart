import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/flutter_azka_form_builder.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page"),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext layoutContext, BoxConstraints constraint) {
            if (constraint.maxWidth > 720) {
              return _doubleRow(layoutContext, constraint);
            }
            // SINGLE COLUMN
            return _singleRow(layoutContext, constraint);
          },
        ),
      ),
    );
  }

  Widget _doubleRow(BuildContext context, BoxConstraints constraints) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: constraints.maxWidth / 2,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[..._left(context)],
              ),
            ),
            Container(
              width: constraints.maxWidth / 2,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[..._right(context)],
              ),
            ),
          ],
        ),
        Text("LEFT"),
        Text("RIGHT")
      ],
    );
  }

  Widget _singleRow(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[..._left(context), ..._right(context)],
      ),
    );
  }

  List<Widget> _left(BuildContext context) {
    return <Widget>[
      FormBuilderTextField(
        id: "id_left_1",
        decoration: InputDecoration(labelText: "L 1"),
      ),
      FormBuilderTextField(
        id: "id_left_1",
        decoration: InputDecoration(labelText: "L 2"),
      ),
    ];
  }


  String val = "";

  List<Widget> _right(BuildContext context) {
    return <Widget>[
      FormBuilderTextField(
        id: "id_left_1",
        decoration: InputDecoration(labelText: "R 1"),
        value: val,
        onChanged: (val) => this.setState(()=> this.val = val),
      ),
      FormBuilderTextField(
        id: "id_left_1",
        decoration: InputDecoration(labelText: "R 2"),
      ),
    ];
  }
}
