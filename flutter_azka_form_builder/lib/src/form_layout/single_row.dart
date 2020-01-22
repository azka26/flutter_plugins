import 'package:flutter/material.dart';

class SingleRow extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  SingleRow({
    Key key, 
    this.children, 
    this.padding = const EdgeInsets.all(0)
  }) : super(key: key);

  @override
  _SingleRowState createState() => _SingleRowState();
}

class _SingleRowState extends State<SingleRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Column(
        children: widget.children,
      ),
    );
  }
}