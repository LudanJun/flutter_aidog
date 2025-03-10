import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PassTextField extends StatelessWidget {
  /// 是否显示密码
  final bool isPassWord;

  final double? height;

  /// 提示内容必传
  final String? hintText;

  /// 设置圆角
  double? radius = 0.0;

  /// 右侧按钮
  final Widget? rightWidget;

  /// 输入类型
  final TextInputType? keyboardType;

  /// 外部调用点击改变的方法
  final void Function(String)? onChanged;

  final void Function()? onCloseChanged;

  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  PassTextField({
    super.key,
    this.isPassWord = false,
    this.hintText,
    this.height,
    this.keyboardType = TextInputType.number,
    this.onChanged,
    this.controller,
    this.radius,
    this.onCloseChanged,
    this.inputFormatters,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height, //ScreenAdapter.width(90),
      margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
      padding: EdgeInsets.only(
        left: ScreenAdapter.width(30),
        right: ScreenAdapter.width(30),
      ),
      decoration: BoxDecoration(
        color: KTColor.white,
        borderRadius: BorderRadius.circular(radius ?? 0.0), //设置圆角
      ),
      child: TextField(
        textAlign: TextAlign.start,
        autofocus: true, //到这个页面直接响应输入框相当于 swift的第一下响应者
        controller: controller, //定义一个controller 让外界获取文本框的数据
        obscureText: isPassWord, //是否显示密码
        style: TextStyle(
          fontSize: ScreenAdapter.fontSize(32), //设置字体大小
          fontWeight: FontWeight.w300,
        ),
        keyboardType: keyboardType, //默认弹出数字键盘
        decoration: InputDecoration(
          hintText: hintText, //文本框提示信息
          hintStyle: TextStyle(
            color: KTColor.color_164, //设置提示文字颜色
            fontWeight: FontWeight.w300,
            fontSize: ScreenAdapter.fontSize(32),
          ),
          border: InputBorder.none, //去掉下划线
          // 右侧图标
          suffixIcon: rightWidget,
        ),
        inputFormatters: inputFormatters,
        //  [
        //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), //设置只允许输入数字
        //   LengthLimitingTextInputFormatter(11) //限制长度
        // ],
        onChanged: onChanged,
      ),
    );
  }
}
