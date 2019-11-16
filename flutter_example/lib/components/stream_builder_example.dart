import 'package:flutter/material.dart';

class StreamBuilderExample extends StatefulWidget {
  @override
  _StreamBuilderExampleState createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  int seconds = 0;
  Stream<int> _timer() async* {
    do {
      await Future.delayed(Duration(seconds: 1));
      yield seconds++;
    } while(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder Example (Timer)"),
      ),
      body: StreamBuilder<int>(
        stream: _timer(),
        builder: (BuildContext contextStream, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: Text(snapshot.data.toString()),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}