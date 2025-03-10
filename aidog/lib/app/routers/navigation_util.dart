import 'dart:async';

import 'package:aidog/app/pages/home/home_detail_page.dart';
import 'package:aidog/app/pages/home/home_help_other_info_page.dart';
import 'package:aidog/app/pages/home/home_pet_owner_info_page.dart';
import 'package:aidog/app/pages/login/login_page.dart';
import 'package:aidog/app/pages/login/login_help_other_info_page.dart';
import 'package:aidog/app/pages/login/%E5%BA%9F%E5%BC%83/login_page1.dart';
import 'package:aidog/app/pages/login/login_pet_owner_info_page.dart';
import 'package:aidog/app/pages/login/login_two_select_role_page.dart';
import 'package:aidog/app/pages/login/login_one_set_head_page.dart';
import 'package:aidog/app/pages/my/my_choese_role_page.dart';
import 'package:aidog/app/pages/my/my_choose_dog_exp_page.dart';
import 'package:aidog/app/pages/my/my_choose_help_other_info_page.dart';
import 'package:aidog/app/pages/my/my_choose_identity_page.dart';
import 'package:aidog/app/pages/my/my_choose_pet_owner_info_page.dart';
import 'package:aidog/app/pages/my/my_choose_zhaogustyle_page.dart';
import 'package:aidog/app/pages/my/my_like_page.dart';
import 'package:aidog/app/pages/my/my_help_other_profile_page.dart';
import 'package:aidog/app/pages/my/pet_owner_profile/my_pet_choose_dog_sex_page.dart';
import 'package:aidog/app/pages/my/pet_owner_profile/my_pet_choose_identity_page.dart';
import 'package:aidog/app/pages/my/pet_owner_profile/my_pet_choose_kuangyimiao_page.dart';
import 'package:aidog/app/pages/my/pet_owner_profile/my_pet_choose_zhaogustyle_page.dart';
import 'package:aidog/app/pages/my/pet_owner_profile/my_pet_owner_profile_page.dart';
import 'package:aidog/app/pages/my/my_setting_page.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_anim.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 1.一般push跳转,可以返回上一级
  NavigationUtil.getInstance().pushNamed(RoutersName.homeDetailPage);

 2.push不可以返回上级页面,销毁该页面push到下个页面
  NavigationUtil.getInstance().pushReplacementNamed(RoutersName.loginCodePage);
 */

class RouteInfo {
  Route? currentRoute;
  List<Route> routes;

  RouteInfo(this.currentRoute, this.routes);

  @override
  String toString() {
    return 'RouteInfo{currentRoute: $currentRoute, routes: $routes}';
  }
}

class NavigationUtil extends NavigatorObserver {
  static NavigationUtil? _instance;

  //每添加页面 都要在这里配置
  static Map<String, WidgetBuilder> configRoutes = {
    RoutersName.tabsPage: (context) => const TabsPage(),
    ////---登录---/////
    RoutersName.loginPage: (context) => const LoginPage(),
    RoutersName.loginSetHeadPage: (context) => const LoginSetHeadPage(),
    RoutersName.loginSetRolePage: (context) => const LoginSelectRolePage(),

    ////---宠主--/////
    RoutersName.loginPetOwnerInfoPage: (context) =>
        const LoginPetOwnerInfoPage(),

    ////---帮养人---/////
    RoutersName.loginHelpOtherInfoPage: (context) =>
        const LoginHelpOtherInfoPage(),
    ////---首页---/////
    RoutersName.homeDetailPage: (context) => const HomeDetailPage(
          id: 0,
        ),
    //帮养人看宠主详细信息
    RoutersName.homePetOwnerInfoPage: (context) => const HomePetOwnerInfoPage(
          masterUserId: 0,
        ),
    //宠主看帮养人详细信息
    RoutersName.homeHelpOtherInfoPage: (context) => const HomeHelpOtherInfoPage(
          id: 0,
        ),

    ////---消息---/////

    ////---我的---/////
    RoutersName.myHelpOtherProfilePage: (context) =>
        const MyHelpOtherProfilePage(),
    RoutersName.myPetOwnerProfilePage: (context) =>
        const MyPetOwnerProfilePage(),
    RoutersName.myLikePage: (context) => const MyLikePage(),
    RoutersName.mySettingPage: (context) => const MySettingPage(),
    RoutersName.myChoeseRolePage: (context) => const MyChoeseRolePage(),
    RoutersName.myChooseIdentityPage: (context) => const MyChooseIdentityPage(),
    RoutersName.myChooseDogExpPage: (context) => const MyChooseDogExpPage(
          value: 0,
        ),
    RoutersName.myChooseZhaogustylePage: (context) =>
        const MyChooseZhaogustylePage(),

    RoutersName.myChooseHelpOtherInfoPage: (context) =>
        const MyChooseHelpOtherInfoPage(),
    RoutersName.myChoosePetOwnerInfoPage: (context) =>
        const MyChoosePetOwnerInfoPage(),
    RoutersName.myPetChooseDogSexPage: (context) =>
        const MyPetChooseDogSexPage(),
    RoutersName.myPetChooseIdentityPage: (context) =>
        const MyPetChooseIdentityPage(),
    RoutersName.myPetChooseKuangyimiaoPage: (context) =>
        const MyPetChooseKuangyimiaoPage(),
    RoutersName.myPetChooseZhaogustylePage: (context) =>
        const MyPetChooseZhaogustylePage(),
  };

  ///路由信息
  RouteInfo? _routeInfo;
  RouteInfo? get routeInfo => _routeInfo;

  ///存储当前路由页面名字
  final List<String> _routeNames = [];
  List<String> get routeNames => _routeNames;

  ///stream相关
  static late StreamController<RouteInfo> _streamController;
  StreamController<RouteInfo> get streamController => _streamController;

  ///用来路由跳转
  static NavigatorState? navigatorState;

  static NavigationUtil getInstance() {
    if (_instance == null) {
      _instance = NavigationUtil();
      _streamController = StreamController<RouteInfo>.broadcast();
    }
    return _instance!;
  }

  pushPage(BuildContext context, String routeName,
      {required Widget widget, bool fullscreenDialog = false, Function? func}) {
    return Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: routeName),
      fullscreenDialog: fullscreenDialog,
    ))
        .then((value) {
      func?.call(value);
    });
  }

  pushPageFromLeft(BuildContext context, String routeName,
      {required Widget widget, bool fullscreenDialog = false}) {
    return Navigator.of(context).push(Left2RightRouter(
      child: widget,
      settings: RouteSettings(name: routeName),
      fullscreenDialog: fullscreenDialog,
    ));
  }

  pushReplacementPage(BuildContext context, String routeName,
      {required Widget widget, bool fullscreenDialog = false}) {
    return Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: routeName),
      fullscreenDialog: fullscreenDialog,
    ));
  }

  pushAndRemoveUtil(BuildContext context, String routeName,
      {required Widget widget, bool fullscreenDialog = false}) async {
    return Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => widget,
            settings: RouteSettings(name: routeName),
            fullscreenDialog: fullscreenDialog),
        // ignore: unnecessary_null_comparison
        (route) => route == null);
  }

  /// you could also specify the route predicate that will tell you when you need to stop popping your stack before pushing your next route
  pushAndRemoveUtilPage(
      BuildContext context, String routeName, String predicateRouteName,
      {required Widget widget, bool fullscreenDialog = false, Function? func}) {
    return Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (context) => widget,
                settings: RouteSettings(name: routeName),
                fullscreenDialog: fullscreenDialog),
            ModalRoute.withName(predicateRouteName))
        .then((value) => func?.call());
  }

  popUtilPage(BuildContext context, String routeName) {
    return Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  ///Push the given route onto the navigator.
  push(BuildContext context, String routeName,
      {required Widget Function(BuildContext) builder,
      bool fullscreenDialog = false}) {
    return Navigator.of(context).push(CupertinoPageRoute(
      builder: builder,
      settings: RouteSettings(name: routeName),
      fullscreenDialog: fullscreenDialog,
    ));
  }

  pushReplacement(BuildContext context, String routeName,
      {required Widget Function(BuildContext) builder,
      Function? func,
      bool fullscreenDialog = false}) {
    return Navigator.of(context)
        .pushReplacement(CupertinoPageRoute(
          builder: builder,
          settings: RouteSettings(name: routeName),
          fullscreenDialog: fullscreenDialog,
        ))
        .then((value) => func?.call);
  }

  popPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  ///push页面
  Future<T?>? pushNamed<T>(String routeName,
      {WidgetBuilder? builder, bool? fullscreenDialog}) {
    return navigatorState?.push<T>(
      CupertinoPageRoute(
        builder: (builder ?? configRoutes[routeName])!,
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog ?? false,
      ),
    );
  }

  ///replace页面
  Future<T?>? pushReplacementNamed<T, R>(String routeName,
      {WidgetBuilder? builder, bool? fullscreenDialog}) {
    return navigatorState?.pushReplacement<T, R>(
      CupertinoPageRoute(
        builder: (builder ?? configRoutes[routeName])!,
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog ?? false,
      ),
    );
  }

  // pop 页面
  pop<T>([T? result]) {
    navigatorState?.pop<T>(result);
  }

  //poputil返回到指定页面
  popUntil(String newRouteName) {
    return navigatorState?.popUntil(ModalRoute.withName(newRouteName));
  }

  pushNamedAndRemoveUntil(String newRouteName, {arguments}) {
    return navigatorState?.pushNamedAndRemoveUntil(
        newRouteName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _routeInfo ??= RouteInfo(null, <Route>[]);

    ///这里过滤调push的是dialog的情况
    if (route is CupertinoPageRoute ||
        route is MaterialPageRoute ||
        route is Left2RightRouter) {
      _routeInfo?.routes.add(route);

      var name = route.settings.name;
      debugPrint('routeName==============push===$name');
      if (name != null) {
        _routeNames.add(name);
      }
      routeObserver();
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace();
    if (newRoute is CupertinoPageRoute ||
        newRoute is MaterialPageRoute ||
        newRoute is Left2RightRouter) {
      _routeInfo?.routes.remove(oldRoute);
      _routeInfo?.routes.add(newRoute!);

      var oldName = oldRoute!.settings.name;
      var newName = newRoute!.settings.name;
      debugPrint('routeName==============didReplace===$oldName,,,,$newName');
      if (_routeNames.contains(oldName)) {
        _routeNames.remove(oldName);
      }
      if (newName != null) {
        _routeNames.add(newName);
      }
      routeObserver();
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is CupertinoPageRoute ||
        route is MaterialPageRoute ||
        route is Left2RightRouter) {
      _routeInfo?.routes.remove(route);

      var name = route.settings.name;
      debugPrint('routeName==============didPop===$name');
      if (_routeNames.contains(name)) {
        _routeNames.remove(name);
      }
      routeObserver();
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route is CupertinoPageRoute ||
        route is MaterialPageRoute ||
        route is Left2RightRouter) {
      _routeInfo?.routes.remove(route);

      var name = route.settings.name;
      debugPrint('routeName==============didRemove===$name');
      if (_routeNames.contains(name)) {
        _routeNames.remove(name);
      }
      routeObserver();
    }
  }

  void routeObserver() {
    if (_routeInfo != null) {
      _routeInfo!.currentRoute = _routeInfo!.routes.last;
      navigatorState = _routeInfo!.currentRoute?.navigator;
      debugPrint(
          "NavigationUtil: $navigatorState, currentRoute: ${_routeInfo!.currentRoute?.settings.name}");
      _streamController.sink.add(_routeInfo!);
    }
  }
}
