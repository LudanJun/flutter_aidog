import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef SexRadioTapCallback = void Function(int index);

/// 男女生按钮
class SexRadioButton extends StatefulWidget {
  final String title;
  String? imagStr = '';
  final int index;
  Color? bgColor;
  final double width;
  final double height;
  final SexRadioTapCallback onTap;
  SexRadioButton({
    super.key,
    required this.index,
    required this.onTap,
    required this.title,
    this.imagStr,
    required this.width,
    required this.height,
    this.bgColor,
  });

  @override
  State<SexRadioButton> createState() => _SexRadioButtonState();
}

class _SexRadioButtonState extends State<SexRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Provider.of<LoginProvider>(context, listen: false).selectRole =
        //     widget.index;
        // AALog(Provider.of<LoginProvider>(context, listen: false).selectRole);
        // widget.onTap(
        //     Provider.of<LoginProvider>(context, listen: false).selectRole);
        setState(() {
          widget.onTap(widget.index);
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(
            ScreenAdapter.width(40),
          ),
        ),
        child: Row(
          // mainAxisAlignment: widget.imagStr == ''
          //     ? MainAxisAlignment.center
          //     : MainAxisAlignment.center,
          children: [
            SizedBox(
              width: padding_20,
            ),
            if (widget.imagStr != '')
              Image.asset(
                AssetUtils.getAssetImagePNG(widget.imagStr ?? ''),
                width: ScreenAdapter.width(36),
                height: ScreenAdapter.width(36),
              ),
            SizedBox(
              width: padding_10,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: KTColor.color_60,
                fontWeight: FontWeight.w300,
                fontSize: ScreenAdapter.fontSize(26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
