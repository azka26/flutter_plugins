import 'package:flutter/material.dart';
import 'dart:async';

typedef OnChanged = void Function();
typedef OnWillPop = Future<bool> Function();

class AzkaFormBuilder extends StatefulWidget {
  final Widget child;
  final bool autovalidate;
  final OnChanged onChanged;
  final OnWillPop onWillPop;
  // final Map<String, dynamic> initialValue;

  AzkaFormBuilder({
    Key key
    , this.child
    , this.autovalidate = false
    , this.onChanged
    , this.onWillPop
    // , this.initialValue 
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

  // dynamic getInitialValue(String id) {
  //   if (widget.initialValue == null) return null;
  //   if (id.contains(".")) {
  //     // SUB OBJECT
  //     List<String> split = id.split(".");
  //     return _getInitialSubValue(split, 0, widget.initialValue);
  //   }
  //   return widget.initialValue[id];
  // }

  // dynamic _getInitialSubValue(List<String> list, int depth, Map<String, dynamic> parent) {
  //   if (depth >= list.length) return null;
  //   if (parent == null) return null;

  //   String property = list[depth];
  //   if (property.contains("[") && property.contains("]")) {
  //     // LIST
  //     List<String> listProperty = property.split("[");
  //     String propertyName = listProperty[0];
  //     int index = int.parse(listProperty[1].replaceAll("]", ""));

  //     if (!parent.containsKey(propertyName)) {
  //       return null;
  //     }

  //     if (!(parent[propertyName] is List)) {
  //       return null;
  //     }

  //     List<Map<String, dynamic>> listMap = parent[propertyName] as List<Map<String, dynamic>>;
  //     if (listMap == null) return null;
  //     if (index >= list.length) return null;
  //     return _getInitialSubValue(list, depth + 1, listMap[index]);
  //   }
  //   else 
  //   {
  //     // OBJECT 
  //     if (!parent.containsKey(property)) {
  //       return null;
  //     }

  //     if (parent[property] is Map<String, dynamic>) {
  //       return _getInitialSubValue(list, depth + 1, parent[property]);
  //     }

  //     return parent[property];
  //   }
  //   return null;
  // }

  void save() 
  {
    this._formState.currentState.save();
    this._saveValue();
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
          _value.putIfAbsent(key, () => value.currentState.value);
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
        parent.putIfAbsent(key, () => valueToAssign);
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