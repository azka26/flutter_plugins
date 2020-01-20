import 'package:flutter/material.dart';
import 'package:flutter_azka_form_builder/src/azka_form_builder.dart';

class FormBuilderTextField extends StatefulWidget {
  final String id;
  final InputDecoration decoration;
  final List<FormFieldValidator<String>> validators;
  final String value;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final bool enabled;
  final int maxLength;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final bool autocorrect;
  final bool autofocus;
  final bool autovalidate;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;

  FormBuilderTextField({
    Key key
    , @required this.id
    , this.maxLines = 1
    , this.minLines = 1
    , this.decoration
    , this.validators
    , this.value
    , this.onChanged
    , this.readOnly = false
    , this.enabled = true
    , this.maxLength
    , this.obscureText = false
    , this.onSaved
    , this.keyboardType
    , this.autocorrect = false
    , this.autofocus = false
    , this.autovalidate = false
    , this.textAlign = TextAlign.start
    , this.textAlignVertical
  }) : super(key: key);

  @override
  FormBuilderTextFieldState createState() => FormBuilderTextFieldState();
}

class FormBuilderTextFieldState extends State<FormBuilderTextField> {
  TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormFieldState> _formFieldState = GlobalKey<FormFieldState>();
  AzkaFormBuilderState _formState;
  
  @override
  void initState() {
    // TODO: implement initState
    _formState = AzkaFormBuilder.of(context);
    if (_formState != null) {
      _formState.addField(widget.id, _formFieldState);
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_formState != null) 
    {
      _formState.removeField(widget.id);
    }

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != _controller.text) 
    {
      _controller = new TextEditingController();
      _controller.text = widget.value ?? "";
    }

    return TextFormField(
      key: _formFieldState,
      controller: _controller,
      decoration: widget.decoration,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      autovalidate: widget.autovalidate,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
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
      onChanged: widget.onChanged,
    );
  }
}