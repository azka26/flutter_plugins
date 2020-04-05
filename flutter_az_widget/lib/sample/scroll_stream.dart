import 'package:flutter/material.dart';
import 'package:flutter_az_widget/flutter_az_widget.dart';
import 'package:rxdart/rxdart.dart';

class ScrollBloc {
  BehaviorSubject<PageStream<String>> listStream = new BehaviorSubject<PageStream<String>>();
  PageStream<String> _objectData = PageStream<String>();
  int limit = 20;
  int offset  = 0;

  ScrollBloc() 
  {
    loadMore();
  }

  loadMore() async {
    int max = offset + limit;
    List<String> list = new List<String>();
    for (int i = offset; i < max; i++) {
      list.add("LIST TEXT DATA NO " + (i + 1).toString());
    }
    offset = max;
    _objectData.addList(list);
    if (listStream.isClosed) return;
    this.listStream.sink.add(_objectData);
  }
  
  dispose() {
    this.listStream.sink.close();
    this.listStream.close();
  }
}

class ScrollStream extends StatefulWidget {
  @override
  _ScrollStreamState createState() => _ScrollStreamState();
}

class _ScrollStreamState extends State<ScrollStream> {
  ScrollBloc _scrollBloc;
  @override
  void initState() {
    super.initState();
    this._scrollBloc = new ScrollBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sample Scroll Stream"),),
      body: ScrollPageStream<String>(
        stream: _scrollBloc.listStream.stream,
        buildItem: (BuildContext contextStream, String data) {
          return ListTile(
            title: Text(data),
          );
        },
        onLoad: () async => await this._scrollBloc.loadMore(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollBloc.dispose();
    super.dispose();
  }
}