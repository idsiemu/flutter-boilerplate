import 'package:flutter_guest_app/stores/SystemStore.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'stores/SessionStore.dart';

// ignore: camel_case_types
class stores {

  List<SingleChildWidget> combineStores = [
    ChangeNotifierProvider<SessionStore>(
      create: (context) => SessionStore(),
    ),
    ChangeNotifierProvider<SystemStore>(
      create: (context) => SystemStore(),
    ),
  ];

}