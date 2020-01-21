import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';
import 'package:flutter_azka_form_builder/src/form_control/form_builder_option.dart';



class FormBuilderRadio extends StatefulWidget {
  final String id;
  final bool readOnly;
  final InputDecoration decoration;
  final List<FormBuilderOption> options;
  final FormBuilderOption selectedValue;
  final ValueChanged<FormBuilderOption> onChanged;
  FormBuilderRadio({ 
    Key key
    , @required this.id
    , @required this.options
    , this.selectedValue
    , this.readOnly = false
    , this.decoration = const InputDecoration() 
    , this.onChanged 
  }) : super(key: key);
  @override
  _FormBuilderRadioState createState() => _FormBuilderRadioState();
}

class _FormBuilderRadioState extends State<FormBuilderRadio> {
  GlobalKey<FormFieldState> _formFieldState = GlobalKey<FormFieldState>();
  AzkaFormBuilderState _azkaFormBuilderState;

  @override
  void initState() {
    _azkaFormBuilderState = AzkaFormBuilder.of(context);
    if (_azkaFormBuilderState != null) {
      _azkaFormBuilderState.addField(widget.id, _formFieldState);
    }
    // TODO: implement initState
    super.initState();
  } 

  @override
  void dispose() {
    // TODO: implement dispose
    if (_azkaFormBuilderState != null) {
      _azkaFormBuilderState.removeField(widget.id);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      key: _formFieldState,
      enabled: !(widget.readOnly??false),
      initialValue: widget.selectedValue,
      builder: (FormFieldState<FormBuilderOption> field) {
        List<Widget> radioList = new List<Widget>();
        widget.options.forEach((el) {
          FormBuilderOption selected;
          if (field.value != null && field.value.id == el.id) {
            selected = el;
          }
          
          radioList.add(
            ListTile(
              dense: true,
              isThreeLine: false,
              contentPadding: EdgeInsets.all(0),
              title: el,
              trailing: Radio(
                value: el,
                groupValue: selected,
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  field.didChange(value);
                  if (widget.onChanged != null) widget.onChanged(value);
                },
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                dynamic value = el;
                field.didChange(value);
                if (widget.onChanged != null) widget.onChanged(value);
              },
            )
          );
        });

        return InputDecorator(
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readOnly??false),
            errorText: field.errorText,
            border: InputBorder.none
          ),
          child: Column(
            children: radioList,
          ),
        );
      },
    );
  }
}