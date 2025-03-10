import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

/// 养狗经验 切换
class MyChooseDogExpPage extends StatefulWidget {
  //传入值
  final int value;
  const MyChooseDogExpPage({super.key, required this.value});

  @override
  State<MyChooseDogExpPage> createState() => _MyChooseDogExpPageState();
}

class _MyChooseDogExpPageState extends State<MyChooseDogExpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "养狗经验"),
        ],
      ),
    );
  }

  // void updateData(){
  //      //更新人物信息
  //   LoginApi.publickSettingInfo(
  //     //养狗经验
  //     experience: _myUserInfoModel.data?.experience,

  //     onSuccess: (data) {
  //       AALog("onSuccess:$data");
  //       GlobalLocationTool().destroyLocation();

  //       if (data['code'] == "200") {
  //         setState(() {});
  //       }
  //     },
  //     onFailure: (error) {
  //       AALog("onSuccess:$error");
  //     },
  //   );
  // }

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
              height: ScreenAdapter.height(260),
              child: Column(
                children: [
                  //1.
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectDogExpValue = "无经验";
                        AALog(
                            "无经验:${Provider.of<MyProvider>(context, listen: false).selectDogExpValue}");

                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("无经验");
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
                            "无经验",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectDogExpValue ==
                              "无经验")
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
                  //2.
                  InkWell(
                    onTap: () async {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectDogExpValue = "新手";
                        AALog(
                            "新手:${Provider.of<MyProvider>(context, listen: false).selectDogExpValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss(); //返回带的数据
                              Navigator.of(context).pop("新手");
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
                            "新手",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectDogExpValue ==
                              "新手")
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
                  //3.
                  InkWell(
                    onTap: () async {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectIdentityValue = "老手";
                        AALog(
                            "老手:${Provider.of<MyProvider>(context, listen: false).selectDogExpValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("老手");
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
                            "老手",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectDogExpValue ==
                              "老手")
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
