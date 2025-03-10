import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/storage.dart';
import 'package:aidog/app/pages/login/login_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/showBottomSheet/show_cus_bottom_sheet_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          _appBar(),
        ],
      ),
    );
  }

  ///主内容
  Widget _homePage() {
    return Positioned(
      top: ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(88),
      right: 0,
      bottom: 0,
      left: 0,
      child: Container(
        color: KTColor.color_247,
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.getScreenHeight(),
        child: Column(
          children: [
            Container(
              color: KTColor.white,
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(220),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      AALog("切换角色");
                      NavigationUtil.getInstance()
                          .pushNamed(RoutersName.myChoeseRolePage);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: padding_30,
                        right: padding_30,
                        top: padding_30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "切换角色",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: ScreenAdapter.width(60),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: padding_30,
                  ),
                  Divider(
                    color: KTColor.color_225,
                    height: ScreenAdapter.width(0.5),
                    indent: ScreenAdapter.width(30),
                  ),
                  InkWell(
                    onTap: () {
                      AALog("退出登录");
                      ShowCusBottomSheetTool().cusBottomSheet(
                        context,
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: ScreenAdapter.getScreenWidth(),
                          height: ScreenAdapter.height(360),
                          decoration: BoxDecoration(
                            color: KTColor.color_225,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(padding_30),
                              topRight: Radius.circular(padding_30),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.only(
                                //   left: padding_40,
                                //   top: padding_50,
                                //   right: padding_40,
                                //   bottom: padding_60,
                                // ),
                                color: KTColor.white,
                                width: ScreenAdapter.getScreenWidth(),
                                height: ScreenAdapter.height(147),
                                child: Text(
                                  "确认退出该账号吗?下次仍可使用手机号登录该账号。",
                                  style: TextStyle(
                                    color: KTColor.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(28),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenAdapter.width(1),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: KTColor.white,
                                width: ScreenAdapter.getScreenWidth(),
                                height: ScreenAdapter.height(98),
                                child: TextButton(
                                  onPressed: () {
                                    AALog("退出登录 ");
                                    Navigator.pop(context);

                                    EasyLoading.show(status: "正在退出...");
                                    LoginApi.loginOut(
                                      onSuccess: (data) {
                                        //移除所有数据
                                        Storage.removeAll();
                                        EasyLoading.dismiss();
                                        GlobalLocationTool().destroyLocation();

                                        NavigationUtil.getInstance()
                                            .pushAndRemoveUtil(
                                          context,
                                          RoutersName.loginPage,
                                          widget: const LoginPage(),
                                        );
                                        // NavigationUtil.getInstance()
                                        //     .pushAndRemoveUtilPage(
                                        //         context, RoutersName.loginPage,
                                        //         widget: LoginPage());

                                        // NavigationUtil.getInstance().pushPage(
                                        //   context,
                                        //   RoutersName.loginPage,
                                        //   widget: const LoginPage(),
                                        // );
                                      },
                                      onFailure: (error) {
                                        EasyLoading.dismiss();
                                      },
                                    );
                                  },
                                  child: Text(
                                    "退出登录",
                                    style: TextStyle(
                                      color: KTColor.color_251_98_64,
                                      fontSize: ScreenAdapter.fontSize(32),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.center,
                                color: KTColor.white,
                                width: ScreenAdapter.getScreenWidth(),
                                height: ScreenAdapter.height(98),
                                child: TextButton(
                                  onPressed: () {
                                    AALog("取消");
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "取消",
                                    style: TextStyle(
                                      color: KTColor.black,
                                      fontSize: ScreenAdapter.fontSize(32),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: padding_30,
                        right: padding_30,
                        top: padding_30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "退出登录",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: ScreenAdapter.width(60),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 自定义导航栏
  Widget _appBar() {
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
                  // color: KTColor.red,
                  padding: EdgeInsets.only(left: padding_30),
                  alignment: Alignment.centerRight,
                  // child: const Icon(
                  //   Icons.arrow_back_ios,
                  // ),
                  child: Image.asset(
                    width: padding_45,
                    height: padding_45,
                    'assets/left_back.png',
                  ),
                ),
              ),
            ],
          ),
          // leadingWidth: padding_50,
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '设置',
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
      ),
    );
  }
}
