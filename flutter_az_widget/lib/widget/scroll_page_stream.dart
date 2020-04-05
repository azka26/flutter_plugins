import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef OnLoad = Future<bool> Function();
typedef BuildItem<T> = Widget Function(BuildContext, T);

class PageStream<T> {
  List<T> _listData = new List<T>();
  List<T> get listData => this._listData;
  int get totalData => this.listData.length;
  bool isOnLoad = false;

  addList(List<T> list) 
  {
    if (list == null || list.length == 0) return;
    _listData.addAll(list);
  }
  clearList() 
  {
    _listData.clear();
  }

  String _errorMessage;
  setError(String error) 
  {
    _errorMessage = error;
  }
  clearError() 
  {
    _errorMessage = null;
  }
  getError() 
  {
    return _errorMessage;
  }
}

class ScrollPageStream<T> extends StatefulWidget {
  final ValueStream<PageStream<T>> stream;
  final BuildItem<T> buildItem;
  final OnLoad onLoad;

  const ScrollPageStream({Key key, this.stream, this.buildItem, this.onLoad})
      : super(key: key);

  @override
  _ScrollPageStreamState<T> createState() => _ScrollPageStreamState<T>();
}

class _ScrollPageStreamState<T> extends State<ScrollPageStream<T>> {
  ScrollController _scrollController = new ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) 
      {
        this._reloadData();
      }
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  bool isOnLoad = false;
  _reloadData() async 
  {
    if (this.isOnLoad) return;
    this.isOnLoad = true;
    this.widget.onLoad().whenComplete(() {
      this.isOnLoad = false;
    });
  }

  Widget _getLoader() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this.widget.stream,
      builder: (BuildContext context, AsyncSnapshot<PageStream<T>> snapshot) {
        if (snapshot.hasData) {
          bool isOnLoad = snapshot.data.isOnLoad;
          int counter = snapshot.data.totalData;
          if (isOnLoad) {
            counter = counter + 1;
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: counter,
            itemBuilder: (BuildContext itemContext, int index) {
              if (isOnLoad && snapshot.data.totalData == index) {
                return this._getLoader();
              }

              T data = snapshot.data.listData[index];
              return this.widget.buildItem(itemContext, data);
            },
          );
        }

        if (snapshot.hasError) {
          return Text("Error...");
        }

        return _getLoader();
      },
    );
  }
}
