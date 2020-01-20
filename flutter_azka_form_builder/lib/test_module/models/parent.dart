import 'package:flutter_azka_form_builder/test_module/models/child.dart';

class Parent {
  String _id;
  String _name;
  bool _isActive;
  List<Child> _children;

  String get id => this._id;
  set id(String val) => this._id = val;

  String get name => this._name;
  set name(String val) => this._name = val;

  bool get isActive => this._isActive;
  set isActive(bool val) => this._isActive = val;

  List<Child> get children {
    if (_children == null) _children = new List<Child>();
    return _children;
  }
  set children(List<Child> val) => this._children = val;

  Parent.create(Map<String, dynamic> map) {
    if (map == null) return;
    this.id = map["id"];
    this.name = map["name"];
    this.isActive = map["isActive"];
    if (map["children"] != null) {
      List<Map<String, dynamic>> list = map["children"] as List<Map<String, dynamic>>;
      for (int i = 0; i < list.length; i++) {
        Child child = Child.create(list[i]);
        children.add(child);
      }
    }
  }
}