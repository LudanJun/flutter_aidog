import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

/// 自定义 实心按钮
class CusElevatedButton extends StatelessWidget {
  final String title; //按钮文字
  final double width; //按钮宽度
  final double height; //按钮高度
  final void Function() onPressed; //外部调用按钮的方法

  const CusElevatedButton(
      {super.key,
      required this.title,
      required this.width,
      required this.height,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(width),
      height: ScreenAdapter.width(height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          //设置按钮背景色
          backgroundColor: WidgetStateProperty.all(
            KTColor.color_251_98_64,
          ),
          //设置按钮文字颜色
          foregroundColor: WidgetStateProperty.all(
            KTColor.white,
          ),
          //设置按钮圆角
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenAdapter.height(30),
              ),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: ScreenAdapter.fontSize(36),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
