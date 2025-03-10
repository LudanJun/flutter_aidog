import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class KTColor {
  /// 随机颜色
  /// 调用 GlobalColor.getRandomColor()
  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
    );
  }

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color black333 = Color(0x33333333);

  static const Color red = Color(0xFFF80404);
  static const Color blue = Color(0xFF60E8F8);
  static const Color grey = Colors.grey;
  static const Color orange = Colors.orange;
  static const Color amber = Colors.amber;
  static const Color green = Colors.green;

  static const Color color_0 = Color.fromRGBO(0, 0, 0, 0.4);
  static const Color color_0_06 = Color.fromRGBO(0, 0, 0, 0.6);

  static const Color color_60 = Color.fromRGBO(60, 60, 60, 1);
  static const Color color_225 = Color.fromRGBO(225, 225, 225, 1);
  static const Color color_252 = Color.fromRGBO(252, 252, 252, 1);
  static const Color color_238 = Color.fromRGBO(238, 238, 238, 1);
  static const Color color_247 = Color.fromRGBO(247, 247, 247, 1);
  static const Color color_243 = Color.fromRGBO(243, 243, 243, 1);
  static const Color color_164 = Color.fromRGBO(164, 164, 164, 1);
  static const Color color_151 = Color.fromRGBO(151, 151, 151, 1);

  ///女
  static const Color color_255_225_225 = Color.fromRGBO(255, 225, 225, 1);

  ///男
  static const Color color_219_237_255 = Color.fromRGBO(219, 237, 255, 1);

  ///导航渐变
  static const Color color_255_179_93 = Color.fromRGBO(255, 179, 93, 1);
  static const Color color_255_154_92 = Color.fromRGBO(255, 154, 92, 1);
  static const Color color_255_220_200 = Color.fromRGBO(255, 220, 200, 1);
  static const Color color_255_247_242 = Color.fromRGBO(255, 247, 242, 1);
  static const Color color_255_247_239 = Color.fromRGBO(255, 247, 239, 1);
  static const Color color_255_127_75 = Color.fromRGBO(255, 127, 75, 0.3);

  static const Color color_251_98_64 = Color.fromRGBO(251, 98, 64, 1);
  static const Color color_76_76_76 = Color.fromRGBO(76, 76, 76, 1);

  static const Color tabbar_select = Color.fromRGBO(17, 150, 219, 1);
  static const Color tabbar_noselect = Color(0xFF606266);

  static const Color color303133 = Color(0xff303133);
  static const Color color9E9E9E = Color(0xff9E9E9E);

  static const Color containerColor = Color(0xff172422);
  static const Color titleImp = Color(0xffFFECC8);
  static const Color darkGray = Color(0xff999999);
  static const Color back2 = Color(0xff121314);
}

//测试图片
String imageUrl1 = "https://www.itying.com/images/flutter/1.png";
String imageUrl2 = "https://www.itying.com/images/flutter/2.png";
String imageUrl3 = "https://www.itying.com/images/flutter/3.png";
String imageUrl4 = "https://www.itying.com/images/flutter/4.png";
String imageUrl5 = "https://www.itying.com/images/flutter/5.png";
String imageUrl6 = "https://www.itying.com/images/flutter/6.png";

String defaultHeadImg =
    "https://p1.itc.cn/q_70/images03/20220612/177aacda6b4f44b59bc3e2bdda0c7ddb.jpeg";
