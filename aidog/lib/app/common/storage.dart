import 'dart:convert';

import 'package:aidog/app/common/log_extern.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class Storage {
  // /// 设置添加数据
  // /// 使用 Storage.setData("checkListData", checkListData);
  // static setData(String key, dynamic value) async {
  //   var prefs = await SharedPreferences.getInstance();
  //   // prefs.setString(key, json.encode(value));
  //   prefs.setString(key,value);
  // }

  // /// 获取存储数据
  // /// 使用: List? searchListData = await Storage.getData("searchList");
  // static getData(String key) async {
  //   //本地存储不存在抛出异常
  //   try {
  //     var prefs = await SharedPreferences.getInstance();
  //     String? tempData = prefs.getString(key);
  //     //如果没有数据 返回空
  //     if (tempData != null) {
  //       return tempData; // json.decode(tempData);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  /// 添加String类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// 添加int类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// 添加bool类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// 添加double类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  /// 添加List<String>类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  /// 添加 Object 类型数据，需继承 BaseModel
  /// [key] 键
  /// [value] 值
  static Future<void> putObject<T extends BaseModel>(
      String key, T value) async {
    final jsonString = jsonEncode(value.toJson());
    setString(key, jsonString);
  }

  /// 获取String类型数据
  /// [key] 键
  /// [defValue] 默认值：默认为空字符串
  static Future<String> getString(String key, [String defValue = '']) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key) ?? defValue;
    return value;
  }

  /// 获取int类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值：默认为0
  static Future<int> getInt(String key, [int defValue = 0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(key) ?? defValue;
    return value;
  }

  /// 获取double类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值：默认为0.0
  static Future<double> getDouble(String key, [double defValue = 0.0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? value = prefs.getDouble(key) ?? defValue;
    return value;
  }

  /// 获取bool类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值：默认为false
  static Future<bool> getBool(String key, [bool defValue = false]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(key) ?? defValue;
    return value;
  }

  /// 获取List<String>类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值：默认为空List
  static Future<List<String>> getStringList(String key,
      [List<String> defValue = const []]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(key) ?? defValue;
    return value;
  }

  ///  获取 Object 类型数据，如果没有则返回 null
  /// [key] 键
  /// [fromJsonT] 转换器，用于将 map 转为对象
  /// [value] 值
  static Future<T?> getObject<T extends BaseModel>(
      String key, T Function(Map<String, dynamic> json) fromJsonT,
      [T? defValue]) async {
    String jsonString = await getString(key);
    if (jsonString.isNotEmpty) {
      final jsonMap = jsonDecode(jsonString);
      return fromJsonT(jsonMap);
    }
    return null;
  }

  /// 移除存储的数据
  /// 使用:Storage.removeData("userinfo");
  static removeData(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// 清空所有数据
  /// 使用: Storage.clear("searchList");
  static removeAll() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

abstract class BaseModel {
  Map<String, dynamic> toJson();
}
