import 'package:flutter/material.dart';
import 'package:flutter_scroll_down/scroll_down.dart';
import 'package:flutter_scroll_down/dummy_service.dart';

class ScrollExample extends StatefulWidget {
  @override
  _ScrollExampleState createState() => _ScrollExampleState();
}

class _ScrollExampleState extends State<ScrollExample> {
  List<String> _data = new List<String>();
  bool _isWaiting = false;
  DummyService _dummyService = new DummyService();
  int _limit = 50;
  int _offset = 0;
  String _filter = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    if (_isWaiting) {
      return;
    }

    this.setState(() {
      _isWaiting = true;
    });

    _dummyService.getDummys(_filter, _limit, _offset).then((onValue) {
      this.setState(() {
        if (onValue != null && onValue.length > 0) {
          this._offset = this._offset + onValue.length;
          this._data.addAll(onValue); 
        }
        this._isWaiting = false;
      });
    }, onError: (error) {
      this.setState(() {
        this._isWaiting = false;
      });
      print("ERROR");
    });
  }


  void _onScrollEnd() {
    _loadData();
  }

  Widget _itemBuilder(BuildContext context, String objValue) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(objValue),
    );
  }

  Widget _loader() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Example"),
      ),
      body: ScrollDown<String>(
        data: _data,
        isWaiting: _isWaiting,
        onScrollEnd: _onScrollEnd,
        itemBuilder: _itemBuilder,
        loader: _loader(),
      ),
    );
  }
}
