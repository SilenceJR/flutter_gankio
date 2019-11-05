import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/futureProvider/future_view.dart';
import 'package:flutter_gankio/futureProvider/load_image.dart';
import 'package:flutter_gankio/net/http_util.dart';
import 'package:oktoast/oktoast.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment(0.94, -0.8),
        children: <Widget>[
          Positioned.fill(
            child: FutureView<dynamic>(
              isFull: true,
              loadData: _loadData(),
              childView: (json) {
                LogUtil.e("json: $json");
                return LoadImage(json);
                // return Container();
              },
            ),
          ),
          Text("测试")
        ],
      ),
    );
  }

  _loadData() async{
    return await HttpUtils.getInstance().getSync(
        "http://gank.io/api/data/${Uri.encodeComponent("福利")}/1/1",null);
  }
}
