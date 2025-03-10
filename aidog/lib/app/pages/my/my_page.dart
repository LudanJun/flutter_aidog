import 'dart:async';

import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();
  @override
  void initState() {
    super.initState();

    MyApi().userInfo(
      onSuccess: (data) {
        if (data['code'] == "200") {
          setState(() {
            _myUserInfoModel = MyUserInfoModel.fromJson(data);
            Provider.of<MyProvider>(context, listen: false).selectRoleValue =
                _myUserInfoModel.data?.role ?? 1;
          });
        }
      },
      onFailure: (error) {
        AALog("error $error");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.getScreenHeight(),
        color: KTColor.color_252,
        child: Stack(
          children: [
            Container(
              child: Image(
                width: ScreenAdapter.getScreenWidth(),
                height: ScreenAdapter.width(289),
                image: AssetImage('assets/my_top_bg.png'),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: ScreenAdapter.height(88),
              child: Container(
                child: Image(
                  width: ScreenAdapter.getScreenWidth(),
                  image: AssetImage('assets/my_main_bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenAdapter.height(95),
                  ),
                  Container(
                    child: CircleAvatar(
                      radius: ScreenAdapter.width(80),
                      backgroundImage: _myUserInfoModel.data?.avatar != ""
                          ? CachedNetworkImageProvider(
                              _myUserInfoModel.data?.avatar ?? "")
                          : AssetImage(
                              AssetUtils.getAssetImagePNG('default_head_img'),
                            ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: KTColor.color_251_98_64
                              .withOpacity(0.5), // 阴影颜色，可以通过opacity参数调整透明度
                          blurRadius: 20, // 阴影的模糊度
                          offset: Offset(0.5, 0.5), // 阴影的偏移距离
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(30),
                  ),
                  Text(
                    _myUserInfoModel.data?.nickname ?? "",
                    style: TextStyle(
                      color: KTColor.black,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.fontSize(32),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.width(16),
                  ),
                  Text(
                    '用户ID：67875456765',
                    style: TextStyle(
                      color: KTColor.color_76_76_76,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenAdapter.fontSize(26),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //帮养信息
                      InkWell(
                        onTap: () {
                          AALog('帮养信息');

                          ///帮养人-帮养信息
                          // NavigationUtil.getInstance()
                          //     .pushNamed(RoutersName.myHelpOtherProfilePage);

                          ///宠主- 帮养人信息
                          NavigationUtil.getInstance()
                              .pushNamed(RoutersName.myPetOwnerProfilePage);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: padding_30,
                            right: padding_10,
                          ),
                          width: ScreenAdapter.getScreenWidth() / 2 -
                              padding_30 -
                              padding_10,
                          height: ScreenAdapter.width(183),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: KTColor.white,
                            borderRadius: BorderRadius.circular(padding_25),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: ScreenAdapter.width(28),
                                top: 0,
                                child: Image(
                                  width: ScreenAdapter.width(80),
                                  height: ScreenAdapter.width(80),
                                  image: AssetImage(
                                      'assets/my_help_owner_info.png'),
                                ),
                              ),
                              Positioned(
                                left: ScreenAdapter.width(138),
                                top: ScreenAdapter.width(39),
                                child: Text(
                                  "帮养信息",
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(28),
                                    color: KTColor.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: ScreenAdapter.width(138),
                                top: ScreenAdapter.width(80),
                                right: ScreenAdapter.width(25),
                                child: Text(
                                  "完善信息有助于被帮养人发现",
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(24),
                                    color: KTColor.color_76_76_76,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //帮养评价
                      Container(
                        margin: EdgeInsets.only(
                          right: padding_30,
                          left: padding_10,
                        ),
                        width: ScreenAdapter.getScreenWidth() / 2 -
                            padding_30 -
                            padding_10,
                        height: ScreenAdapter.width(183),
                        decoration: BoxDecoration(
                          color: KTColor.white,
                          borderRadius: BorderRadius.circular(padding_25),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: ScreenAdapter.width(16),
                              top: -ScreenAdapter.width(10),
                              child: Image(
                                width: ScreenAdapter.width(80),
                                height: ScreenAdapter.width(80),
                                image:
                                    AssetImage('assets/my_help_evaluate.png'),
                              ),
                            ),
                            Positioned(
                              left: ScreenAdapter.width(138),
                              top: ScreenAdapter.width(39),
                              child: Text(
                                "帮养评价",
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(28),
                                  color: KTColor.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              left: ScreenAdapter.width(138),
                              top: ScreenAdapter.width(80),
                              right: ScreenAdapter.width(25),
                              child: Text(
                                "感谢你的善良让你闪闪发光",
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(24),
                                  color: KTColor.color_76_76_76,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenAdapter.width(34),
                  ),
                  //列表
                  Column(
                    children: [
                      /*
                      ///我的喜欢 - 后期打开
                      InkWell(
                        onTap: () {
                          AALog('我的喜欢');
                          NavigationUtil.getInstance()
                              .pushNamed(RoutersName.myLikePage);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: padding_30, right: padding_30),
                          decoration: BoxDecoration(
                            color: KTColor.white,
                            borderRadius: BorderRadius.circular(padding_10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenAdapter.width(27),
                                  top: ScreenAdapter.width(16),
                                  right: ScreenAdapter.width(23),
                                  bottom: ScreenAdapter.width(26),
                                ),
                                child: Image(
                                  width: ScreenAdapter.width(48),
                                  height: ScreenAdapter.width(48),
                                  image: AssetImage('assets/my_like.png'),
                                ),
                              ),
                              Text(
                                '我的喜欢',
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(28),
                                  color: KTColor.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: ScreenAdapter.width(60),
                              ),
                              SizedBox(
                                width: padding_10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      */

                      InkWell(
                        onTap: () {
                          AALog('设置');

                          ///
                          NavigationUtil.getInstance()
                              .pushNamed(RoutersName.mySettingPage);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: padding_30, right: padding_30),
                          decoration: BoxDecoration(
                            color: KTColor.white,
                            borderRadius: BorderRadius.circular(padding_10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScreenAdapter.width(27),
                                  top: ScreenAdapter.width(16),
                                  right: ScreenAdapter.width(23),
                                  bottom: ScreenAdapter.width(26),
                                ),
                                child: Image(
                                  width: ScreenAdapter.width(48),
                                  height: ScreenAdapter.width(48),
                                  image: AssetImage('assets/my_setting.png'),
                                ),
                              ),
                              Text(
                                '设置',
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(28),
                                  color: KTColor.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: ScreenAdapter.width(60),
                              ),
                              SizedBox(
                                width: padding_10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
