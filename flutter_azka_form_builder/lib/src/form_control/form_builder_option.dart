import 'package:flutter/cupertino.dart';

class FormBuilderOption extends StatelessWidget {
  final String id;
  final String label;
  final dynamic value;
  final Widget child;

  Map<String, dynamic> toFormValue() {
    Map<String, dynamic> map = {
      "value": this.id,
      "label": this.label
    };
    return map;
  }

  FormBuilderOption({ @required this.id, @required this.label, this.value, this.child });

  @override
  Widget build(BuildContext context) {
    if (this.child != null) {
      return this.child;
    }
    // TODO: implement build
    return Text(this.label);
  }
}