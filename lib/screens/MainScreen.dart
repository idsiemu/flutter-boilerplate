// ignore_for_file: file_names, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_guest_app/screens/RoomDetailScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await Navigator.of(context)
              .push(MaterialWithModalsPageRoute(builder: (context) {
            return RoomDetailScreen();
          }));
          // bool result = await Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) {
          //   return RoomDetailScreen();
          // }));
        },
        child: Center(
          child: Text('MainScreen'),
        ),
      ),
    );
  }
}
