import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/flutter_azka_form_builder.dart';

class FormBuilderDropdown extends StatefulWidget {
  final String id;
  final InputDecoration decoration;
  final bool readOnly;
  final List<FormBuilderOption> options;
  final FormBuilderOption selectedValue;
  final ValueChanged<FormBuilderOption> onChanged;

  FormBuilderDropdown({
    Key key
    , @required this.id
    , @required this.options
    , this.decoration = const InputDecoration()
    , this.readOnly
    , this.selectedValue
    , this.onChanged
  }) : super(key: key);

  @override
  _FormBuilderDropdownState createState() => _FormBuilderDropdownState();
}

class _FormBuilderDropdownState extends State<FormBuilderDropdown> {
  GlobalKey<FormFieldState> _formFieldState = GlobalKey<FormFieldState>();
  AzkaFormBuilderState _formState;

  @override
  void initState() {
    _formState = AzkaFormBuilder.of(context);
    if (_formState != null) {
      _formState.addField(this.widget.id, _formFieldState);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if (_formState != null) {
      _formState.removeField(this.widget.id);
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FormBuilderOption selectedOptions;
    if (widget.selectedValue != null) {
      for (int i = 0; i < widget.options.length; i++) {
        FormBuilderOption item = widget.options[i];
        if (item.id == widget.selectedValue.id) {
          selectedOptions = item; 
        }
      }
    }

    return FormField(
      key: _formFieldState,
      builder: (FormFieldState<FormBuilderOption> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: widget.readOnly,
            errorText: field.errorText,
            contentPadding: EdgeInsets.only(top: 10.0),
            border: InputBorder.none
          ),
          child: DropdownButton(
            isExpanded: true,
            items: widget.options.map((val) => DropdownMenuItem(child: val, value: val,)).toList(),
            onChanged: (value) {
              field.didChange(value);
              if (widget.onChanged != null) {
                widget.onChanged(value);
              }
            },
            value: selectedOptions,
          ),
        );
      },   
    );
  }
}