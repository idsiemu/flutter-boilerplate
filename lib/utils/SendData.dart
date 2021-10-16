// ignore_for_file: file_names
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_guest_app/objects/ResponseData.dart';
import 'package:flutter_guest_app/stores/SessionStore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'envs/APIS.dart';
import 'envs/KEYS.dart';

class SendData {

  static Future<Options> _abstractHeader(Map<String, String>? headers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessAuthKey = prefs.get(KEYS.SESSION_TOKEN).toString();
    // todo: Should be deleted.
    var options = Options(
      headers: Map()
    );
    options.headers![KEYS.SESSION_TOKEN] = sessAuthKey;
    options.contentType = 'application/json';
    options.responseType = ResponseType.json;
    options.receiveDataWhenStatusError = true;
    return options;
  }

  static Map isBody(body){
    if(body == null) body = Map();
    return body;
  }

  static Map<String, String> isQueryString(queryString){
    if(queryString == null) queryString = Map<String, String>();
    queryString[KEYS.SESSION_TYPE] = Device.get().isAndroid ? "W" : "I";
    return queryString;
  }

  static Future<ResponseData> doGet(BuildContext context, String url, {Map<String, String>? headers, Map<String, String>? queryString}) async {
    try{
      var options = await _abstractHeader(headers);
      Response response = await Dio().get('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString));
      return ResponseData(response: response);
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static Future<ResponseData> doHead(BuildContext context, String url, {Map<String, String>? headers, Map<String, String>? queryString}) async {
    var options = await _abstractHeader(headers);
    try{
      Response resopnse = await Dio().head('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString));
      return ResponseData(
          response: resopnse
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static Future<ResponseData> doDelete(BuildContext context, String url, {Map<String, String>? headers, Map? queryString}) async {
    var options = await _abstractHeader(headers);
    try{
      Response resopnse = await Dio().delete('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString));
      return ResponseData(
          response: resopnse
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static Future<ResponseData> doPost(BuildContext context, String url, {Map<String, String>? headers, Map? data, Map? queryString}) async {
    var options = await _abstractHeader(headers);
    try{
      Response resopnse = await Dio().post('${APIS.DOMAIN}$url', options: options, queryParameters: isQueryString(queryString), data: isBody(data));
      return ResponseData(
        response: resopnse
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static Future<ResponseData> doPatch(BuildContext context, String url, {Map<String, String>? headers, Map? data, Map? queryString}) async {
    var options = await _abstractHeader(headers);
    try{
      Response resopnse = await Dio().patch('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString), data: isBody(data));
      return ResponseData(
          response: resopnse
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static Future<ResponseData> doPut(BuildContext context, String url, {Map<String, String>? headers, Map? data, Map? queryString}) async {
    var options = await _abstractHeader(headers);
    try{
      Response response = await Dio().put('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString), data: isBody(data));
      return ResponseData(
          response: response
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }
  }

  static deleteSharedPreferences(BuildContext context, DioError? response) async {
    if(response != null && response.response != null && response.response!.statusCode == HttpStatus.unauthorized){
      SessionStore sessionStores = Provider.of(context, listen: false);
      // sessionStores.logout();
    }else if(response != null && response.response != null && response.response != null && response.response!.statusCode == HttpStatus.upgradeRequired){
      // Navigator.of(context).push(PageRouteBuilder(
      //   pageBuilder: (context, animation, secondaryAnimation) => UpgradeScreen(),
      //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //     return child;
      //   },
      // ));
    }
  }

  static Future<ResponseData> sendFile(BuildContext context, String url, {
    Map<String, String>? headers, Map? data, Map? queryString, List<int>? file
  }) async {
    var len = file!.length;
    try{
      Response response = await Dio().put(url,
          data: Stream.fromIterable(file.map((e) => [e])),
          options: Options(
              contentType: "multiple/form-data",
              headers: {
                Headers.contentLengthHeader: len
              }
          )
      );
      return ResponseData(
        response: response
      );
    }on DioError catch(e){
      deleteSharedPreferences(context, e);
      return ResponseData(e: e);
    }

  }

}