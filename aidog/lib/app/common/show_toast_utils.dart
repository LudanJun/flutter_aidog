import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 顶部显示toast
/// 使用: showToastTop(error);
showToastTop(String msg, {Color? bgColor, bool? toastLength}) async {
  await Fluttertoast.cancel(); //防止toast频繁触发
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP, //显示位置
      textColor: Colors.white,
      fontSize: ScreenAdapter.fontSize(26),
      toastLength: toastLength == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: bgColor ?? KTColor.color_0_06);
}

/// 中间显示toast
/// 使用: showToastCenter(error);
showToastCenter(String msg, {Color? bgColor, bool? toastLength}) async {
  await Fluttertoast.cancel(); //防止toast频繁触发
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: ScreenAdapter.fontSize(26),
      toastLength: toastLength == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: bgColor ?? KTColor.color_0_06);
}

/// 底部显示toast
/// 使用: showToastBottom(error);
showToastBottom(String msg, {Color? bgColor, bool? toastLength}) async {
  await Fluttertoast.cancel(); //防止toast频繁触发
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: ScreenAdapter.fontSize(26),
      toastLength: toastLength == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: bgColor ?? KTColor.color_0_06);
}
