import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

//选择狗狗性别
class MyPetChooseDogSexPage extends StatefulWidget {
  const MyPetChooseDogSexPage({super.key});

  @override
  State<MyPetChooseDogSexPage> createState() => _MyPetChooseDogSexPageState();
}

class _MyPetChooseDogSexPageState extends State<MyPetChooseDogSexPage> {
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
                  //1.
                  InkWell(
                    onTap: () {
                      setState(() {
                        Provider.of<MyProvider>(context, listen: false)
                            .selectPetDogSexValue = "妹妹";
                        AALog(
                            "妹妹:${Provider.of<MyProvider>(context, listen: false).selectPetDogSexValue}");

                        //返回带的数据
                        Navigator.of(context).pop("妹妹");
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
                            "妹妹",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetDogSexValue ==
                              "妹妹")
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
                            .selectPetDogSexValue = "弟弟";
                        AALog(
                            "弟弟:${Provider.of<MyProvider>(context, listen: false).selectPetDogSexValue}");
                        //返回带的数据
                        Navigator.of(context).pop("弟弟");
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
                            "弟弟",
                            style: TextStyle(
                              color: KTColor.black,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .selectPetDogSexValue ==
                              "弟弟")
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
