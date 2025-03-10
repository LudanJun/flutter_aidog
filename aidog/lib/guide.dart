import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class GuidePage extends StatelessWidget {
  GuidePage({super.key});

  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      mainImage: Image.asset(
        AssetUtils.getAssetImagePNG("mn"), //根据图片大小来显示
        // alignment: Alignment.topLeft,
      ),
      // title: Text("第一页"),
      body: Text("阿萨德回家啊好的好哦啊山东阿萨德哈好的哦啊搜单号哦"),
    ),
    PageViewModel(
      pageColor: Colors.blueAccent,
      mainImage: Image.asset(
        AssetUtils.getAssetImagePNG("guide.two"),
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.getScreenHeight(),
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
      // title: Text("第二页"),
      body: Text(""),
    ),
    PageViewModel(
      pageColor: Colors.blueAccent,
      mainImage: Image.asset(
        AssetUtils.getAssetImagePNG("guide.three"),
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.getScreenHeight(),
        alignment: Alignment.center,
      ),
      // title: Text("第三页"),
      body: Text("sss"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          //路由跳转
          // Navigator.of(context).pushReplacementNamed('/');
          NavigationUtil.getInstance()
              .pushReplacementNamed(RoutersName.loginPage);
        },
        showSkipButton: true,
        skipText: Text('跳过'),
        doneText: Text('完成'),
        pageButtonTextStyles: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }
}
