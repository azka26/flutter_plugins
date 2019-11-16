import 'package:flutter/material.dart';
import 'package:flutter_example/components/form_builder_example.dart';
import 'package:flutter_example/components/future_builder_example.dart';
import 'package:flutter_example/components/scroll_example.dart';
import 'package:flutter_example/components/stream_builder_example.dart';

typedef RedirectFunction = Function(BuildContext context);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _linkToSample(
      BuildContext context, String text, RedirectFunction redirectFunction) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      child: RaisedButton(
        child: Text(text),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: redirectFunction));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page Example"),
      ),
      body: ListView(
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: RaisedButton(
          //     child: Text("Scroll Example"),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => ScrollExample(),
          //         ),
          //       );
          //     },
          //   ),
          // )
          _linkToSample(context, "Scroll Example", (context) => ScrollExample()),
          _linkToSample(context, "Stream Builder", (context) => StreamBuilderExample()),
          _linkToSample(context, "Future Builder", (context) => FutureBuilderExample()),
          _linkToSample(context, "Form Builder", (context) => FormBuilderExample())
        ],
      ),
    );
  }
}
