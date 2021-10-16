// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';

class MyPageComponent extends StatefulWidget {
  @override
  _MyPageComponentState createState() => _MyPageComponentState();
}

class _MyPageComponentState extends State<MyPageComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MyPageCompoent'),
      ),
    );
  }
}
