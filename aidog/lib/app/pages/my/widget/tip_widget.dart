import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class TipWidget extends StatelessWidget {
  const TipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(60),
      color: KTColor.color_255_220_200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: padding_30,
          ),
          Image(
            width: ScreenAdapter.width(30),
            height: ScreenAdapter.width(30),
            image: AssetImage(
              AssetUtils.getAssetImagePNG('warn_red'),
            ),
          ),
          SizedBox(
            width: padding_20,
          ),
          Text(
            '请如实填写个人信息，建立安全友好的环境',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: ScreenAdapter.fontSize(26),
              color: KTColor.color_251_98_64,
            ),
          ),
        ],
      ),
    );
  }
}
