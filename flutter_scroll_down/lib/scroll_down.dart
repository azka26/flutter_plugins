import 'package:flutter/material.dart';

class ScrollDown extends StatefulWidget {
  @override
  _ScrollDownState createState() => _ScrollDownState();
}

class _ScrollDownState extends State<ScrollDown> {
  ScrollController _controller;
  
  void _scrollListener() {
    if (_controller.offset == _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
        // RELOAD DATA
      print("OFFSET : " + _controller.offset.toString());
      print("Max Posisition : " + _controller.position.maxScrollExtent.toString());
      print("Is Out Of Range : " + _controller.position.outOfRange.toString());
    }
      // print("OFFSET : " + _controller.offset.toString());
      // print("Max Posisition : " + _controller.position.maxScrollExtent.toString());
      // print("Is Out Of Range : " + _controller.position.outOfRange.toString());
  }

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: 20,
      itemBuilder: (listContext, index) {
        return Container(
          height: 40,
          child: Text("Child Index : " + index.toString())
        );
      },
    );
  }
}