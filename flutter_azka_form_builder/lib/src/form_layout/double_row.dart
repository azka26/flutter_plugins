import 'package:flutter/material.dart';

class DoubleRow extends StatefulWidget {
  final List<Widget> firstChildren;
  final List<Widget> secondChildren;
  final EdgeInsets firstPadding;
  final EdgeInsets secondPadding;

  DoubleRow({Key key, this.firstChildren, this.secondChildren, this.firstPadding, this.secondPadding}) : super(key: key);

  @override
  _DoubleRowState createState() => _DoubleRowState();
}

class _DoubleRowState extends State<DoubleRow> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: width),
          padding: widget.firstPadding,
          child: Column(
            children: widget.firstChildren,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: width),
          padding: widget.secondPadding,
          child: Column(
            children: widget.secondChildren,
          ),
        )
      ],
    );
  }
}