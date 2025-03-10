import 'package:aidog/app/common/asset_utils.dart';
import 'package:flutter/material.dart';

///默认轮播图
defaultBannerImage() {
  return Image.asset(
    AssetUtils.getAssetImagePNG(
      'splash',
    ),
    fit: BoxFit.cover,
    // width: ScreenAdapter.getScreenWidth(),
    // height: ScreenAdapter.height(340),
  );
}

defaultCommunityDetailImage() {
  return Image.asset(
    AssetUtils.getAssetImagePNG(
      'default_zjl',
    ),
    fit: BoxFit.cover,
    // width: ScreenAdapter.getScreenWidth(),
    // height: ScreenAdapter.height(255),
  );
}

defaultHeadImage() {
  return Image.asset(
    AssetUtils.getAssetImagePNG(
      'default_zjl',
    ),
    fit: BoxFit.cover,
    // width: ScreenAdapter.getScreenWidth(),
    // height: ScreenAdapter.height(255),
  );
}
