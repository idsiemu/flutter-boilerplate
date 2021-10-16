// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_guest_app/screens/EventScreen.dart';
import 'package:flutter_guest_app/screens/MainScreen.dart';
import 'package:flutter_guest_app/screens/MyPageScreen.dart';
import 'package:flutter_guest_app/screens/SearchScreen.dart';
import 'package:flutter_guest_app/stores/SessionStore.dart';
import 'package:flutter_guest_app/stores/SystemStore.dart';
import 'package:provider/provider.dart';

class RouterScreen extends StatefulWidget {
  @override
  _RouterScreenState createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {

  final double iconSize = 28.0;
  final Color selectedColor = Colors.black87;

  List<Widget> _pages = [
    MainScreen(),
    SearchScreen(),
    EventScreen(),
    MyPageScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionStore>(
      builder: (context, stores, child){
        return stores.introduced ? routerComponent(context) : Container();
      },
    );
  }

  Widget routerComponent(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            Consumer<SystemStore>(
              builder: (context, store, widget){
                return Container(
                  child: _pages[store.selectedPage],
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 64
                  ),
                );
              },
            ),
            Consumer<SystemStore>(
              builder: (context, store, widget) => Align(
                  alignment: Alignment.bottomCenter,
                  child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: Colors.white),
                      child: BottomNavigationBar(
                        // selectedItemColor: Colors.green,
                        selectedFontSize: 15,
                        unselectedFontSize: 12,
                        selectedItemColor: selectedColor,
                        selectedLabelStyle: TextStyle(
                            color: selectedColor
                        ),
                        unselectedItemColor: Colors.grey,
                        onTap: (idx) {
                          store.handleSelectedPage(idx);
                        },
                        enableFeedback: true,
                        currentIndex: store.selectedPage,
                        items: [
                          BottomNavigationBarItem(
                              label: '홈',
                              icon: Icon(Icons.home_filled,
                                size: iconSize,
                                color: store.selectedPage == 0 ? selectedColor : Colors.grey,
                              )
                          ),
                          BottomNavigationBarItem(
                              label: '지역',
                              icon: Icon(Icons.car_repair,
                                size: iconSize,
                                color: store.selectedPage == 1 ? selectedColor : Colors.grey,
                              )
                          ),
                          BottomNavigationBarItem(
                              label: '이벤트',
                              icon: Icon(Icons.account_circle,
                                size: iconSize,
                                color: store.selectedPage == 2 ? selectedColor : Colors.grey,
                              )
                          ),
                          BottomNavigationBarItem(
                              label: '마이',
                              icon: Icon(Icons.account_circle,
                                size: iconSize,
                                color: store.selectedPage == 2 ? selectedColor : Colors.grey,
                              )
                          )
                        ],
                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
