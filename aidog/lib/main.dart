import 'package:aidog/app.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/models/implements(%E6%8A%BD%E8%B1%A1%E5%AE%9E%E7%8E%B0%E7%B1%BB)/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //配置透明状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle();
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  //获取是否需要显示引导页
  bool isShowGuide = await AuthService().isShowGuide();
  AALog('isShowGuide: $isShowGuide');
  //获取是否是登录状态
  bool isLogin = await AuthService().isLogin();
  AALog('isLogin: $isLogin');

  runApp(MyApp(isShowGuide: isShowGuide, isLogin: isLogin));
}
