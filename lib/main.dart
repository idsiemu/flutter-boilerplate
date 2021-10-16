// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_guest_app/screens/RouterScreen.dart';
import 'package:flutter_guest_app/screens/SplashScreen.dart';
import 'package:flutter_guest_app/stores.dart';
import 'package:flutter_guest_app/units/CupertinoLocalisationsDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: stores().combineStores,
      child: GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          CupertinoLocalisationsDelegate(),
        ],
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/routers': (context) => RouterScreen(),
        },
      ),
    );
  }
}

