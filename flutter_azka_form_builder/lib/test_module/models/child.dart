import 'package:flutter_azka_form_builder/test_module/models/child_option.dart';

class Child {
  String _inputText;
  String _inputMultiline;
  DateTime _inputDate;
  DateTime _inputDateTime;
  DateTime _inputTime;
  ChildOption _inputRadio;
  bool _inputCheckbox;

  set inputText(String val) => this._inputText = val;
  String get inputText => this._inputText;

  set inputMultiline(String val) => this._inputMultiline = val;
  String get inputMultiline => this._inputMultiline;

  set inputDate(DateTime val) => this._inputDate = val;
  DateTime get inputDate => this._inputDate;

  set inputDateTime(DateTime val) => this._inputDateTime = val;
  DateTime get inputDateTime => this._inputDateTime;

  set inputTime(DateTime val) => this._inputTime = val;
  DateTime get inputTime => this._inputTime;

  set inputCheckbox(bool val) => this._inputCheckbox = val;
  bool get inputCheckbox => this._inputCheckbox;

  set inputRadio(ChildOption val) => this._inputRadio = val;
  ChildOption get inputRadio => this._inputRadio;

  Child.create(Map<String, dynamic> map) {
    this.inputText = map["inputText"];
    this.inputMultiline = map["inputMultiline"];
    this.inputDate = map["inputDate"];
    this.inputDateTime = map["inputDateTime"];
    this.inputTime = map["inputTime"];
    this.inputCheckbox = map["inputCheckbox"];
    if (map.containsKey("inputRadio") && map["inputRadio"] is Map<String, dynamic>) 
    {
      this.inputRadio = ChildOption.create(map["inputRadio"]);
    }
  }
}