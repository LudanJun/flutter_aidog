import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPetChooseKuangyimiaoPage extends StatefulWidget {
  const MyPetChooseKuangyimiaoPage({super.key});

  @override
  State<MyPetChooseKuangyimiaoPage> createState() =>
      _MyPetChooseKuangyimiaoPageState();
}

class _MyPetChooseKuangyimiaoPageState
    extends State<MyPetChooseKuangyimiaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "狂犬疫苗"),
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
                            .selectPetDogKuangquanyimiaoValue = "已注射";
                        AALog(
                            "已注射:${Provider.of<MyProvider>(context, listen: false).selectPetDogKuangquanyimiaoValue}");

                        //返回带的数据
                        Navigator.of(context).pop("已注射");
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
                            "已注射",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetDogKuangquanyimiaoValue ==
                              "已注射")
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
                            .selectPetDogKuangquanyimiaoValue = "暂未";
                        AALog(
                            "暂未:${Provider.of<MyProvider>(context, listen: false).selectPetDogKuangquanyimiaoValue}");
                        Navigator.of(context).pop("暂未");
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
                            "暂未",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetDogKuangquanyimiaoValue ==
                              "暂未")
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
