// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guest_app/objects/ResponseData.dart';
import 'package:flutter_guest_app/objects/SessionUser.dart';
import 'package:flutter_guest_app/utils/SendData.dart';
import 'package:flutter_guest_app/utils/envs/KEYS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStore with ChangeNotifier {

  bool loadingSign = false;
  bool initialized = false;
  bool introduced = true;
  SessionUser? sessionUser;
  Future initializedApp() async {

    notifyListeners();
  }

  Future checkSession(context) async {
    Map<String, String> data = Map();
    // data['notification_token'] = await PushComponent().getToken();
    ResponseData response = await SendData.doPost(context, '/hello-world', queryString: data);
    try{
      if(response.isSuccess()){
        sessionUser = SessionUser.fromJson(response.getData());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(KEYS.SESSION_TOKEN, sessionUser!.sessionKey);
      }else {
        logout();
      }
    }catch(e){
      logout();
    }finally{
      if(!initialized) {
        initialized = true;
      }
    }
    notifyListeners();
  }

  logout() async {
    sessionUser = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEYS.SESSION_TOKEN, "");
    notifyListeners();
  }

  bool hasSession(){
    return (sessionUser != null);
  }

  Future loginWithEmail({required String email, required String password, required BuildContext context}) async {
    if(loadingSign) return;
    loadingSign = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 800));
    Map<String, String> parameter = Map();
    bool result = false;
    try{
      Map<String, String> queryString = Map();
      parameter['email'] = email;
      // parameter['password'] = Utils.getPasswordSHA256(password)!;
      ResponseData response = await SendData.doPost(context, '/login', data: parameter, queryString: queryString);
      if(response.isSuccess()){
        await setSession(response.getData());
        result = true;
      }else {
        // Utils.errorSnackbar('뭔가 잘못되었습니다.', response);
        logout();
      }
    }catch(e){
      logout();
    }finally{

    }
    loadingSign = false;
    await Future.delayed(Duration(milliseconds: 200));
    notifyListeners();
    return result;
  }

  Future setSession(Map<String, dynamic>? map) async {
    if(map == null) return;
    try{
      sessionUser = SessionUser.fromJson(map);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(KEYS.SESSION_TOKEN, this.sessionUser!.sessionKey!);
      notifyListeners();
    }catch(e){

    }
  }
}