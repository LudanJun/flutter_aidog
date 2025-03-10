import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  /// 导航标题
  final String title;
  const BaseAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //渐变位置
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              KTColor.color_255_179_93,
              KTColor.color_255_154_92,
            ],
          ),
        ),
        child: AppBar(
          leading: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.only(left: padding_30),
                  alignment: Alignment.centerRight,
                  // color: KTColor.red,
                  child: Image.asset(
                    width: padding_45,
                    height: padding_45,
                    'assets/left_back.png',
                  ),
                  // child: const Icon(
                  //   Icons.arrow_back_ios_new,
                  // ),
                ),
              ),
            ],
          ),
          leadingWidth: ScreenAdapter.width(80),
          title: Container(
            // color: KTColor.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: KTColor.color_60,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(36),
                  ),
                ),
                SizedBox(
                  width: padding_70,
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent, //实现背景透明
        ),
        /*
         AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: KTColor.red,
              margin: EdgeInsets.only(left: padding_30),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          leadingWidth: padding_50,
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: KTColor.color_60,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenAdapter.fontSize(36),
                  ),
                ),
                SizedBox(
                  width: padding_50,
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent, //实现背景透明
        ),
        */
      ),
    );
  }
}
