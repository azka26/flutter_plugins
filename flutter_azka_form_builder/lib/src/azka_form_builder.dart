import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_option.dart';
import 'dart:async';
import 'package:intl/intl.dart';

typedef OnChanged = void Function();
typedef OnWillPop = Future<bool> Function();

class AzkaFormBuilder extends StatefulWidget {
  final Widget child;
  final bool autovalidate;
  final OnChanged onChanged;
  final OnWillPop onWillPop;
  
  AzkaFormBuilder({
    Key key
    , this.child
    , this.autovalidate = false
    , this.onChanged
    , this.onWillPop
  }) : super(key: key);

  static AzkaFormBuilderState of(BuildContext context) => context.findAncestorStateOfType<AzkaFormBuilderState>();

  @override
  AzkaFormBuilderState createState() => AzkaFormBuilderState();
}

class AzkaFormBuilderState extends State<AzkaFormBuilder> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  Map<String, GlobalKey<FormFieldState>> _fields = new Map<String, GlobalKey<FormFieldState>>();

  void addField(String key, GlobalKey<FormFieldState> value) {
    this._fields.putIfAbsent(key, () => value);
    this._fields[key] = value;
  }

  void removeField(String key) {
    this._fields.remove(key);
  }

  void reset() {
    this._formState.currentState.reset();
  }

  Map<String, dynamic> _value = new Map<String, dynamic>();
  Map<String, dynamic> get value => this._value;

  String toJson() {
    return jsonEncode(this._value);
  }

  void save() 
  {
    this._formState.currentState.save();
    this._saveValue();
  }

  void _setValue(Map<String, dynamic> map, String key, dynamic value) {
    if (value is FormBuilderOption) 
    {
      map.putIfAbsent(key, () => value.toFormValue());
    } 
    else if (value is DateTime) {
      DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
      map.putIfAbsent(key, () => formatter.format(value));
    }
    else 
    {
      map.putIfAbsent(key, () => value);
    }
  }

  void _saveValue() {
    _value = new Map<String, dynamic>();
    if (this._fields != null) {
      _fields.forEach((key, value) {
        if (key.contains(".")) 
        {
          List<String> split = key.split(".");
          _mapToChildElement(split, 0, _value, value.currentState.value);
        } 
        else 
        {
          _setValue(_value, key, value.currentState.value);
        }
      });
    }
  }

  void _mapToChildElement(List<String> list, int depth, Map<String, dynamic> parent, dynamic valueToAssign) {
    if (depth >= list.length) return;
    String key = list[depth];
    if (key.contains("[") && key.contains("]")) 
    {
      // LIST HANDLER
      List<String> split = key.split("[");
      split[1] = split[1].replaceAll("]", "");
      int index = int.parse(split[1]);
      String property = split[0];
      if (!parent.containsKey(property)) {
        parent.putIfAbsent(property, () => new List<Map<String, dynamic>>());
      }
      List<Map<String, dynamic>> children = parent[property] as List<Map<String, dynamic>>;
      if (children.length <= index) {
        children.add(new Map<String, dynamic>()); 
      }
      _mapToChildElement(list, depth + 1, children[index], valueToAssign);
    } 
    else 
    {
      if ((list.length - 1) == depth) {
        _setValue(parent, key, valueToAssign);
      }
      else 
      {
        Map<String, dynamic> child = new Map<String, dynamic>();
        if (parent.containsKey(key)) {
          child = parent[key] as Map<String, dynamic>; 
        }

        parent.putIfAbsent(key, () => child);
        _mapToChildElement(list, depth + 1, child, valueToAssign);
      }
    }
  }

  bool validate() 
  {
    return this._formState.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: widget.child,
      autovalidate: widget.autovalidate,
      onChanged: widget.onChanged,
      onWillPop: widget.onWillPop
    );
  }
}