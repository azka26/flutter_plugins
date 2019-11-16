import 'package:flutter/material.dart';

class FutureBuilderExample extends StatefulWidget {
  @override
  _FutureBuilderExampleState createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  Future<String> _getText() async {
    await Future.delayed(Duration(seconds: 3));
    return "Text Result From Future";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder Example"),
      ),
      body: FutureBuilder<String>(
        future: _getText(),
        builder: (BuildContext futureContext, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(snapshot.data),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
