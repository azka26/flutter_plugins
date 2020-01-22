import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_azka_form_builder/flutter_azka_form_builder.dart';

enum InputType { date, datetime, time }

class FormBuilderDateTimePicker extends StatefulWidget {
  final String id;
  final InputDecoration decoration;
  final String dateFormat;
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
  TextEditingController _controller;

  @override
  void initState() {
    _formState = AzkaFormBuilder.of(context);
    if (_formState != null) 
    {
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

  void _setValueChanged(DateTime value) {
    String  valString = ""; 
    if (value != null) {
      valString = _dateTimeToString(value);
    } 
    _controller.value = TextEditingValue(text: valString);
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  void _showDatePicker(BuildContext context) {
    DateTime now = DateTime.now();
    Future<DateTime> datePicker = showDatePicker(
      initialDate: widget.value??DateTime(now.year, now.month, now.day),
      firstDate: widget.firstDate??DateTime(1970),
      lastDate: widget.lastDate??DateTime(2100),
      context: context
    );
    datePicker.then((dateValue) {
      _setValueChanged(dateValue);
    });
  }

  void _showTimePicker(BuildContext context, DateTime selectedDate) {
    DateTime now = DateTime.now();
    DateTime selectedTime = widget.value??now;
    Future<TimeOfDay> timePicker = showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );
    timePicker.then((timeOfDay) {
      if (timeOfDay == null) {
        _setValueChanged(null);
        return;
      }

      DateTime dateTimeResult = selectedDate??now;
      DateTime result = DateTime(dateTimeResult.year, dateTimeResult.month, dateTimeResult.day, timeOfDay.hour, timeOfDay.minute);
      _setValueChanged(result);
    });
  }

  void _showDateTimePicker(BuildContext context) {
    DateTime now = DateTime.now();
    Future<DateTime> datePicker = showDatePicker(
      initialDate: widget.value??DateTime(now.year, now.month, now.day, now.hour, now.minute),
      firstDate: widget.firstDate??DateTime(1970),
      lastDate: widget.lastDate??DateTime(2100),
      context: context,
    );
    datePicker.then((dateValue) {
      if (dateValue == null) {
        _setValueChanged(null);
        return;
      }
      _showTimePicker(context, dateValue);
    });
  }
  
  DateFormat _getDateTimeFormatter() {
    String formatDate = widget.dateFormat;
    if (formatDate == null) {
      switch (widget.inputType) {
        case InputType.date: formatDate = "yyyy-MM-dd"; break;
        case InputType.datetime: formatDate = "yyyy-MM-dd HH:mm:ss"; break;
        case InputType.time: formatDate = "HH:mm:ss"; break;
      }
    }
    return DateFormat(formatDate);
  }

  String _dateTimeToString(DateTime value) {
    if (value == null) return "";
    return _getDateTimeFormatter().format(value);
  }

  @override
  Widget build(BuildContext context) {
    String selectedDate = _dateTimeToString(widget.value);
    _controller = new TextEditingController();
    _controller.value = TextEditingValue(text: selectedDate);

    Widget icon;
    if (widget.decoration.suffixIcon != null) {
      icon = widget.decoration.suffixIcon;
    } else {
      switch (widget.inputType) {
        case InputType.date: icon = Icon(Icons.calendar_today); break;
        case InputType.datetime: icon = Icon(Icons.calendar_today); break;
        case InputType.time: icon = Icon(Icons.timer);break;
      }
    }

    return TextFormField(
      key: _formFieldState,
      controller: _controller,
      decoration: widget.decoration.copyWith(
        suffixIcon: icon
      ),
      onTap: () {
        switch (widget.inputType) 
        {
          case InputType.date: _showDatePicker(context); break;
          case InputType.datetime: _showDateTimePicker(context); break;
          case InputType.time: _showTimePicker(context, null);break;
        }
      },
      readOnly: true
    );
  }
}
