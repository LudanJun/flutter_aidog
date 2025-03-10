import 'package:aidog/app.dart';
import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/global_provider/global_net_provider.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    BuildContext? context = navigatorKey.currentContext;
    if (context != null && route.settings.name == RoutersName.tabsPage) {
      final GlobalNetProvider globalNetProvider =
          Provider.of<GlobalNetProvider>(
        context,
        listen: false,
      );
      globalNetProvider.cancelNetEventStream();
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    BuildContext? context = navigatorKey.currentContext;
    //RoutersName.tabsPage加个这个 点击dialog弹框就不会逐渐黑屏
    if (context != null && route.settings.name == RoutersName.tabsPage) {
      final GlobalNetProvider globalNetProvider =
          Provider.of<GlobalNetProvider>(context, listen: false);
      globalNetProvider.startNetEventStream();
    }
    super.didPop(route, previousRoute);
  }
}
