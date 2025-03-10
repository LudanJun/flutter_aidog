//封装第三方框架屏幕适配器
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static width(num v) {
    return v.w;
  }

  static height(num v) {
    return v.h;
  }

  static fontSize(num v) {
    return v.sp;
  }

  /// 获取屏幕宽度
  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  /// 获取屏幕高度
  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  /// 获取状态栏高度
  static getStatusBarHeight() {
    return ScreenUtil().statusBarHeight; //状态栏高度 刘海屏会更高 59
  }

  /// 底部安全区距离，适用于全面屏下面有按键的
  static bottomBarHeight() {
    return ScreenUtil().bottomBarHeight; //34
  }

  /// 底部tabBar高度默认
  static bottomTabbarHeight() {
    return 49.0;
  }
}

/**
    获取当前的 padding 信息
    final EdgeInsets edgeInsets = MediaQuery.of(context).padding;
    print("当前状态栏高度:${edgeInsets.top}");
    print("当前底部安全区域高度:${edgeInsets.bottom}");
    print("底部tabBar高度默认49");
    print("顶部导航高度默认44");
    print(ScreenUtil().bottomBarHeight + 49);
 */