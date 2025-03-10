import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///一般文本框
class NormalTextField extends StatelessWidget {
  /// 是否显示密码
  final bool isPassWord;
  //宽度
  final double? width;
  //高度
  final double? height;

  /// 提示内容必传
  final String? hintText;

  /// 背景色
  final Color? bgColor;

  /// 文字颜色
  final Color? textColor;

  ///  文字字体大小
  final double? textFontSize;

  /// 文字字重
  final FontWeight? textFontWeight;

  /// 设置圆角
  double? radius = 0.0;

  /// 内容居中样式
  final TextAlign textAlign;

  /// 提示颜色
  final Color? hintColor;

  ///  提示文字字体大小
  final double? hintFontSize;

  /// 提示文字字重
  final FontWeight? hintFontWeight;

  /// 输入类型
  final TextInputType? keyboardType;
  //限制规则
  final List<TextInputFormatter>? inputFormatters;

  /// 外部调用改变的方法
  final void Function(String)? onChanged;

  final TextEditingController? controller;

  NormalTextField({
    super.key,
    this.isPassWord = false,
    this.hintText,
    this.keyboardType = TextInputType.number,
    this.onChanged,
    this.controller,
    this.radius,
    required this.textAlign,
    this.hintColor,
    this.bgColor,
    this.textColor,
    this.hintFontWeight,
    this.hintFontSize,
    this.textFontSize,
    this.textFontWeight,
    this.width,
    this.height,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   padding: EdgeInsets.zero,
        //   alignment: Alignment.center,
        //   width: width,
        //   height: height,
        //   // margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
        //   // padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
        //   decoration: BoxDecoration(
        //     color: bgColor,
        //     borderRadius: BorderRadius.circular(radius ?? 0.0), //设置圆角
        //   ),
        //   child:

        TextField(
      scrollPadding: EdgeInsets.zero,
      textAlign: textAlign,
      autofocus: false, //到这个页面直接响应输入框相当于 swift的第一下响应者
      controller: controller, //定义一个controller 让外界获取文本框的数据
      obscureText: isPassWord, //是否显示密码
      cursorColor: KTColor.color_251_98_64, //设置光标的颜色
      // cursorHeight: ScreenAdapter.width(30), //设置光标的高度
      style: TextStyle(
        color: textColor,
        fontSize: textFontSize, //设置字体大小
        fontWeight: textFontWeight,
      ),
      keyboardType: keyboardType, //默认弹出数字键盘
      decoration: InputDecoration(
        hintText: hintText, //文本框提示信息
        hintStyle: TextStyle(
          color: hintColor, //设置提示文字颜色
          fontSize: hintFontSize,
          fontWeight: hintFontWeight,
        ),
        border: InputBorder.none, //去掉下划线
      ),
      inputFormatters: inputFormatters,
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), //设置只允许输入数字
      //   LengthLimitingTextInputFormatter(11) //限制长度
      // ],
      onChanged: onChanged,
    );
    // );
  }
}
