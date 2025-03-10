import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  //存放 常驻位置
  String _globalDesressStr = '';
  String get globalDesressStr => _globalDesressStr;
  set globalDesressStr(String address) {
    _globalDesressStr = address;
    notifyListeners();
  }
}
