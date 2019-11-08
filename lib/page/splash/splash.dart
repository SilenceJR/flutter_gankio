import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/futureProvider/future_view.dart';
import 'package:flutter_gankio/futureProvider/load_image.dart';
import 'package:flutter_gankio/model/gank_image_model.dart';
import 'package:flutter_gankio/model/gank_model.dart';
import 'package:flutter_gankio/net/http_util.dart';
import 'package:flutter_gankio/routers/navigator_utils.dart';
import 'package:flutter_gankio/routers/routers.dart';
import 'package:oktoast/oktoast.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment(0.94, -0.8),
        children: <Widget>[
          Positioned.fill(
            child: FutureView(
              isFull: true,
              loadData: _loadData(),
              childView: (json) {
                String imageUrl = '';
                if (json.results.isNotEmpty) {
                  imageUrl = json.results[0].url;
                }
                return LoadImage(
                  imageUrl,
                  holderImg: "assets/images/splash.jpg",
                  format: "",
                );
                // return Container();
              },
            ),
          ),
          SplashTimeWidget()
        ],
      ),
    );
  }

  Future<BaseEntity<GankImageModel>> _loadData() async {
    return await HttpUtils.getInstance().getSync<GankImageModel>(
        "http://gank.io/api/data/${Uri.encodeComponent("福利")}/1/1", null);
  }
}

class SplashTimeWidget extends StatefulWidget {
  @override
  _SplashTimeWidgetState createState() => _SplashTimeWidgetState();
}

class _SplashTimeWidgetState extends State<SplashTimeWidget> {
  StreamController _controller = StreamController();
  StreamSink _sink;

  int _endTime = 5;
  Timer _timer;

  @override
  void initState() {
    _endTimeState();
    _sink = _controller.sink;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _close();
        _goHomePage();
      },
      child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: StreamBuilder(
            initialData: _controller.stream.listen,
            stream: _controller.stream,
            builder: (ctx, snapshot) {
              return FlatButton(
                onPressed: () {},
                child: Text("${snapshot.data}"),
              );
            },
          )),
    );
  }

  _endTimeState() {
    _timer = Timer.periodic(Duration(seconds: _endTime), (time) {
//      setState(() {
//        _endTime--;
//      });
      _sink.add(_endTime--);
      if (_endTime == 0) {
        _close();
        _goHomePage();
      }
    });
  }

  _goHomePage() {
    NavigatorUtils.push(context, Routes.home, replace: true, clearStack: true);
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  _close() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    if (null != _controller) {
      _controller.close();
      _controller = null;
    }
  }
}
