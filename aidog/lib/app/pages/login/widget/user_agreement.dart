import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/widget/counter_singleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAgreementWidget extends StatefulWidget {
  final void Function(bool?)? onChanged;

  const UserAgreementWidget({super.key, this.onChanged});

  @override
  State<UserAgreementWidget> createState() => _UserAgreementWidgetState();
}

class _UserAgreementWidgetState extends State<UserAgreementWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 访问实例
    // 您可以从应用程序的任何地方访问实例及其属性或方法。
    // 直接 instance 静态对象访问类实例方法
    CounterSingleton.instance.increment();
    // 单例访问类属性
    // print('Counter: ${CounterSingleton.instance.counter}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenAdapter.height(40),
        // right: ScreenAdapter.height(30),
        // bottom: ScreenAdapter.height(30),
      ),
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(100),
      child: Container(
        color: KTColor.amber,
        child: Row(
          children: [
            //监听数据变化   监听UserAgreemenProvider里的所有属性的变化
            Consumer<LoginProvider>(
              builder: (context, value, child) {
                return Checkbox(
                  shape: const CircleBorder(), // Circle Checkbox
                  activeColor: KTColor.red,
                  value: value.isAgree,
                  onChanged: widget.onChanged,
                );
              },
            ),

            Text(
              "ask大苏打啊收到啦勒索 sadasdasd大大sadasdasd大大sadasdasd大大sadasdasd大大是的",
              maxLines: 2,
            ),
          ],
        ),
      ),

      //  Row(
      //   children: [

      //     Container(
      //       height: 100,
      //       color: KTColor.blue,
      //       child:
      //
      // Wrap(
      //         //协议比较多可能会换号所以用wrap组件
      //         crossAxisAlignment: WrapCrossAlignment.center,
      //         children: [
      //           Text(
      //             "我已阅读并同意",
      //             style: TextStyle(
      //               color: KTColor.color_164,
      //               fontSize: ScreenAdapter.fontSize(24),
      //               fontWeight: FontWeight.w300,
      //             ),
      //           ),
      //           Text(
      //             "《用户协议》",
      //             style: TextStyle(
      //               color: KTColor.color_251_98_64,
      //               fontSize: ScreenAdapter.fontSize(24),
      //               fontWeight: FontWeight.w300,
      //             ),
      //           ),
      //           Text(
      //             "《隐私协议》",
      //             style: TextStyle(
      //               color: KTColor.color_251_98_64,
      //               fontSize: ScreenAdapter.fontSize(24),
      //               fontWeight: FontWeight.w300,
      //             ),
      //           ),
      //           Text(
      //             "《儿童/青少年个人信息保护规则》",
      //             style: TextStyle(
      //               color: KTColor.color_251_98_64,
      //               fontSize: ScreenAdapter.fontSize(24),
      //               fontWeight: FontWeight.w300,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
/*
      Wrap(
        //协议比较多可能会换号所以用wrap组件
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          //监听数据变化   监听UserAgreemenProvider里的所有属性的变化
          Consumer<LoginProvider>(
            builder: (context, value, child) {
              return Checkbox(
                shape: const CircleBorder(), // Circle Checkbox

                activeColor: KTColor.red,
                value: value.isAgree,
                onChanged: widget.onChanged,
              );
            },
          ),
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
      ),
      */
    );
  }
}
