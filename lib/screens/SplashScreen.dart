// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guest_app/screens/RouterScreen.dart';
import 'package:flutter_guest_app/stores/SessionStore.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool visible = false;
  final _kTestingCrashlytics = true;
  final _kShouldTestAsyncErrorOnInit = false;

  @override
  void initState() {
    super.initState();
    initialized();
    startTime();
  }

  initialized(){
    Future.microtask(() async {
      SessionStore sessionStore = Provider.of(context, listen: false);
      await sessionStore.initializedApp();
      sessionStore.checkSession(context);
    });
  }

  Future initApplication() async {

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initApplication(),
      builder: (ctx, builder){
        return Scaffold(
          backgroundColor: Colors.white,
          body: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: kReleaseMode ? Center(
              child: SizedBox(
                height: 165,
                width: 165,
                child: Image.asset('assets/splash_logo.png'),
              ),
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 165,
                    width: 165,
                    child: Image.asset('assets/splash_logo.png'),
                  ),
                ),
                Text('Debug Mode',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  startTime() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      visible = true;
    });

    var _duration = new Duration(milliseconds: 2000);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    setState(() {
      visible = false;
    });
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RouterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ));
  }

}
