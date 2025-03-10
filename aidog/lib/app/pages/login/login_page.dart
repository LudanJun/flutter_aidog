import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/global_provider/global_net_provider.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/login/widget/cus_check_box.dart';
import 'package:aidog/app/widget/code_text_field.dart';
import 'package:aidog/app/widget/logo.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:aidog/app/widget/pass_text_field.dart';
import 'package:aidog/app/pages/login/widget/user_agreement.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TapGestureRecognizer _yonghuProtocolRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _yinsiProtocolRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _ertongProtocolRecognizer = TapGestureRecognizer();

  /// 记录手机号
  String _getPhoneStr = '';

  /// 记录验证码
  String _getCodeStr = '';
  String _sValue = '0';

  /// 可点击
  bool _clickable = false;
  @override
  void initState() {
    //检测网络
    final GlobalNetProvider globalNetProvider =
        Provider.of<GlobalNetProvider>(context, listen: false);
    globalNetProvider.startNetEventStream();

    super.initState();
  }

  @override
  void dispose() {
    _yonghuProtocolRecognizer.dispose();
    _yinsiProtocolRecognizer.dispose();
    _ertongProtocolRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(context),
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: KTColor.color_255_247_239,
            child: ListView(
              padding: EdgeInsets.all(
                ScreenAdapter.width(40),
              ),
              children: [
                const SizedBox(
                  height: 100,
                ),

                Column(
                  children: [
                    Text(
                      "手机号登录",
                      style: TextStyle(
                        color: KTColor.color_60,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenAdapter.fontSize(42),
                      ),
                    ),
                    Text(
                      '未注册的手机号登录成功后自动注册',
                      style: TextStyle(
                        color: KTColor.color_164,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenAdapter.fontSize(24),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenAdapter.height(80),
                ),
                //手机号输入框
                PassTextField(
                  controller: Provider.of<LoginProvider>(context, listen: true)
                      .telController,
                  height: ScreenAdapter.width(90),
                  hintText: "请输入手机号码",
                  radius: ScreenAdapter.width(45),
                  onChanged: (value) {
                    setState(() {
                      AALog(value);
                      _getPhoneStr = value;
                      Provider.of<LoginProvider>(context, listen: false)
                          .recordPhoneStr = value;
                      //手机号和验证码都输完 登录按钮变为可点击
                      if (_getPhoneStr.length == 11 &&
                          _getCodeStr.length == 6) {
                        AALog("登录可点击");
                        _clickable = true;
                      } else {
                        _clickable = false;
                      }
                    });
                  },
                  rightWidget: InkWell(
                    onTap: () {
                      AALog("删除");
                      setState(() {
                        Provider.of<LoginProvider>(context, listen: false)
                            .telController
                            .text = '';
                      });
                    },
                    // child: Icon(Icons.clear_sharp),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: padding_25,
                        left: padding_25,
                        bottom: padding_25,
                      ),
                      // color: KTColor.amber,
                      child: Provider.of<LoginProvider>(context, listen: true)
                                  .telController
                                  .text !=
                              ''
                          ? const Image(
                              // width: padding_20,
                              // height: padding_20,
                              image: AssetImage('assets/login_delete.png'),
                              // fit: BoxFit.fill,
                            )
                          : const SizedBox.shrink(),
                    ),
                    //  Container(
                    //   margin: EdgeInsets.all(
                    //     ScreenAdapter.width(8),
                    //   ),
                    //   child: Image(
                    //     image: AssetImage(
                    //       AssetUtils.getAssetImagePNG('my_close'),
                    //     ),
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), //设置只允许输入数字
                    LengthLimitingTextInputFormatter(11) //限制长度
                  ],
                ),
                //输入验证码 获取验证码
                SizedBox(
                  // color: Colors.amber,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // CodeTextField(
                      //   controller:
                      //       Provider.of<LoginProvider>(context, listen: true)
                      //           .codeController,
                      //   hintText: "请输入验证码",
                      //   radius: ScreenAdapter.width(45),
                      //   onChanged: (value) {
                      //     AALog(value);
                      //   },
                      // ),

                      PassTextField(
                        controller:
                            Provider.of<LoginProvider>(context, listen: true)
                                .codeController,
                        height: ScreenAdapter.width(90),
                        hintText: "请输入验证码",
                        radius: ScreenAdapter.width(45),
                        onChanged: (value) {
                          setState(() {
                            AALog(value);

                            _getCodeStr = value; //手机号和验证码都输完 登录按钮变为可点击
                            Provider.of<LoginProvider>(context, listen: false)
                                .recordCodeStr = value;
                            if (_getPhoneStr.length == 11 &&
                                _getCodeStr.length == 6) {
                              //收起键盘
                              FocusScope.of(context).requestFocus(FocusNode());
                              AALog("登录可点击");
                              _clickable = true;
                            } else {
                              _clickable = false;
                            }
                          });
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')), //设置只允许输入数字
                          LengthLimitingTextInputFormatter(6) //限制长度
                        ],
                      ),
                      Positioned(
                        top: ScreenAdapter.width(22),
                        right: ScreenAdapter.width(20),
                        child: Provider.of<LoginProvider>(
                                  context,
                                  listen: false,
                                ).seconds >
                                0
                            ? TextButton(
                                onPressed: ButtonUtils.debounce(
                                    Provider.of<LoginProvider>(
                                  context,
                                  listen: false,
                                ).sendCodeData),
                                child: Text(
                                  '${Provider.of<LoginProvider>(context, listen: false).seconds.toString()}s后重新获取',
                                  style: TextStyle(
                                    color: KTColor.color_164,
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(32),
                                  ),
                                ),
                              )
                            : Consumer(
                                builder: (_, LoginProvider provider, child) {
                                  return TextButton(
                                    onPressed: ButtonUtils.debounce(
                                        Provider.of<LoginProvider>(
                                      context,
                                      listen: false,
                                    ).sendCodeData),
                                    child: Text(
                                      '获取验证码',
                                      style: TextStyle(
                                        color: KTColor.color_251_98_64,
                                        fontWeight: FontWeight.w300,
                                        fontSize: ScreenAdapter.fontSize(32),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: ScreenAdapter.height(110),
                ),
                Consumer(
                  builder: (_, LoginProvider provider, child) {
                    return PassButton(
                      text: "登录",
                      bgColor: _clickable == true
                          ? KTColor.color_251_98_64
                          : KTColor.color_164,
                      // width: ScreenAdapter.getScreenWidth() - padding_40 * 2,
                      height: ScreenAdapter.width(90),
                      onPressed: _clickable == true
                          ? ButtonUtils.debounce(provider.registerAndLogin)
                          : null,
                    );
                  },
                ),

                //协议勾选
                // UserAgreementWidget(
                //   onChanged: (isSelect) {
                //     AALog(isSelect!);
                //     //通过Provider调用add方法
                //     //调用方法的时候listen设置为false
                //     //调用属性的时候listen设置true 默认为true
                //     Provider.of<LoginProvider>(context, listen: false).isAgree =
                //         isSelect;
                //   },
                // ),
                SizedBox(
                  height: ScreenAdapter.height(20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      // Container(
                      //   color: KTColor.amber,
                      //   child:
                      Expanded(
                        flex: 1,
                        child:
                            //监听数据变化   监听UserAgreemenProvider里的所有属性的变化
                            Consumer<LoginProvider>(
                          builder: (context, value, child) {
                            /*
                            return Container(
                              // color: KTColor.amber,
                              child: Checkbox(
                                shape: const CircleBorder(), // Circle Checkbox
                                activeColor: KTColor.red,
                                // checkColor: KTColor.color_76_76_76,
                                // overlayColor: WidgetStateProperty.all(
                                //     KTColor.color_76_76_76),
                                // fillColor: WidgetStateProperty.all(
                                //     KTColor.color_76_76_76),
                                value: value.isAgree,
                                onChanged: (value) {
                                  //通过Provider调用add方法
                                  //调用方法的时候listen设置为false
                                  //调用属性的时候listen设置true 默认为true
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .isAgree = value!;
                                },
                              ),
                            );*/

                            return CusCheckBox(
                              value: value.isAgree,
                              onChanged: (value) {
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .isAgree = value;
                              },
                            );

                            // return TDRadio(
                            //   size: TDCheckBoxSize.small,
                            //   backgroundColor: Colors.transparent,
                            //   id: "2",
                            //   radioStyle: TDRadioStyle.circle,
                            //   enable: true,
                            //   // disableColor: KTColor.amber,
                            //   selectColor: KTColor.color_251_98_64,
                            // );
                          },
                        ),
                      ),
                      // ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          padding: EdgeInsets.only(top: padding_30),
                          height: padding_100,
                          // color: KTColor.black333,
                          child: RichText(
                            text: TextSpan(
                              text: "我已阅读并同意",
                              style: TextStyle(
                                color: KTColor.color_164,
                                letterSpacing: 0, //字母间隔
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenAdapter.fontSize(24),
                              ),
                              //我已阅读并同意《用户协议》《隐私政策》《儿童/青少年个人信息保护规则》
                              children: [
                                TextSpan(
                                  text: "《用户协议》",
                                  style: TextStyle(
                                    color: KTColor.color_251_98_64,
                                    letterSpacing: 0, //字母间隔
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(24),
                                  ),
                                  recognizer: _yonghuProtocolRecognizer
                                    ..onTap = () {
                                      AALog("用户协议");
                                    },
                                ),
                                TextSpan(
                                  text: "《隐私政策》",
                                  style: TextStyle(
                                    color: KTColor.color_251_98_64,
                                    letterSpacing: 0, //字母间隔
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(24),
                                  ),
                                  recognizer: _yinsiProtocolRecognizer
                                    ..onTap = () {
                                      AALog("隐私政策");
                                    },
                                ),
                                TextSpan(
                                  text: "《儿童/青少年个人信息保护规则》",
                                  style: TextStyle(
                                    color: KTColor.color_251_98_64,
                                    letterSpacing: 0, //字母间隔
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(24),
                                  ),
                                  recognizer: _ertongProtocolRecognizer
                                    ..onTap = () {
                                      AALog("儿童/青少年个人信息保护规则");
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        /*
                        Wrap(
                          //协议比较多可能会换号所以用wrap组件
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "我已阅读并同意",
                              style: TextStyle(
                                color: KTColor.color_164,
                                fontSize: ScreenAdapter.fontSize(24),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "《用户协议》",
                              style: TextStyle(
                                color: KTColor.color_251_98_64,
                                fontSize: ScreenAdapter.fontSize(24),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "《隐私协议》",
                              style: TextStyle(
                                color: KTColor.color_251_98_64,
                                fontSize: ScreenAdapter.fontSize(24),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "《儿童/青少年个人信息保护规则》",
                              style: TextStyle(
                                color: KTColor.color_251_98_64,
                                fontSize: ScreenAdapter.fontSize(24),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),*/
                      ),
                    ],
                  ),
                ),

                // Text(
                //   Provider.of<LoginProvider>(context, listen: false)
                //       .seconds
                //       .toString(),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
