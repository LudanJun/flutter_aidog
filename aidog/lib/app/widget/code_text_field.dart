import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///验证码输入框
class CodeTextField extends StatefulWidget {
  /// 提示内容必传
  final String? hintText;

  /// 输入类型
  final TextInputType? keyboardType;

  /// 设置圆角
  double? radius = 0.0;

  /// 外部调用改变的方法
  final void Function(String)? onChanged;

  final TextEditingController? controller;

  CodeTextField({
    super.key,
    this.hintText,
    this.keyboardType = TextInputType.number,
    this.onChanged,
    this.controller,
    this.radius,
  });

  @override
  State<CodeTextField> createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<CodeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ScreenAdapter.height(90),
      margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
      padding: EdgeInsets.only(
        left: ScreenAdapter.width(30),
        right: ScreenAdapter.width(30),
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(34, 114, 113, 133),
        borderRadius: BorderRadius.circular(widget.radius ?? 0.0), //设置圆角
      ),
      child: TextField(
        autofocus: true, //到这个页面直接响应输入框相当于 swift的第一下响应者
        controller: widget.controller, //定义一个controller 让外界获取文本框的数据
        obscureText: true, //是否显示密码
        style: TextStyle(
          fontSize: ScreenAdapter.fontSize(32), //设置字体大小
        ),
        keyboardType: widget.keyboardType, //默认弹出数字键盘
        decoration: InputDecoration(
          hintText: widget.hintText, //文本框提示信息
          hintStyle: const TextStyle(
            color: Colors.grey, //设置提示文字颜色
          ),
          border: InputBorder.none, //去掉下划线
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), //设置只允许输入数字
          LengthLimitingTextInputFormatter(6) //限制长度
        ],
        onChanged: widget.onChanged,
      ),
    );
  }
}
