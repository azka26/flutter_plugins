import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_checkbox.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_date_time_picker.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_dropdown.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_radio.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_option.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_text_field.dart';
import 'package:flutter_azka_form_builder/src/form_layout/double_row.dart';
import 'package:flutter_azka_form_builder/src/form_layout/single_row.dart';
import 'package:flutter_azka_form_builder/src/form_validator/form_input_validator.dart';
import 'package:flutter_azka_form_builder/test_module/models/child.dart';
import 'package:flutter_azka_form_builder/test_module/models/child_option.dart';
import 'package:flutter_azka_form_builder/test_module/models/parent.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Parent model;

  @override
  void initState() {
    model = Parent.create({
      "inputText": "",
      "inputMultiline": "",
      "inputDate": null,
      "inputDateTime": null,
      "inputTime": null,
      "inputCheckbox": false,
      "inputRadio": {
        "id": "id_1",
        "name": "name_1"
      },
      "children": [
        {
          "inputText": "",
          "inputMultiline": "",
          "inputDate": null,
          "inputDateTime": null,
          "inputTime": null,
          "inputCheckbox": false,
          "inputRadio": {
            "id": "id_1",
            "name": "name_1"
          },
        },
        {
          "inputText": "",
          "inputMultiline": "",
          "inputDate": null,
          "inputDateTime": null,
          "inputTime": null,
          "inputCheckbox": false,
          "inputRadio": {
            "id": "id_2",
            "name": "name_2"
          },
        }
      ]
    });
    super.initState();
  }

  @override
  void dispose() {
    model = null;
    super.dispose();
  }

  Widget _buildDetails(BuildContext context) 
  {
    List<DataRow> listTableRow = new List<DataRow>();
    for (int i = 0; i < model.children.length; i++) {
      Child item = model.children[i];
      DataRow row = DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(
              width: 300,
              child: FormBuilderTextField(
                id: "detail[${i}].inputText",
                value: item.inputText,
                onChanged: (val) => this.setState(() => item.inputText = val),
                decoration: InputDecoration(
                  labelText: "Input Text ${i}"
                ),
              ),
            )
          ),
          DataCell(
            FormBuilderTextField(
              id: "detail[${i}].inputText",
              value: item.inputText,
              onChanged: (val) => this.setState(() => item.inputText = val),
              decoration: InputDecoration(
                labelText: "Input Text ${i}"
              ),
            )
          )
        ],
      );
      listTableRow.add(row);
    }
    
    double minWidth = 800;
    double width = MediaQuery.of(context).size.width;
    if (width < minWidth) {
      width = minWidth;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width,
        child: DataTable(
          headingRowHeight: 50,
          columns: <DataColumn>[
            DataColumn(
              label: Text("Input Text")
            ),
            DataColumn(
              label: Text("Input Date")
            )
          ],
          rows: listTableRow,
        ),
      )
    );
  }

  String jsonValue = "";

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Form Control"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            body(context),
            Divider(
              color: Colors.black87,
              thickness: 0.5,
            ),
            _buildDetails(context),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.add),
                    color: Colors.red,
                    textColor: Colors.white,
                    label: Text("Add Row"),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    EdgeInsets padding = const EdgeInsets.all(10);
    if (width > 720) {
      return DoubleRow(
        firstChildren: firstColumn(context),
        firstPadding: padding,
        secondChildren: secondColumn(context),
        secondPadding: padding,
      );
    }
    return SingleRow(
      padding: padding,
      children: <Widget>[
        ...firstColumn(context),
        ...secondColumn(context)
      ],
    );
  }

  List<Widget> firstColumn(BuildContext context) {
    List<Widget> list = new List<Widget>();
    list.addAll(
      [
        FormBuilderTextField(
          id: "inputText",
          decoration: InputDecoration(labelText: "Input Text"),
          value: model.inputText,
          onChanged: (val) => this.setState(() => model.inputText = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDate",
          inputType: InputType.date,
          decoration: InputDecoration(labelText: "Input Date"),
          value: model.inputDate,
          onChanged: (val) => this.setState(() => model.inputDate = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDateTime",
          inputType: InputType.datetime,
          decoration: InputDecoration(labelText: "Input Date Time"),
          value: model.inputDateTime,
          onChanged: (val) => this.setState(() => model.inputDateTime = val),
        ),
        FormBuilderTextField(
          id: "inputText",
          decoration: InputDecoration(labelText: "Input Text"),
          value: model.inputText,
          onChanged: (val) => this.setState(() => model.inputText = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDate",
          inputType: InputType.date,
          decoration: InputDecoration(labelText: "Input Date"),
          value: model.inputDate,
          onChanged: (val) => this.setState(() => model.inputDate = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDateTime",
          inputType: InputType.datetime,
          decoration: InputDecoration(labelText: "Input Date Time"),
          value: model.inputDateTime,
          onChanged: (val) => this.setState(() => model.inputDateTime = val),
        ),
        FormBuilderTextField(
          id: "inputText",
          decoration: InputDecoration(labelText: "Input Text"),
          value: model.inputText,
          onChanged: (val) => this.setState(() => model.inputText = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDate",
          inputType: InputType.date,
          decoration: InputDecoration(labelText: "Input Date"),
          value: model.inputDate,
          onChanged: (val) => this.setState(() => model.inputDate = val),
        ),
        FormBuilderDateTimePicker(
          id: "inputDateTime",
          inputType: InputType.datetime,
          decoration: InputDecoration(labelText: "Input Date Time"),
          value: model.inputDateTime,
          onChanged: (val) => this.setState(() => model.inputDateTime = val),
        ),
      ]
    );
    
    return list;
  }

  List<Widget> secondColumn(BuildContext context) {
    List<Widget> list = new List<Widget>();
    list.add(FormBuilderTextField(
      id: "inputMultiline",
      decoration: InputDecoration(labelText: "Input Multiline"),
      value: model.inputMultiline,
      onChanged: (val) => this.setState(() => model.inputMultiline = val),
    ));
    return list;
  }
}
