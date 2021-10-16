// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter_guest_app/objects/ResponseData.dart';
import 'package:flutter_guest_app/objects/SessionUser.dart';
import 'package:flutter_guest_app/utils/SendData.dart';
import 'package:flutter_guest_app/utils/envs/KEYS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemStore with ChangeNotifier{

  bool starting = true;
  int _selectedPage = 0;
  bool introduced = true;
  bool navigatorBlur = true;

  // ignore: unnecessary_getters_setters
  int get selectedPage => _selectedPage;

  // ignore: unnecessary_getters_setters
  set selectedPage(int value) {
    _selectedPage = value;
  }

  handleSelectedPage(int index) {
    _selectedPage = index;
    notifyListeners();
  }

  checkToBeIntroduced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // introduced = prefs.get('initialized') == null ? false : prefs.get('initialized');
    prefs.setBool('initialized', introduced);
    notifyListeners();
  }

  completeToIntroduceApp() async {
    introduced = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('initialized', introduced);
    notifyListeners();
  }

}