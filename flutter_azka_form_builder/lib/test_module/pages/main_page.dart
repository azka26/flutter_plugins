import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_checkbox.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_date_time_picker.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_dropdown.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_radio.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_option.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_text_field.dart';
import 'package:flutter_azka_form_builder/src/form_validator/form_input_validator.dart';
import 'package:flutter_azka_form_builder/test_module/models/child.dart';
import 'package:flutter_azka_form_builder/test_module/models/child_option.dart';
import 'package:flutter_azka_form_builder/test_module/models/parent.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<AzkaFormBuilderState> _formState = GlobalKey<AzkaFormBuilderState>();
  Parent parent;

  @override
  void initState() {
    parent = Parent.create({
      "id": "",
      "name": "",
      "isActive": false,
      "children": [
        {"id": "", "name": ""}
      ]
    });

    parent.dateValue = DateTime.now().add(Duration(days: 10));

    parent.selectedOption1 = new ChildOption.create({"id": "child_1"});
    super.initState();
  }

  @override
  void dispose() {
    parent = null;
    super.dispose();
  }

  List<Widget> _buildDetails(BuildContext context) {
    List<Widget> list = new List<Widget>();
    if (parent == null || parent.children == null || parent.children.length == 0) return list;
    for (int i = 0; i < parent.children.length; i++) {
      int rowIndex = i;
      Widget row = Padding(
        padding: EdgeInsets.only(top: 5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(3))
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text("REMOVE"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      this.setState(() {
                        parent.children.removeAt(rowIndex);
                      });
                    },
                  ),
                ],
              ),
              Text((parent.children[i].id?? "") + "::" + (parent.children[i].name?? "")),
              new FormBuilderTextField(
                id: "details[${i.toString()}].id",
                decoration: InputDecoration(labelText: "Detail Id [${i.toString()}]"),
                validators: [
                  FormInputValidator.required(errorText: "Detail Id ${i.toString()} is required.")
                ],
                value: parent.children[i].id,
                onChanged: (val) => this.setState(() { parent.children[i].id = val; }),
              ),
              new FormBuilderTextField(
                id: "details[${i.toString()}].name",
                decoration: InputDecoration(labelText: "Detail Name [${i.toString()}]"),
                value: parent.children[i].name,
                onChanged: (val) => this.setState(() { parent.children[i].name = val; }),
              ),
            ],
          ),
        ),
      );
      list.add(row);
    }
    return list;
  }

  String jsonValue = "";

  @override
  Widget build(BuildContext context) {
    List<ChildOption> listChildOptions = [
      ChildOption.create({"id": "child_1", "name": "Child 1"}),
      ChildOption.create({"id": "child_2", "name": "Child 2"}),
      ChildOption.create({"id": "child_3", "name": "Child 3"})
    ];

    List<Map<String, dynamic>> list = new List<Map<String, dynamic>>();
    for (int i = 0; i < parent.children.length; i++) {
      list.add({"id": parent.children[i].id, "name": parent.children[i].name});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("App Bar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          child: AzkaFormBuilder(
            autovalidate: true,
            key: _formState,
            child: Column(
              children: <Widget>[
                Text(jsonValue),
                FormBuilderDateTimePicker(
                  id: "my_date",
                  decoration: InputDecoration(
                    labelText: "TEST"
                  ),
                  inputType: InputType.datetime,
                  value: parent.dateValue,
                  onChanged: (val) => this.setState(() => parent.dateValue = val),
                ),
                FormBuilderTextField(
                  id: "id",
                  decoration: InputDecoration(labelText: "Id Property"),
                  value: parent.id,
                  onChanged: (val) => this.setState(() { parent.id = val; }),
                  obscureText: true,
                  maxLength: 16,
                ),
                FormBuilderCheckbox(
                  id: "isActive",
                  label: Text("Is Active"),
                  value: parent.isActive,
                  onChanged: (val) => this.setState(() {parent.isActive = val;}) ,
                ),
                FormBuilderTextField(
                  id: "name",
                  decoration: InputDecoration(labelText: "Name Property"),
                  value: parent.name,
                  onChanged: (val) => this.setState(() { parent.name = val; }) ,
                  maxLength: 10,
                ),
                FormBuilderRadio(
                  id: "myRadio",
                  selectedValue: FormBuilderOption(id: parent.selectedOption1?.id, label: parent.selectedOption1?.name, value: parent.selectedOption1),
                  options: listChildOptions.map((val) => FormBuilderOption(id: val.id, label: val.name, value: val)).toList(),
                  onChanged: (val) => this.setState(() { parent.selectedOption1 = val.value; })
                ),
                FormBuilderRadio(
                  decoration: InputDecoration(
                    labelText: "Radio Input"
                  ),
                  id: "myRadio2",
                  selectedValue: FormBuilderOption(id: parent.selectedOption2?.id, label: parent.selectedOption2?.name, value: parent.selectedOption2),
                  options: listChildOptions.map((val) => FormBuilderOption(id: val.id, label: val.name, value: val)).toList(),
                  onChanged: (val) => this.setState(() { parent.selectedOption2 = val.value; })
                ),
                FormBuilderDropdown(
                  decoration: InputDecoration(
                    labelText: "Combo Input"
                  ),
                  id: "myCombo",
                  selectedValue: FormBuilderOption(id: parent.selectedOption3?.id, label: parent.selectedOption3?.name, value: parent.selectedOption3),
                  options: listChildOptions.map((val) => FormBuilderOption(id: val.id, label: val.name, value: val)).toList(),
                  onChanged: (val) => this.setState(() { parent.selectedOption3 = val.value; })
                ),
                
                // CHILD
                ..._buildDetails(context)
              ],
            ),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text("Reset"),
          onPressed: () {
            this.setState(() {
              this._formState.currentState.reset();
            });
          },
        ),
        FlatButton(
          child: Text("Add Row"),
          onPressed: () {
            this.setState(() {
              this.parent.children.add(Child.create(null));
            });
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              print(_formState.currentState.value);
              this.setState(() {
                jsonValue = _formState.currentState.toJson();
              });
            }
          },
        )
      ],
    );
  }
}
