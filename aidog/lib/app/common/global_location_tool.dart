import 'dart:async';
import 'dart:convert';

import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

typedef LocationResultCallback = Function(Map<String, Object> result);

class GlobalLocationTool {
  //私有构造函数
  GlobalLocationTool._privateConstructor() {
    AALog("初始定位");
    updatePrivacy();

    /// 配置高德key
    AMapFlutterLocation.setApiKey(
        "6ad1b1b5b45f1329f3e80411331b0a59", "4ed19756b7b2827226c5757ffd256857");

    /// 申请定位权限
    requestPermission();
  }

  //实例化一个静态对象
  static final GlobalLocationTool _instance =
      GlobalLocationTool._privateConstructor();

  //公共getter 方法读取
  factory GlobalLocationTool() => _instance;

  ///开始定位 实例化插件
  AMapFlutterLocation _locationPlugin = AMapFlutterLocation();

  ///监听定位
  late StreamSubscription<Map<String, Object>> _locationListener;
  // BuildContext? context = navigatorKey.currentContext;

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      AALog("定位权限申请通过");

      // /// 注册定位监听结果
      // _locationListener = _locationPlugin
      //     .onLocationChanged()
      //     .listen((Map<String, Object> result) {
      //   // setState(() {
      //   //   _locationResult = result;
      //   //   AALog(result);
      //   //   _latitude = result["latitude"].toString();
      //   //   _longitude = result["longitude"].toString();
      //   // });
      //   // resultBack!(result);
      //   AALog("result定位结果-$result");
      //   //     _description = map["description"].toString();

      //   Provider.of<LoginProvider>(context!, listen: false).desAddressStr =
      //       result["description"].toString();

      //   Provider.of<LoginProvider>(context!, listen: false).addressStr =
      //       jsonEncode(result);
      // });
    } else {
      // AppSettin .openAppSettings();

      AALog("定位权限申请不通过");
    }
  }

  ///设置协议 必须
  void updatePrivacy() {
    /// 需要设置合规隐私接口 必须
    AMapFlutterLocation.updatePrivacyAgree(true);
    AMapFlutterLocation.updatePrivacyShow(true, true);
  }

  /// 申请定位权限 授予定位权限返回true,否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的定位权限 照相图片权限等
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  //添加注册定位监听
  void locationResultListen(LocationResultCallback? resultBack) async {
    /// 注册定位监听结果
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      // setState(() {
      //   _locationResult = result;
      //   AALog(result);
      //   _latitude = result["latitude"].toString();
      //   _longitude = result["longitude"].toString();
      // });
      resultBack!(result);
    });
  }

  ///开始定位
  void startLocationInfo() {
    ///开始定位之前设置定位参数
    setLocationOption();
    _locationPlugin.startLocation();
  }

  ///开始定位
  void startLocation(
    LocationResultCallback? resultBack,
  ) async {
    if (_locationPlugin != null) {
      ///开始定位之前设置定位参数
      setLocationOption();
      _locationPlugin.startLocation();
/*
      /// 注册定位监听结果
      _locationListener = _locationPlugin
          .onLocationChanged()
          .listen((Map<String, Object> result) {
        // setState(() {
        //   _locationResult = result;
        //   AALog(result);
        //   _latitude = result["latitude"].toString();
        //   _longitude = result["longitude"].toString();
        // });
        resultBack!(result);
      });*/
    }
  }

  /// 设置定位参数
  void setLocationOption() {
    if (_locationPlugin != null) {
      AMapLocationOption locationOption = AMapLocationOption();

      /// 是否单次定位
      locationOption.onceLocation = false;

      /// 是否需要返回逆地理信息
      locationOption.needAddress = true;

      /// 逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;
      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      /// 设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  /// 销毁移除监听
  void destroyLocation() {
    ///销毁定位
    _locationPlugin.destroy();
    AALog(_locationPlugin);

    ///移除定位监听
    _locationListener.cancel();
    AALog(_locationListener);
  }
}
