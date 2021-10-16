// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_guest_app/screens/MyPageComponent.dart';
import 'package:flutter_guest_app/screens/SignScreen.dart';
import 'package:flutter_guest_app/stores/SessionStore.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SessionStore>(
      builder: (ctx, sessionStore, widget){
        return sessionStore.hasSession() ? MyPageComponent() : SignScreen();
      },
    );
  }
}
