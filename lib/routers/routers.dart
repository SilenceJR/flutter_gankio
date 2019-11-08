import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gankio/page/home/home.dart';
import 'package:flutter_gankio/page/splash/splash.dart';
import 'package:flutter_gankio/routers/404.dart';
import 'package:flutter_gankio/routers/i_routers.dart';

class Routes {
  static String home = "/home";

  static List<IRouter> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("未找到目标页");
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    HomePage()));

    _listRouter.clear();

    _listRouter.add(HomeRouter());

    /// 各自路由由各自模块管理，统一在此添加初始化
    // _listRouter.add(GoodsRouter());
    // _listRouter.add(OrderRouter());
    // _listRouter.add(StoreRouter());
    // _listRouter.add(AccountRouter());
    // _listRouter.add(SettingRouter());
    // _listRouter.add(StatisticsRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

class HomeRouter implements IRouter {
  String splashPage = "/splash";

  @override
  void initRouter(Router router) {
    router.define(splashPage,
        handler: Handler(handlerFunc: (_, params) => SplashPage()));
  }
}
