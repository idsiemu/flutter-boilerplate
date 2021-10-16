// ignore_for_file: file_names, prefer_const_declarations, non_constant_identifier_names

import 'package:flutter/foundation.dart';

class APIS {
  static final DOMAIN = kReleaseMode ?
    'production api url' :
    'dev api url'
  ;
  static final VERSION_ANDROID = '/v0.0.0';
  static final VERSION_IOS = '/v0.0.0';

}