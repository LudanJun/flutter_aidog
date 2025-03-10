import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/choese_image_tool.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/input_formatters.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginSetHeadPage extends StatefulWidget {
  const LoginSetHeadPage({super.key});

  @override
  State<LoginSetHeadPage> createState() => _LoginSetHeadPageState();
}

class _LoginSetHeadPageState extends State<LoginSetHeadPage> {
  // ///实例化图片选择器
  // final ImagePicker _picker = ImagePicker();

  // //定义全局获取的图片属性 来实现显示
  // XFile? _pickedFile;
  String getHeadImgUrl = '';

  int _selectGenderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //该属性可以让appbar下面的控件在导航栏下面显示
      // extendBodyBehindAppBar: false, //实现透明导航
      // appBar: AppBar(
      //     // title: Text(
      //     //   "设置信息",
      //     //   style: HooTextStyle.appBarTitleBStyle,
      //     // ),
      //     ),
      body: Container(
        color: Colors.red,
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () {
              //收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenAdapter.getStatusBarHeight() +
                        ScreenAdapter.height(20),
                  ),
                  //1.头像点击
                  InkWell(
                    onTap: () {
                      AALog("点击头像");
                      // _bottomSheet();
                      //调取图片选择和拍照
                      ChoeseImageTool().bottomSheet(
                        context,
                        (value) {
                          AALog("获取的图片路径$value");
                          // Provider.of<LoginProvider>(context, listen: true)
                          //     .getHeadImgUrl = value;
                        },
                      );
                    },
                    child: Container(
                      child: CircleAvatar(
                        radius: ScreenAdapter.width(80),
                        backgroundImage: Provider.of<LoginProvider>(
                                  context,
                                  listen: true,
                                ).getHeadImgUrl ==
                                ''
                            ? const NetworkImage(
                                "https://img0.baidu.com/it/u=1641416437,1150295750&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800")
                            : NetworkImage(Provider.of<LoginProvider>(
                                context,
                                listen: true,
                              ).getHeadImgUrl),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  ),
                  // 男女选择
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ScreenAdapter.width(180),
                        child: RadioListTile(
                          title: Text("男"),
                          activeColor: KTColor.amber,
                          value: 1, //男性值为1
                          groupValue: _selectGenderValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectGenderValue = value!;
                              Provider.of<LoginProvider>(context, listen: false)
                                  .selectGenderValue = _selectGenderValue;
                              AALog("男:$_selectGenderValue");
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(180),
                        child: RadioListTile(
                          title: Text("女"),
                          activeColor: KTColor.amber,
                          value: 0, //女性值为0
                          groupValue: _selectGenderValue,
                          onChanged: (int? value) {
                            setState(
                              () {
                                _selectGenderValue = value!;
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .selectGenderValue = _selectGenderValue;
                                AALog("女:$_selectGenderValue");
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(30),
                  ),

                  ///2.用户昵称
                  Container(
                    // alignment: Alignment.center,
                    width: ScreenAdapter.width(200),
                    child: TextField(
                      controller:
                          Provider.of<LoginProvider>(context, listen: false)
                              .usernameController,
                      //输入规则
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[A-Z,a-z,0-9]")),
                        LengthLimitingTextInputFormatter(8) //限制长度
                      ],
                      textAlign: TextAlign.center, //文本内容实现左右居中
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(24),
                      ),
                      maxLines: 1, //最大行数
                      //表示进入到页面后就弹出键盘
                      // autocorrect: true,
                      //监听文本框输入内容
                      onChanged: (value) {
                        AALog(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "用户昵称", //提示文字
                        // border: InputBorder.none, //去掉下划线
                      ),
                    ),
                  ),
                  //3.下一步

                  //  Consumer(
                  //         builder: (_, LoginProvider provider, child) {
                  //           return PassButton(
                  //             text: "获取验证码",
                  //             onPressed: ButtonUtils.debounce(provider.getCode),
                  //           );
                  //         },
                  //       ),

                  // Consumer(
                  //   builder: (_, LoginProvider provider, child) {
                  //     return OutlinedButton(
                  //       onPressed:
                  //           ButtonUtils.debounce(provider.setHeadAfterNext),
                  //       child: Text("下一步"),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ///底部弹框
  // void _bottomSheet() async {
  //   print("_modelBottomSheet");
  //   var result = await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SizedBox(
  //         height: 150,
  //         child: Center(
  //           child: Column(
  //             children: [
  //               ListTile(
  //                 title: const Text(
  //                   "相册",
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 onTap: () {
  //                   print("aaa相册");
  //                   _pickGallery();
  //                   Navigator.of(context).pop("相册");
  //                 },
  //               ),
  //               ListTile(
  //                 title: const Text(
  //                   "拍照",
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 onTap: () {
  //                   print("拍照");
  //                   _pickCamera();
  //                   Navigator.of(context).pop("拍照");
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // //相册选择 只能选择一张图片
  // _pickGallery() async {
  //   //获取选择的照片
  //   XFile? image = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       //默认选择的图片很大 需要指定下宽高
  //       maxWidth: 800,
  //       maxHeight: 800);
  //   print(image);
  //   if (image != null) {
  //     AALog(image.path);

  //     //选择完图片 开始上传

  //     // _uploadImageFile(image.path);
  //     setState(() {
  //       // _pickedFile = image;
  //     });
  //   }
  // }

  // //拍照 拍摄一张图片
  // _pickCamera() async {
  //   //获取拍的照片
  //   XFile? image = await _picker.pickImage(
  //       //指定选择图片的类型
  //       source: ImageSource.camera,
  //       //默认选择的图片很大 需要指定下宽高
  //       maxWidth: ScreenAdapter.width(200),
  //       maxHeight: ScreenAdapter.width(200));
  //   print(image);
  //   if (image != null) {
  //     print(image.path);
  //     //选择完图片 开始上传
  //     // _uploadImageFile(image.path);
  //     setState(() {
  //       // _pickedFile = image;
  //     });
  //   }
  // }
}
