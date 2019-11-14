import 'package:flutter/material.dart';

typedef OnScrollEndFunction = void Function();
typedef ScrollDownBuilder<T> = Widget Function(BuildContext context, T item);
class ScrollDown<T> extends StatefulWidget {
  ScrollDown({ Key key, this.onScrollEnd, this.itemBuilder, this.data, this.isWaiting, this.loader }) : super(key: key);

  final OnScrollEndFunction onScrollEnd;
  final List<T> data;
  final ScrollDownBuilder itemBuilder;
  final bool isWaiting;
  final Widget loader;

  @override
  State<ScrollDown<T>> createState() => _ScrollDownState<T>();
}

class _ScrollDownState<T> extends State<ScrollDown<T>> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    _controller.addListener(this._scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      this.widget.onScrollEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<T> data = widget.data;
    bool isWaiting = widget.isWaiting;
    int dataLength = data.length;
    if (isWaiting) {
      dataLength = dataLength + 1;
    }

    return ListView.builder(
      controller: _controller,
      itemCount: dataLength,
      itemBuilder: (itemBuilderContext, index) {
        if (isWaiting && (dataLength - 1) == index) {
          if (this.widget.loader != null) return this.widget.loader;
          
          return Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 10
            ),
            child: Center(child: CircularProgressIndicator(),) ,
          );
        }

        return this.widget.itemBuilder(itemBuilderContext, data[index]);
      }
    );
  }
}