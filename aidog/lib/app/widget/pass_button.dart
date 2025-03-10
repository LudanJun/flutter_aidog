import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class PassButton extends StatelessWidget {
  final String text; //文本
  final double? width;
  final double height;
  final Color? bgColor;
  final void Function()? onPressed; //外部调用按钮的方法

  const PassButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.height,
      this.width,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   alignment: Alignment.center,
        //   // margin: EdgeInsets.only(
        //   //   top: ScreenAdapter.height(20),
        //   // ),
        //   width: width,
        //   height: height,
        //   child:
        ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        //阴影
        elevation: WidgetStateProperty.all(0),
        //设置按钮背景色
        backgroundColor: WidgetStateProperty.all(
          bgColor, //KTColor.color_251_98_64,
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
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontSize: ScreenAdapter.fontSize(36),
          color: KTColor.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // );
  }
}
