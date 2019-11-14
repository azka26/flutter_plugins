import 'package:flutter/material.dart';
import 'package:flutter_example/scroll_example.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page Example"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("Scroll Example"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScrollExample(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
