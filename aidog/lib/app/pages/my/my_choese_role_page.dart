import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

///设置 - 切换角色
class MyChoeseRolePage extends StatefulWidget {
  const MyChoeseRolePage({super.key});

  @override
  State<MyChoeseRolePage> createState() => _MyChoeseRolePageState();
}

class _MyChoeseRolePageState extends State<MyChoeseRolePage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  @override
  void initState() {
    super.initState();

    MyApi().userInfo(
      onSuccess: (data) {
        if (data['code'] == '200') {
          setState(() {
            _myUserInfoModel = MyUserInfoModel.fromJson(data);
            setState(() {});
          });
        }
      },
      onFailure: (error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(
            title: "切换角色",
          ),
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
              height: ScreenAdapter.height(180),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectRoleValue = 1;
                        AALog(
                            "宠物主:${Provider.of<MyProvider>(context, listen: false).selectRoleValue}");

                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              /// 选完角色下一步
                              AALog("选完角色下一步");
                              String? role;
                              if (Provider.of<MyProvider>(context,
                                          listen: false)
                                      .selectRoleValue ==
                                  1) {
                                role = '1'; //宠物主
                              } else {
                                role = '2'; //帮养人
                              }
                              MyApi.changeRole(
                                role: role,
                                onSuccess: (data) {
                                  AALog("onSuccess:$data");
                                  _myUserInfoModel =
                                      MyUserInfoModel.fromJson(data);
                                  setState(() {
                                    Provider.of<MyProvider>(context,
                                                listen: false)
                                            .selectRoleValue =
                                        _myUserInfoModel.data?.role ?? 0;
                                  });
                                  //养狗经验为空说明是宠主
                                  if (_myUserInfoModel.data?.dogId != 0) {
                                    showToastCenter('切换宠主成功');
                                    ////登录跳转到tabbar首页
                                    NavigationUtil.getInstance()
                                        .pushAndRemoveUtil(
                                      context,
                                      RoutersName.tabsPage,
                                      widget: const TabsPage(),
                                    );
                                  } else {
                                    //走帮养人设置信息页面
                                    AALog("进入宠主设置界面");
                                    NavigationUtil.getInstance().pushNamed(
                                        RoutersName.myChoosePetOwnerInfoPage);
                                  }
                                },
                                onFailure: (error) {
                                  AALog("onSuccess:$error");
                                  showToastCenter('切换失败');
                                },
                              );

                              EasyLoading.dismiss();
                            }
                          },
                        );
                      });
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
                            "宠物主",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectRoleValue ==
                              1)
                            Image(
                              width: ScreenAdapter.width(27),
                              height: ScreenAdapter.width(21),
                              image: const AssetImage('assets/my_choose.png'),
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
                    onTap: () async {
                      setState(
                        () {
                          Provider.of<MyProvider>(context, listen: false)
                              .selectRoleValue = 2;
                          AALog(
                              "帮养人:${Provider.of<MyProvider>(context, listen: false).selectRoleValue}");
                          EasyLoading.show(status: '切换中...');
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              if (mounted) {
                                String? role;
                                if (Provider.of<MyProvider>(context,
                                            listen: false)
                                        .selectRoleValue ==
                                    1) {
                                  role = '1'; //宠物主
                                } else {
                                  role = '2'; //帮养人
                                }
                                MyApi.changeRole(
                                  role: role,
                                  onSuccess: (data) {
                                    AALog("onSuccess:$data");
                                    _myUserInfoModel =
                                        MyUserInfoModel.fromJson(data);
                                    // showToastCenter('切换成功');
                                    setState(() {
                                      Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .selectRoleValue =
                                          _myUserInfoModel.data?.role ?? 0;
                                    });
                                    if (_myUserInfoModel.data?.experience ==
                                        "") {
                                      //要求设置宠主狗狗信息页面
                                      AALog("要求设置帮养人信息页面");
                                      NavigationUtil.getInstance().pushNamed(
                                          RoutersName
                                              .myChooseHelpOtherInfoPage);
                                    } else {
                                      showToastCenter('切换帮养人成功');
                                      ////登录跳转到tabbar首页
                                      NavigationUtil.getInstance()
                                          .pushAndRemoveUtil(
                                        context,
                                        RoutersName.tabsPage,
                                        widget: const TabsPage(),
                                      );
                                    }
                                  },
                                  onFailure: (error) {
                                    AALog("onSuccess:$error");
                                    showToastCenter('切换失败');
                                  },
                                );
                                EasyLoading.dismiss();
                              }
                            },
                          );
                        },
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
                            "帮养人",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectRoleValue ==
                              2)
                            Image(
                              width: ScreenAdapter.width(27),
                              height: ScreenAdapter.width(21),
                              image: const AssetImage('assets/my_choose.png'),
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
}
