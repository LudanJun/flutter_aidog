import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/storage.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/widget/outline_choese_button.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 角色选择
class LoginSelectRolePage extends StatefulWidget {
  const LoginSelectRolePage({super.key});

  @override
  State<LoginSelectRolePage> createState() => _LoginSelectRolePageState();
}

class _LoginSelectRolePageState extends State<LoginSelectRolePage> {

  ///设置选择的角色值
  ///选择宠物主人
  int _selectPetValue = 1;

  ///选择帮养人
  int _selectHelpValue = 2;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(context),
      builder: (context, child) {
        return Scaffold(
          body: Container(
            height: ScreenAdapter.getScreenHeight(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                //渐变位置
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  KTColor.color_255_247_239,
                  KTColor.color_255_127_75,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1.返回箭头
                Container(
                  // color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: ScreenAdapter.getStatusBarHeight() +
                            ScreenAdapter.height(66),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ],
                  ),
                ),
                //2.标题
                Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.width(80)),
                  // color: Colors.amber,
                  child: Text(
                    "选择你的角色",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.fontSize(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: padding_65,
                ),
                //3.角色选择
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //左右
                  children: [
                    Column(
                      children: [
                        Text(
                          "我有狗狗需要照顾",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(26),
                            color: KTColor.color_60,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: padding_20,
                        ),
                        Container(
                          width: ScreenAdapter.width(160),
                          height: ScreenAdapter.width(160),
                          child: const CircleAvatar(
                            // radius: ScreenAdapter.width(80),
                            backgroundImage: NetworkImage(
                                "https://img0.baidu.com/it/u=1641416437,1150295750&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800"),
                          ),
                        ),
                        SizedBox(
                          height: padding_20,
                        ),
                        OutlineChoeseButton(
                          title: "宠物主人",
                          index: _selectPetValue,
                          onTap: (index) {
                            AALog("宠物主人 $index");
                            Provider.of<LoginProvider>(context, listen: false)
                                .selectRole = _selectPetValue;
                          },
                          width: ScreenAdapter.width(170),
                          height: ScreenAdapter.width(66),
                          radius: 33,
                          borderWidth:
                              (Provider.of<LoginProvider>(context, listen: true)
                                          .selectRole ==
                                      _selectPetValue)
                                  ? ScreenAdapter.width(2)
                                  : 0,
                          borderColor:
                              (Provider.of<LoginProvider>(context, listen: true)
                                          .selectRole ==
                                      _selectPetValue)
                                  ? KTColor.color_251_98_64
                                  : Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(100),
                    ),
                    Column(
                      children: [
                        Text(
                          "我想帮人照顾狗狗",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(26),
                            color: KTColor.color_60,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: padding_20,
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(160),
                          height: ScreenAdapter.width(160),
                          child: CircleAvatar(
                            // radius: ScreenAdapter.width(80),
                            backgroundImage: NetworkImage(imageUrl1),
                          ),
                        ),
                        SizedBox(
                          height: padding_20,
                        ),
                        OutlineChoeseButton(
                          title: "帮养人",
                          index: _selectHelpValue,
                          onTap: (index) {
                            AALog("帮养人 $index");
                            Provider.of<LoginProvider>(context, listen: false)
                                .selectRole = _selectHelpValue;
                          },
                          width: ScreenAdapter.width(170),
                          height: ScreenAdapter.width(66),
                          radius: 33,
                          borderWidth:
                              (Provider.of<LoginProvider>(context, listen: true)
                                          .selectRole ==
                                      _selectHelpValue)
                                  ? ScreenAdapter.width(2)
                                  : 0,
                          borderColor:
                              (Provider.of<LoginProvider>(context, listen: true)
                                          .selectRole ==
                                      _selectHelpValue)
                                  ? KTColor.color_251_98_64
                                  : Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenAdapter.width(120),
                ),
                Consumer(
                  builder: (context, LoginProvider provider, child) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: ScreenAdapter.width(39),
                        right: ScreenAdapter.width(39),
                      ),
                      child: PassButton(
                        text: "下一步",
                        bgColor: KTColor.color_251_98_64,
                        height: ScreenAdapter.width(90),
                        onPressed:
                            ButtonUtils.debounce(provider.selectRoleNext),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: ScreenAdapter.width(44),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Text(
                    textAlign: TextAlign.center,
                    '后续可在设置中切换角色',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenAdapter.fontSize(26),
                      color: KTColor.color_164,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
