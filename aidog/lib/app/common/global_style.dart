import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class HooTextStyle {
  static TextStyle appBarTitleBStyle = TextStyle(
    color: KTColor.color303133,
    fontWeight: FontWeight.w600,
    fontSize: ScreenAdapter.fontSize(36),
    inherit: true,
  );

  static TextStyle titleS32W6CBlackStyle = TextStyle(
    color: KTColor.black,
    fontWeight: FontWeight.w300,
    fontSize: ScreenAdapter.fontSize(32),
  );
}
