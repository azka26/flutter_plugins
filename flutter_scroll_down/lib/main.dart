import 'package:flutter/material.dart';
import 'package:flutter_scroll_down/dummy_service.dart';
import 'package:flutter_scroll_down/scroll_down.dart';
import 'test_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scroll Down',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Scroll Down'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _data = new List<String>();
  bool _isWaiting = false;
  String _parameter;
  int _limit = 30;
  int _offset = 0;
  
  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  void _loadData() {
    if (this._isWaiting) 
    {
      return;
    }
    
    this.setState(() {
      this._isWaiting = true;
    });

    DummyService svc = new DummyService();
    svc.getDummys(_parameter, _limit, _offset).then((result) {
      if (result == null || result.length == 0) {
        setState(() {
          this._isWaiting = false;
        });
        return;
      }
      
      this.setState(() {
        this._isWaiting = false;
        this._offset = this._offset + result.length;
        this._data.addAll(result);
      });
    }, onError: (error) {
      this._isWaiting = false;
    });
  }

  void reset(filter) {
    this._data = new List<String>();
    this._offset = 0;
    this._parameter = filter;
    this._isWaiting = false;
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text(widget.title),
          RaisedButton(child: Text("TEST"), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TestForm(
              onBack: (val) {
                this.setState(() {
                  this.reset(val);
                });
              },
            )));
          },)
        ],) ,
      ),
      body: ScrollDown<String>(
        data: this._data,
        isWaiting: this._isWaiting,
        itemBuilder: (context, item) {
          return Container(
            height: 30,
            child: Text(item),
          );
        },
        onScrollEnd: () {
          this._loadData();
        },
      )
    );
  }
}
