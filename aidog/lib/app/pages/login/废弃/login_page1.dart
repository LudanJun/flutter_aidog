// import 'dart:ffi';

// import 'package:aidog/app/common/asset_utils.dart';
// import 'package:aidog/app/common/button_util.dart';
// import 'package:aidog/app/common/global_color.dart';
// import 'package:aidog/app/common/log_extern.dart';
// import 'package:aidog/app/common/screenAdapter.dart';
// import 'package:aidog/app/global_provider/global_net_provider.dart';
// import 'package:aidog/app/pages/login/provider/login_provider.dart';
// import 'package:aidog/app/widget/code_text_field.dart';
// import 'package:aidog/app/widget/logo.dart';
// import 'package:aidog/app/widget/pass_button.dart';
// import 'package:aidog/app/widget/pass_text_field.dart';
// import 'package:aidog/app/pages/login/widget/user_agreement.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   void initState() {
//     //检测网络
//     final GlobalNetProvider globalNetProvider =
//         Provider.of<GlobalNetProvider>(context, listen: false);
//     globalNetProvider.startNetEventStream();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LoginProvider>(
//       create: (context) => LoginProvider(context),
//       builder: (context, child) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 top: 0,
//                 child: Image(
//                   // width: double.infinity,
//                   // height: double.infinity,
//                   image: AssetImage(
//                     AssetUtils.getAssetImagePNG('login_bg'),
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Positioned(
//                 child: ListView(
//                   children: [
//                     Container(
//                       width: ScreenAdapter.getScreenWidth(),
//                       height: 500,
//                       color: KTColor.amber,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // SingleChildScrollView(
//           //   child:
//           //   Stack(
//           //     children: [
//           //       Positioned(
//           //         left: 0,
//           //         right: 0,
//           //         bottom: 0,
//           //         top: 0,
//           //         child: Image(
//           //           // width: double.infinity,
//           //           // height: double.infinity,
//           //           image: AssetImage(
//           //             AssetUtils.getAssetImagePNG('login_bg'),
//           //           ),
//           //           fit: BoxFit.fill,
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),

//           //  Container(
//           //   width: ScreenAdapter.getScreenWidth(),
//           //   height: ScreenAdapter.getScreenHeight(),
//           //   color: KTColor.red,
//           //   child: Stack(
//           //     children: [
//           //       Positioned(
//           //         left: 0,
//           //         right: 0,
//           //         bottom: 0,
//           //         top: 0,
//           //         child: Image(
//           //           // width: double.infinity,
//           //           // height: double.infinity,
//           //           image: AssetImage(
//           //             AssetUtils.getAssetImagePNG('login_bg'),
//           //           ),
//           //           fit: BoxFit.fill,
//           //         ),
//           //       ),

//           //     ],
//           //   ),

//           // Column(
//           //   children: [
//           //     Container(
//           //       width: ScreenAdapter.getScreenWidth(),
//           //       height: ScreenAdapter.getScreenHeight(),
//           //       color: KTColor.amber,
//           //       child:

//           //     ),
//           //   ],
//           // ),
//           // Stack(
//           //   children: [
//           //     Image(
//           //       width: double.infinity,
//           //       height: double.infinity,
//           //       image: AssetImage(
//           //         AssetUtils.getAssetImagePNG('login_bg'),
//           //       ),
//           //       fit: BoxFit.fill,
//           //     ),
//           //     ListView(
//           //       children: [
//           //         Container(
//           //           width: ScreenAdapter.getScreenWidth(),
//           //           height: 500,
//           //           color: KTColor.amber,
//           //         ),
//           //       ],
//           //     ),
//           //   ],
//           // ),

//           /*
//              ListView(
//               padding: EdgeInsets.all(
//                 ScreenAdapter.width(40),
//               ),
//               children: [
//                 const SizedBox(
//                   height: 100,
//                 ),

//                 //logo显示
//                 const Logo(),

//                 //手机号输入框
//                 PassTextField(
//                   controller: Provider.of<LoginProvider>(context, listen: true)
//                       .telController,
//                   hintText: "请输入手机号码",
//                   radius: 10,
//                   onChanged: (value) {
//                     AALog(value);
//                   },
//                 ),
//                 //输入验证码 获取验证码
//                 SizedBox(
//                   // color: Colors.amber,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CodeTextField(
//                         controller:
//                             Provider.of<LoginProvider>(context, listen: true)
//                                 .codeController,
//                         hintText: "请输入验证码",
//                         onChanged: (value) {
//                           AALog(value);
//                         },
//                       ),
//                       Positioned(
//                         top: ScreenAdapter.width(30),
//                         right: ScreenAdapter.width(20),
//                         child: Provider.of<LoginProvider>(
//                                   context,
//                                   listen: false,
//                                 ).seconds >
//                                 0
//                             ? ElevatedButton(
//                                 onPressed: null,
//                                 child: Text(
//                                   "${Provider.of<LoginProvider>(context, listen: false).seconds.toString()}秒后重新发送",
//                                 ),
//                               )
//                             : Consumer(
//                                 builder: (_, LoginProvider provider, child) {
//                                   return ElevatedButton(
//                                     onPressed: ButtonUtils.debounce(
//                                         Provider.of<LoginProvider>(
//                                       context,
//                                       listen: false,
//                                     ).sendCodeData),
//                                     child: const Text('发送验证码'),
//                                   );
//                                 },
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 //协议勾选
//                 UserAgreementWidget(
//                   onChanged: (isSelect) {
//                     AALog(isSelect!);
//                     //通过Provider调用add方法
//                     //调用方法的时候listen设置为false
//                     //调用属性的时候listen设置true 默认为true
//                     Provider.of<LoginProvider>(context, listen: false).isAgree =
//                         isSelect;
//                   },
//                 ),

//                 SizedBox(
//                   height: ScreenAdapter.height(20),
//                 ),
//                 Consumer(
//                   builder: (_, LoginProvider provider, child) {
//                     return PassButton(
//                       text: "注册/登录",
//                       height: 90,
//                       onPressed:
//                           ButtonUtils.debounce(provider.registerAndLogin),
//                     );
//                   },
//                 ),

//                 Text(
//                   Provider.of<LoginProvider>(context, listen: false)
//                       .seconds
//                       .toString(),
//                 ),
//               ],
//             ),
//             */
//           // ),
//         );
//       },
//     );
//   }
// }
