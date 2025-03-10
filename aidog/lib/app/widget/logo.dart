import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(ScreenAdapter.width(40)),
      child: Container(
        width: ScreenAdapter.width(150),
        height: ScreenAdapter.width(150),
        child: Image.asset(
          AssetUtils.getAssetImagePNG('logo'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
