import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_azka_form_builder/flutter_azka_form_builder.dart';

enum InputType { date, datetime, time }

class FormBuilderDateTimePicker extends StatefulWidget {
  final String id;
  final InputDecoration decoration;
  final DateFormat dateFormat;
  final DateTime value;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onChanged;
  final bool readOnly;
  final InputType inputType;

  FormBuilderDateTimePicker({
    Key key
    , @required this.id
    , this.value
    , this.decoration = const InputDecoration()
    , this.dateFormat
    , this.firstDate
    , this.lastDate
    , this.onChanged
    , this.readOnly = false
    , this.inputType = InputType.date
  })
      : super(key: key);

  @override
  _FormBuilderDateTimePickerState createState() => _FormBuilderDateTimePickerState();
}

class _FormBuilderDateTimePickerState extends State<FormBuilderDateTimePicker> {
  GlobalKey<FormFieldState> _formFieldState = GlobalKey<FormFieldState>();
  AzkaFormBuilderState _formState;
  @override
  void initState() {
    _formState = AzkaFormBuilder.of(context);
    if (_formState != null) {
      _formState.addField(widget.id, _formFieldState);
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_formState != null) {
      _formState.removeField(widget.id);
    }
    super.dispose();
  }

  void _showDatePicker(BuildContext context, FormFieldState<DateTime> field) 
  {
    DateTime now = DateTime.now();
    DateTime firstDate = widget.firstDate??DateTime(1900);
    DateTime lastDate = widget.lastDate??DateTime(2100);
    
    Future<DateTime> datePicker = showDatePicker(
      context: context, 
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: field.value??DateTime(now.year, now.month, now.day),
    );
    datePicker.then((value) {
      field.didChange(value);
      if (widget.onChanged != null) 
      {
        widget.onChanged(value);
      }
    });
  }

  void _showTimePicker(BuildContext context, FormFieldState<DateTime> field, DateTime date) 
  {
    Future<TimeOfDay> datePicker = showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(field.value??DateTime.now()),
    );
    datePicker.then((value) {
      date = date??DateTime.now();
      DateTime time = new DateTime(date.year, date.month, date.day, value.hour, value.minute);
      field.didChange(time);
      if (widget.onChanged != null) 
      {
        widget.onChanged(time);
      }
    });
  }

  void _showDateTimePicker(BuildContext context, FormFieldState<DateTime> field) 
  {
    DateTime now = DateTime.now();
    DateTime firstDate = widget.firstDate??DateTime(1900);
    DateTime lastDate = widget.lastDate??DateTime(2100);
    
    Future<DateTime> datePicker = showDatePicker(
      context: context, 
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: field.value??DateTime(now.year, now.month, now.day),
    );
    datePicker.then((value) {
      if (value == null) {
        field.didChange(value);
        if (widget.onChanged != null) 
        {
          widget.onChanged(value);
        }
      }
      else {
        _showTimePicker(context, field, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: widget.value,
      key: _formFieldState,
      builder: (FormFieldState<DateTime> field) {
        String formatDisplay = "";
        if (field.value != null) 
        {
          DateFormat formatter = widget.dateFormat;
          if (formatter == null) {
            if (widget.inputType == InputType.date) {
              formatter = new DateFormat("yyyy-MM-dd");
            }
            else if (widget.inputType == InputType.time) {
              formatter = new DateFormat("HH:mm");
            }
            else if (widget.inputType == InputType.datetime) {
              formatter = new DateFormat("yyyy-MM-dd HH:mm");
            }
          }
          formatDisplay = formatter.format(field.value);
        }

        return GestureDetector(
          child: InputDecorator(
            decoration: widget.decoration.copyWith(
              errorText: field.errorText,
              enabled: !(widget.readOnly??false)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(formatDisplay),
                Icon(Icons.calendar_today)
              ],
            ),
          ),
          onTap: widget.readOnly ? null : () {
            if (widget.inputType == InputType.date) {
              _showDatePicker(context, field);
            }
            else if (widget.inputType == InputType.datetime) {
              _showDateTimePicker(context, field);
            }
            else if (widget.inputType == InputType.time) {
              _showTimePicker(context, field, DateTime.now());
            }
          }
        );
      },
    );
  }
}
