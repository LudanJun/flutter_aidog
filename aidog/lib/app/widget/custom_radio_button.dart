import 'dart:ui';

import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CustomRadioTapCallback = void Function(int index);

/// 自定义选择按钮
class CustomRadioButton extends StatefulWidget {
  final int index;
  final CustomRadioTapCallback onTap;

  const CustomRadioButton(
      {super.key, required this.index, required this.onTap});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          Provider.of<LoginProvider>(context, listen: false).selectRole =
              widget.index;
          AALog(Provider.of<LoginProvider>(context, listen: false).selectRole);
          widget.onTap(
              Provider.of<LoginProvider>(context, listen: false).selectRole);
        });
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center, //上下
        // crossAxisAlignment: CrossAxisAlignment.center, //左右
        children: [
          Text("分享狗狗的爱"),
          Center(
            child:
            Container(
              width: ScreenAdapter.width(150),
              height: ScreenAdapter.width(150),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: (Provider.of<LoginProvider>(context, listen: true)
                              .selectRole ==
                          widget.index)
                      ? ScreenAdapter.width(5)
                      : 0,
                  color: (Provider.of<LoginProvider>(context, listen: true)
                              .selectRole ==
                          widget.index)
                      ? KTColor.orange
                      : Colors.transparent,
                ),
              ),
              child: const CircleAvatar(
                // radius: ScreenAdapter.width(80),
                backgroundImage: NetworkImage(
                    "https://img0.baidu.com/it/u=1641416437,1150295750&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800"),
              ),
            ),
          ),
          Text("宠主"),
        ],
      ),
    );
  }
}
