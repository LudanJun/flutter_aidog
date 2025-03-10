import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/choese_image_tool.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/widget/normal_text_field.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:aidog/app/widget/sex_radio_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LoginSetHeadPage extends StatefulWidget {
  const LoginSetHeadPage({super.key});

  @override
  State<LoginSetHeadPage> createState() => _LoginSetHeadPageState();
}

class _LoginSetHeadPageState extends State<LoginSetHeadPage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  //头像链接
  String _headImgUrl = '';

  /// 选择的女性
  int _selectWomanSexValue = 0;

  /// 选择的男
  int _selectManValue = 1;

  @override
  void initState() {
    super.initState();

    MyApi().userInfo(
      onSuccess: (data) {
        if (data['code'] == '200') {
          setState(() {
            _myUserInfoModel = MyUserInfoModel.fromJson(data);
          });
        }
      },
      onFailure: (error) {
        AALog(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(context),
      builder: (context, child) {
        return Scaffold(
          //该属性可以让appbar下面的控件在导航栏下面显示
          // extendBodyBehindAppBar: true, //实现透明导航
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          // ),
          body: SingleChildScrollView(
            child: InkWell(
              onTap: () {
                //收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                // width: double.infinity,
                height: ScreenAdapter.getScreenHeight(),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    //渐变位置
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      KTColor.color_255_247_239,
                      // KTColor.color_255_154_92,
                      KTColor.color_255_127_75,
                    ],
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: KTColor.color_255_127_75,
                  //     blurRadius: 5.0,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
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
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ],
                      ),
                    ),
                    //2.标题
                    Container(
                      margin: EdgeInsets.only(left: ScreenAdapter.width(80)),
                      // color: Colors.amber,
                      child: Text(
                        "欢迎!\n来丰富下你的形象吧",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(50),
                        ),
                      ),
                    ),

                    //3.头像内容
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenAdapter.width(80),
                        top: ScreenAdapter.width(39),
                        right: ScreenAdapter.width(80),
                      ),
                      width: double.infinity,
                      height: ScreenAdapter.width(504),
                      //设置裁切属性
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: KTColor.white,
                        //设置完圆角度数后,需要设置裁切属性
                        borderRadius:
                            BorderRadius.circular(ScreenAdapter.width(46)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: padding_60,
                          ),
                          //头像
                          Container(
                            child: InkWell(
                              onTap: () {
                                AALog('点击头像');
                                //调取图片选择和拍照
                                ChoeseImageTool().bottomSheet(
                                  context,
                                  (value) {
                                    setState(
                                      () {
                                        //这里拿到的是就本地图片路径
                                        ///Users/hoooooo/Library/Developer/CoreSimulator/Devices/17259343-3D6E-41EF-A69A-6C61AAD175F0/data/Containers/Data/Application/6304C718-D83D-4106-AA74-3F667154FF9F/tmp/image_picker_AF21A54C-7BF1-48D3-9D1A-85D9A6E0CF3A-70386-000043165FBAD267.jpg
                                        _headImgUrl = value;
                                        // AALog(
                                        //     "获取的图片路径${Provider.of<LoginProvider>(context, listen: false).headImagStr}");
                                        AALog("获取的图片路径$_headImgUrl");

                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .uploadHeadImage(value);
                                        setState(() {});
                                      },
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Consumer(
                                    builder: (context, LoginProvider provider,
                                        child) {
                                      return Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: ScreenAdapter.width(160),
                                        height: ScreenAdapter.width(160),
                                        child: provider.getHeadImgUrl == ''
                                            ? Image.network(
                                                _myUserInfoModel.data?.avatar ??
                                                    defaultHeadImg,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                provider.getHeadImgUrl,
                                                fit: BoxFit.cover,
                                              ),
                                        decoration: BoxDecoration(
                                          // color: KTColor.amber,
                                          borderRadius: BorderRadius.circular(
                                            ScreenAdapter.width(80),
                                          ),
                                        ),
                                      );
                                      // return CircleAvatar(
                                      //   radius: ScreenAdapter.width(80),

                                      //   // backgroundImage:
                                      //   //     provider.getHeadImgUrl == ''
                                      //   //         ? AssetImage(
                                      //   //             AssetUtils.getAssetImagePNG(
                                      //   //                 'mn'),
                                      //   //           )
                                      //   //         // : AssetImage(_headImgUrl)
                                      //   //         : CachedNetworkImageProvider(
                                      //   //             provider
                                      //   //                 .getHeadImgUrl, //需要图片链接
                                      //   //           ),
                                      //   backgroundImage: provider
                                      //               .getHeadImgUrl ==
                                      //           ''
                                      //       ? CachedNetworkImageProvider(
                                      //           _myUserInfoModel.data?.avatar ??
                                      //               defaultHeadImg, //需要图片链接
                                      //           errorListener: (p0) {
                                      //             AALog("p0---$p0");
                                      //           },
                                      //         )
                                      //       // : AssetImage(_headImgUrl)
                                      //       : CachedNetworkImageProvider(
                                      //           provider.getHeadImgUrl, //需要图片链接
                                      //         ),
                                      // );
                                    },
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: CircleAvatar(
                                      radius: ScreenAdapter.width(27),
                                      backgroundImage: AssetImage(
                                        AssetUtils.getAssetImagePNG(
                                            'login_camera'),
                                      ),

                                      // Provider.of<LoginProvider>(context,
                                      //                 listen: false)
                                      //             .selectSex ==
                                      //         0
                                      //     ? AssetImage(
                                      //         AssetUtils.getAssetImagePNG(
                                      //             'login_woman'))
                                      //     : AssetImage(
                                      //         AssetUtils.getAssetImagePNG(
                                      //             'login_man'),
                                      //       ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: padding_50,
                          ),
                          //性别
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SexRadioButton(
                                index: _selectWomanSexValue,
                                onTap: (index) {
                                  AALog("女生 $index");
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .selectSex = _selectWomanSexValue;
                                },
                                title: '我是女生',
                                imagStr: 'login_woman',
                                bgColor: Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .selectSex ==
                                        _selectWomanSexValue
                                    ? KTColor.color_255_225_225
                                    : KTColor.color_243,
                                width: ScreenAdapter.width(200),
                                height: ScreenAdapter.height(54),
                              ),
                              SexRadioButton(
                                index: _selectManValue,
                                onTap: (index) {
                                  AALog("男生 $index");
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .selectSex = _selectManValue;
                                },
                                title: '我是男生',
                                bgColor: Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .selectSex ==
                                        _selectManValue
                                    ? KTColor.color_219_237_255
                                    : KTColor.color_243,
                                imagStr: 'login_man',
                                width: ScreenAdapter.width(200),
                                height: ScreenAdapter.height(54),
                              ),
                            ],
                          ),

                          //输入昵称
                          Container(
                            alignment: Alignment.center,
                            width: ScreenAdapter.width(500),
                            height: ScreenAdapter.width(90),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(34, 114, 113, 133),
                              borderRadius: BorderRadius.circular(
                                  ScreenAdapter.width(45)), //设置圆角
                            ),
                            margin:
                                EdgeInsets.only(top: ScreenAdapter.height(20)),
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(40),
                                bottom: padding_15),
                            child: NormalTextField(
                              controller: Provider.of<LoginProvider>(context,
                                      listen: true)
                                  .usernameController,
                              // bgColor:const Color.fromARGB(34, 114, 113, 133),
                              textColor: KTColor.color_60,
                              textFontSize: ScreenAdapter.fontSize(32),
                              textFontWeight: FontWeight.w300,
                              keyboardType: TextInputType.name,
                              hintText: "输入昵称",
                              hintColor: KTColor.color_60,
                              hintFontWeight: FontWeight.w300,
                              hintFontSize: ScreenAdapter.fontSize(32),
                              // radius: ScreenAdapter.width(45),
                              textAlign: TextAlign.left,
                              inputFormatters: [
                                // FilteringTextInputFormatter.allow(
                                //     RegExp(r'[0-9]')), //设置只允许输入数字
                                LengthLimitingTextInputFormatter(8) //限制长度
                              ],
                              onChanged: (value) {
                                AALog(value);
                              },
                            ),
                          ),
                          /*
                          Container(
                            width: ScreenAdapter.width(500),
                            height: ScreenAdapter.width(90),
                            color: KTColor.amber,
                            margin:
                                EdgeInsets.only(top: ScreenAdapter.height(20)),
                            // padding:
                            //     EdgeInsets.only(left: ScreenAdapter.width(20)),
                            child: NormalTextField(
                              controller: Provider.of<LoginProvider>(context,
                                      listen: true)
                                  .usernameController,
                              bgColor: const Color.fromARGB(34, 114, 113, 133),
                              textColor: KTColor.color_60,
                              textFontSize: ScreenAdapter.fontSize(32),
                              textFontWeight: FontWeight.w600,
                              keyboardType: TextInputType.name,
                              hintText: "输入昵称",
                              hintColor: KTColor.color_60,
                              hintFontWeight: FontWeight.w600,
                              hintFontSize: ScreenAdapter.fontSize(32),
                              radius: ScreenAdapter.width(45),
                              textAlign: TextAlign.left,
                              inputFormatters: [
                                // FilteringTextInputFormatter.allow(
                                //     RegExp(r'[0-9]')), //设置只允许输入数字
                                LengthLimitingTextInputFormatter(8) //限制长度
                              ],
                              onChanged: (value) {
                                AALog(value);
                              },
                            ),
                          ),
                          */
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.width(100),
                    ),
                    Consumer(
                      builder: (context, LoginProvider provider, child) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: padding_40, right: padding_40),
                          width: double.infinity,
                          child: PassButton(
                            text: "下一步",
                            bgColor: KTColor.color_251_98_64,
                            height: ScreenAdapter.width(90),
                            onPressed: ButtonUtils.debounce(provider.headNext),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
