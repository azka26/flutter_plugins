import 'package:flutter_azka_form_builder/test_module/models/child.dart';
import 'package:flutter_azka_form_builder/test_module/models/child_option.dart';

class Parent {
  String _inputText;
  String _inputMultiline;
  DateTime _inputDate;
  DateTime _inputDateTime;
  DateTime _inputTime;
  bool _inputCheckbox;
  ChildOption _inputRadio;
  List<Child> _children;

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

  set children(List<Child> val) => this._children = val;
  List<Child> get children {
    if (this._children == null) _children = new List<Child>();
    return this._children;
  }

  Parent.create(Map<String, dynamic> map) {
    if (map == null) return;
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
    
    if (map.containsKey("children") && map["children"] is List) {
      List list = map["children"] as List;
      if (list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          this.children.add(Child.create(list[i]));
        }
      }
    }
  }
}