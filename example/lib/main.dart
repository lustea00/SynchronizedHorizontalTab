import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:synchronized_horizontal_tab/synchronized_horizontal_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SynchronizedHorizontalTab(
            page: [
              Container(
                height: 700,
                width: 500,
                color: Colors.black,
              ),
              Container(
                height: 700,
                width: 500,
                color: Colors.green,
              ),
              Container(
                height: 700,
                width: 500,
                color: Colors.yellow,
              ),
            ],
            tab: [
              Icon(
                Icons.directions_car,
                color: Colors.black,
              ),
              Icon(
                Icons.directions_transit,
                color: Colors.green,
              ),
              Icon(
                Icons.directions_bike,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
