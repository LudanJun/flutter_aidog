import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

/// 照顾方式选择
class MyChooseZhaogustylePage extends StatefulWidget {
  const MyChooseZhaogustylePage({super.key});

  @override
  State<MyChooseZhaogustylePage> createState() =>
      _MyChooseZhaogustylePageState();
}

class _MyChooseZhaogustylePageState extends State<MyChooseZhaogustylePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "照顾方式"),
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
              height: ScreenAdapter.height(260),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectZhaogufangshiValue = "遛狗";
                        AALog(
                            "遛狗:${Provider.of<MyProvider>(context, listen: false).selectZhaogufangshiValue}");

                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("遛狗");
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
                            "遛狗",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectZhaogufangshiValue ==
                              "遛狗")
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
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectZhaogufangshiValue = "帮养";
                        AALog(
                            "帮养:${Provider.of<MyProvider>(context, listen: false).selectZhaogufangshiValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss(); //返回带的数据
                              Navigator.of(context).pop("帮养");
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
                            "帮养",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectZhaogufangshiValue ==
                              "帮养")
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
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectZhaogufangshiValue = "两者均可";
                        AALog(
                            "两者均可:${Provider.of<MyProvider>(context, listen: false).selectZhaogufangshiValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("两者均可");
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
                            "两者均可",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectZhaogufangshiValue ==
                              "两者均可")
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
