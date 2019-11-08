import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gankio/app.dart';
import 'package:flutter_gankio/net/http_util.dart';
import 'package:flutter_gankio/page/splash/splash.dart';
import 'package:flutter_gankio/routers/routers.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  _init();
  return runApp(MyApp());
}

_init() async {
  await SpUtil.getInstance();
  LogUtil.init(isDebug: !Application.inProduction, tag: "Gank");
  HttpUtils.getInstance();
}

class MyApp extends StatelessWidget {

MyApp() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
}

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      child: MaterialApp(
        title: 'Gank',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
