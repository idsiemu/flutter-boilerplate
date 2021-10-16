// ignore_for_file: file_names, unnecessary_this

import 'package:dio/dio.dart';

class ResponseData<T> {

  Response? response;

  DioError? e;

  ResponseData({
    this.response,
    this.e
  });

  bool isSuccess(){
    return this.response != null && this.response!.statusCode == 200;
  }

  getData(){
    if(this.response != null && this.response!.statusCode == 200){
      return response!.data;
    }else {
      return  e!.response!.data;
    }
  }

}