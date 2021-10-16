// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';

class SignScreen extends StatefulWidget {

  SignScreen({
    this.isPopup = false
  });
  bool? isPopup = false;

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      setState(() {
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (widget.isPopup != null && widget.isPopup!) ? 1 : initialized ? 1 : 0,
      duration: Duration(milliseconds: (widget.isPopup != null && widget.isPopup!) ? 0 : 300),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          leading: widget.isPopup! ? InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ) : Container(),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).padding.bottom + (!widget.isPopup! ? 65 : 0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: Container()),
              Column(
                children: [
                  abstractButton(button: kakaoButton()),
                  abstractButton(button: appleButton()),
                  abstractButton(button: buttonsWithEmail()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  abstractButton({
    required Widget button
  }){
    double marginHorizontal = 20;
    return Container(
      margin: EdgeInsets.only(
          left: marginHorizontal,
          right: marginHorizontal,
          bottom: 10
      ),
      child: button,
    );
  }

  Container kakaoButton({double? fontSize}){
    if(fontSize == null) fontSize = 18;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 13
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.yellow,
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20
              ),
              child: Icon(Icons.extension)
          ),
          Expanded(
            child: Center(
              child: Text('카카오로 계속하기',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container appleButton({double? fontSize}){
    if(fontSize == null) fontSize = 18;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 13
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black87,
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20
              ),
              child: Icon(Icons.extension,
                color: Colors.white,
              )
          ),
          Expanded(
            child: Center(
              child: Text('Apple로 계속하기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buttonsWithEmail({double? fontSize}){
    if(fontSize == null) fontSize = 18;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {

            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 13
              ),
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Center(
                child: Text('이메일 로그인',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 13
              ),
              width: (MediaQuery.of(context).size.width - 40) / 2,
              child: Center(
                child: Text('이메일 회원가입',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
