import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result Test',
      home: MyHomePage(title: 'Result Test'),
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

  final streamController = BehaviorSubject<String>();
  ValueStream<String> get stream => streamController.stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          StreamBuilder<String>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Err: ${snapshot.error.toString()}");
              } else {
                return Text("Data: ${snapshot.data}");
              }
            },
          ),
          FlatButton(
            onPressed: _addValToStream,
            child: Text("Add VAL to stream"),
          ),
          FlatButton(
            onPressed: _addErrToStream,
            child: Text("Add ERR to stream"),
          )
        ],
      ),
    );
  }

  _addValToStream() {
    Result.value(Random().nextInt(1000).toString())
        .addTo(streamController);
  }

  _addErrToStream() {
    Result.error(Exception("Error!"))
        .addTo(streamController);
  }

}