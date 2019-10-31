import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gankio/home.dart';
import 'package:flutter_gankio/net/http_util.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  _init();
  return runApp(MyApp());
}

_init() async {
  await SpUtil.getInstance();
  HttpUtils.getInstance();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Gank',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}