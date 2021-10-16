// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class CupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) => DefaultCupertinoLocalizations.load(locale);

  @override
  // ignore: non_constant_identifier_names
  bool shouldReload(CupertinoLocalisationsDelegateold) => false;
}