import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

///宠主 身份切换
class MyPetChooseIdentityPage extends StatefulWidget {
  const MyPetChooseIdentityPage({super.key});

  @override
  State<MyPetChooseIdentityPage> createState() =>
      _MyPetChooseIdentityPageState();
}

class _MyPetChooseIdentityPageState extends State<MyPetChooseIdentityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "身份"),
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
                            .selectPetIdentityValue = "学生党";
                        AALog(
                            "学生党:${Provider.of<MyProvider>(context, listen: false).selectPetIdentityValue}");

                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("学生党");
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
                            "学生党",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetIdentityValue ==
                              "学生党")
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
                            .selectPetIdentityValue = "上班族";
                        AALog(
                            "上班族:${Provider.of<MyProvider>(context, listen: false).selectPetIdentityValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss(); 
                              Navigator.of(context).pop("上班族");
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
                            "上班族",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetIdentityValue ==
                              "上班族")
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
                            .selectPetIdentityValue = "自由职业";
                        AALog(
                            "自由职业:${Provider.of<MyProvider>(context, listen: false).selectPetIdentityValue}");
                        EasyLoading.show(status: '切换中...');
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            if (mounted) {
                              EasyLoading.dismiss();
                              //返回带的数据
                              Navigator.of(context).pop("自由职业");
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
                            "自由职业",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetIdentityValue ==
                              "自由职业")
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
