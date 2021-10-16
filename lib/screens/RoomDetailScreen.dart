// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RoomDetailScreen extends StatefulWidget {
  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context, false);
          },
          child: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () async {
          await showCupertinoModalBottomSheet(
              enableDrag: false,
              context: context,
              builder: (ctx) {
            return RoomDetailScreen( );
          },
          );
        },
        child: Center(
          child: Text('RoomDetailScreen'),
        ),
      ),
    );
  }
}
