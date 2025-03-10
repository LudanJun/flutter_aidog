import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/global_provider/global_net_provider.dart';
import 'package:aidog/app/global_provider/global_provider.dart';
import 'package:aidog/app/pages/home/home_page.dart';
import 'package:aidog/app/pages/message/message_page.dart';
import 'package:aidog/app/pages/my/my_page.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  final List<Widget> tabbarlist = const [
    HomePage(),
    MessagePage(),
    MyPage(),
  ];
  @override
  void initState() {
    super.initState();
    //检测网络
    final GlobalNetProvider globalNetProvider =
        Provider.of<GlobalNetProvider>(context, listen: false);
    globalNetProvider.startNetEventStream();

    ///
    // Provider.of<GlobalProvider>(context, listen: false).initConnectivity;

    GlobalLocationTool().locationResultListen((map) {
      AALog("监听的定位信息:$map");
      // setState(() {
      // _latitude = map["latitude"].toString();
      // _longitude = map["longitude"].toString();
      Provider.of<GlobalProvider>(context, listen: false).globalDesressStr =
          map["description"].toString();
      // });
    });
  }

  @override
  void dispose() {
    GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabbarlist,
      ),
      backgroundColor: KTColor.white,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: KTColor.white),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            _initTabItem('tabbar_home_normal', 'tabbar_home_select', "首页"),
            _initTabItem(
                'tabbar_message_normal', 'tabbar_message_select', "消息"),
            _initTabItem('tabbar_my_normal', 'tabbar_my_select', "我的"),
          ],
          backgroundColor: KTColor.white,
          unselectedItemColor: KTColor.tabbar_noselect,
          selectedFontSize: ScreenAdapter.fontSize(22),
          unselectedFontSize: ScreenAdapter.fontSize(22),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              if (_currentIndex != index) {
                _currentIndex = index;
                AALog("选择的是$index");
              }
            });
          },
        ),
      ),
    );
  }

  /// 初始化baritem
  /// iconName:默认图片名字
  /// activeIconName:选中图片名字
  /// title:标题
  BottomNavigationBarItem _initTabItem(
    String iconName,
    String activeIconName,
    String title,
  ) =>
      BottomNavigationBarItem(
        icon: tabbarItemImage(
          iconName,
          iconColor: Colors.black,
        ),
        activeIcon: tabbarItemImage(
          activeIconName,
        ),
        label: title,
      );
}

Widget tabbarItemImage(
  String iconName, {
  double width = 22,
  double height = 22,
  Color? color,
  Color? iconColor,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  Decoration? decoration,
}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(5),
    margin: margin,
    color: color,
    decoration: decoration,
    child: Image.asset(
      AssetUtils.getAssetImagePNG(iconName),
      width: width,
      height: height,
      color: iconColor,
    ),
  );
}
