import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

typedef ButtonTapCallback = void Function();

class CusOutlineButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final ButtonTapCallback onTap;
  const CusOutlineButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin_30),
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: () {
          AALog("按钮被点击");
          onTap();
        },
        style: OutlinedButton.styleFrom(
          // 设置内边距为较小的值，例如上下0像素，左右4像素
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 0,
          ),

          side: const BorderSide(
            width: 1,
            color: KTColor.color_251_98_64,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: ScreenAdapter.fontSize(24),
              fontWeight: FontWeight.w600,
              color: KTColor.color_251_98_64),
        ),
      ),
    );
  }
}
