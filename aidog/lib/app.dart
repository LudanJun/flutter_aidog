import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/global_provider/global_navigator_observer.dart';
import 'package:aidog/app/global_provider/global_net_provider.dart';
import 'package:aidog/app/global_provider/global_provider.dart';
import 'package:aidog/app/pages/home/provider/home_provider.dart';
import 'package:aidog/app/pages/login/login_page.dart';
import 'package:aidog/app/pages/login/%E5%BA%9F%E5%BC%83/login_page1.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/theme/dart_theme.dart';
import 'package:aidog/app/theme/light_theme.dart';
import 'package:aidog/app/theme/theme_provider.dart';
import 'package:aidog/guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  final bool isShowGuide;

  final bool isLogin;

  const MyApp({super.key, required this.isShowGuide, required this.isLogin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => LoginProvider(context),
            ),
            ChangeNotifierProvider(
              create: (context) => GlobalProvider(),
              lazy: false,
            ),
            // ChangeNotifierProvider(
            //   create: (context) => GlobalProvider(),
            //   lazy: false,
            // ),
            ChangeNotifierProvider(
              create: (context) => GlobalNetProvider(),
              lazy: false,
            ),
            ChangeNotifierProvider(
              create: (context) => HomeProvider(),
              lazy: false,
            ),
            ChangeNotifierProvider(
              create: (context) => MyProvider(),
              lazy: false,
            ),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: '爱狗',
                theme:
                    Provider.of<ThemeProvider>(context, listen: true).themeData,
                home: widget.isShowGuide
                    ? GuidePage()
                    : widget.isLogin
                        ? const TabsPage()
                        : const LoginPage(),

                ///根据属性判断是否第一次进来显示引导页

                // home: widget.isShowGuide ? GuidePage() : const LoginPage(),

                ///根据属性判断是否第一次进来显示引导页
                // home: const TabsPage(),
                navigatorKey: navigatorKey,
                //监听路由变化
                navigatorObservers: [
                  NavigationUtil.getInstance(),
                  FlutterSmartDialog.observer,
                  GlobalNavigatorObserver(),
                ],
                builder: (context, child) {
                  child = EasyLoading.init()(context, child);
                  child = FlutterSmartDialog.init()(context, child);
                  return child;
                },

                // navigatorObservers: [NavigationUtil.getInstance()],
                routes: NavigationUtil.configRoutes, //路由页面列表
                // initialRoute: RoutersName.tabsPage,
              );
            },
          ),
        );
      },
    );
  }
}
