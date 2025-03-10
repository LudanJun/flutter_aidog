import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

/*

     获取当前的 padding 信息
    final EdgeInsets edgeInsets = MediaQuery.of(context).padding;

    print("当前状态栏高度:${edgeInsets.top}");

    print("当前底部安全区域高度:${edgeInsets.bottom}");

    print("底部tabBar高度默认49");

    print("顶部导航高度默认44");

    print("设备的像素密度:${ScreenUtil().pixelRatio}");

    print("设备宽度:${ScreenUtil().screenWidth}");

    print("设备高度:${ScreenUtil().screenHeight}");

    print("底部安全区距离，适用于全面屏下面有按键的:${ScreenUtil().bottomBarHeight}");

    print("状态栏高度 刘海屏会更高:${ScreenUtil().statusBarHeight}");

    print("系统字体缩放比例:${ScreenUtil().textScaleFactor}");

    print("实际宽度设计稿宽度的比例:${ScreenUtil().scaleWidth}");

    print("实际高度与设计稿高度度的比例:${ScreenUtil().scaleHeight}");
    
    print("屏幕方向:${ScreenUtil().orientation}");
 */
//间距
double spacing = ScreenAdapter.width(5);

//图片选取数量
const int maxAssets = 9;

//图片宽度
double imagePadding = ScreenAdapter.width(1);

final margin_5 = ScreenAdapter.width(5);
final margin_10 = ScreenAdapter.width(10);
final margin_15 = ScreenAdapter.width(15);
final margin_20 = ScreenAdapter.width(20);
final margin_25 = ScreenAdapter.width(25);
final margin_30 = ScreenAdapter.width(30);
final margin_35 = ScreenAdapter.width(35);
final margin_40 = ScreenAdapter.width(40);
final margin_45 = ScreenAdapter.width(45);
final margin_50 = ScreenAdapter.width(50);

final padding_5 = ScreenAdapter.width(5);
final padding_10 = ScreenAdapter.width(10);
final padding_15 = ScreenAdapter.width(15);
final padding_20 = ScreenAdapter.width(20);
final padding_25 = ScreenAdapter.width(25);
final padding_30 = ScreenAdapter.width(30);
final padding_35 = ScreenAdapter.width(35);
final padding_40 = ScreenAdapter.width(40);
final padding_45 = ScreenAdapter.width(45);
final padding_50 = ScreenAdapter.width(50);
final padding_55 = ScreenAdapter.width(55);
final padding_60 = ScreenAdapter.width(60);
final padding_65 = ScreenAdapter.width(65);
final padding_70 = ScreenAdapter.width(70);
final padding_75 = ScreenAdapter.width(75);
final padding_80 = ScreenAdapter.width(80);
final padding_85 = ScreenAdapter.width(85);
final padding_90 = ScreenAdapter.width(90);
final padding_95 = ScreenAdapter.width(95);
final padding_100 = ScreenAdapter.width(100);

final globalSpaceH5 = SizedBox(height: ScreenAdapter.height(5));
final globalSpaceH8 = SizedBox(height: ScreenAdapter.height(8));
final globalSpaceH10 = SizedBox(height: ScreenAdapter.height(10));
final globalSpaceH15 = SizedBox(height: ScreenAdapter.height(15));
final globalSpaceH20 = SizedBox(height: ScreenAdapter.height(20));
final globalSpaceH25 = SizedBox(height: ScreenAdapter.height(25));
final globalSpaceH30 = SizedBox(height: ScreenAdapter.height(30));
final globalSpaceH35 = SizedBox(height: ScreenAdapter.height(35));
final globalSpaceH40 = SizedBox(height: ScreenAdapter.height(40));
final globalSpaceH45 = SizedBox(height: ScreenAdapter.height(45));
final globalSpaceH50 = SizedBox(height: ScreenAdapter.height(50));

final globalSpaceW5 = SizedBox(height: ScreenAdapter.width(5));
final globalSpaceW8 = SizedBox(height: ScreenAdapter.width(8));
final globalSpaceW10 = SizedBox(height: ScreenAdapter.width(10));
final globalSpaceW15 = SizedBox(height: ScreenAdapter.width(15));
final globalSpaceW20 = SizedBox(height: ScreenAdapter.width(20));
final globalSpaceW25 = SizedBox(height: ScreenAdapter.width(25));
final globalSpaceW30 = SizedBox(height: ScreenAdapter.width(30));
final globalSpaceW35 = SizedBox(height: ScreenAdapter.width(35));
final globalSpaceW40 = SizedBox(height: ScreenAdapter.width(40));
final globalSpaceW45 = SizedBox(height: ScreenAdapter.width(45));
final globalSpaceW50 = SizedBox(height: ScreenAdapter.width(50));

// horizontal:水平间距
final globalEdgeHorizontal8 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(8));
final globalEdgeHorizontal12 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(12));
final globalEdgeHorizontal16 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(16));
final globalEdgeHorizontal20 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(20));
final globalEdgeHorizontal24 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(24));
final globalEdgeHorizontal34 =
    EdgeInsets.symmetric(horizontal: ScreenAdapter.width(34));
