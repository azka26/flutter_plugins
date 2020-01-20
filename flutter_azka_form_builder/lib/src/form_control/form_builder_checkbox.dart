import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';

class FormBuilderCheckbox extends StatefulWidget {
  final String id;
  final bool value;
  final ValueChanged<bool> onChanged;
  final InputDecoration decoration;

  FormBuilderCheckbox({
    Key key
    , @required this.id
    , this.value = false
    , this.onChanged
    , this.decoration
  }) : super(key: key);

  @override
  _FormBuilderCheckboxState createState() => _FormBuilderCheckboxState();
}

class _FormBuilderCheckboxState extends State<FormBuilderCheckbox> {
  final GlobalKey<FormFieldState> _formFieldState = GlobalKey<FormFieldState>();
  AzkaFormBuilderState _formState;

  @override
  void initState() {
    _formState = AzkaFormBuilder.of(context);
    if (_formState != null) {
      this._formState.addField(widget.id, _formFieldState);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (_formState != null) {
      _formState.removeField(widget.id);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formFieldState,
      initialValue: widget.value,
      builder: (FormFieldState<bool> field) {
        return GestureDetector(
          child: Container(
            child: Text(field.value ? "TRUE" : "FALSE"),
          ),
          onTap: () {
            bool newValue = !(field.value ?? false);
            field.didChange(newValue);
          },
        );
      },      
    );
  }
}