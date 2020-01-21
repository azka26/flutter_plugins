import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';

class FormBuilderCheckbox extends StatefulWidget {
  final String id;
  final bool value;
  final ValueChanged<bool> onChanged;
  final InputDecoration decoration;
  final bool readOnly;
  final Widget label;
  final List<FormFieldValidator<String>> validators;

  FormBuilderCheckbox({
    Key key
    , @required this.id
    , @required this.label
    , this.value = false
    , this.onChanged
    , this.decoration = const InputDecoration()
    , this.readOnly = false
    , this.validators
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

  void onChange(BuildContext context, FormFieldState<bool> field) {
    bool newValue = !(field.value ?? false);
    field.didChange(newValue);
    if (widget.onChanged != null) {
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formFieldState,
      initialValue: widget.value,
      validator: (val) {
        if (widget.validators == null || widget.validators.length == 0) return null;
        for (int i = 0; i < widget.validators.length; i++) {
          String result = widget.validators[i](val);
          if (result != null) {
            return result;
          }
        }
        return null;
      },
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !widget.readOnly,
            errorText: field.errorText
          ),
          child: ListTile(
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.all(0.0),
            title: widget.label,
            trailing: Checkbox(
              value: field.value,
              onChanged: widget.readOnly ? null : (value) {
                FocusScope.of(context).requestFocus(FocusNode());
                field.didChange(value);
                if (widget.onChanged != null) widget.onChanged(value);
              },
            ),
            onTap: widget.readOnly ? null : () {
              FocusScope.of(context).requestFocus(FocusNode());
              bool newValue = !(field.value ?? false);
              field.didChange(newValue);
              if (widget.onChanged != null) widget.onChanged(newValue);
            },
          ),
        );
        // GestureDetector(
        //   child: Container(
        //     child: Text(field.value ? "TRUE" : "FALSE"),
        //   ),
        //   onTap: () {
        //     bool newValue = !(field.value ?? false);
        //     field.didChange(newValue);
        //   },
        // );
      },      
    );
  }
}