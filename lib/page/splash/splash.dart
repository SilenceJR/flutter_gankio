import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573731750872&di=8b643764bf2681b6c66bb04c487ac536&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2Ff042a5462aaf1e798ad2e2e0c4e70e74d3dc35cb.jpg',
                  holderImg: "assets/images/splash.jpg",
                  format: "",
                );
                // return Container();
              },
              waitingView: Image.asset('assets/images/splash.jpg'),
              activeView: Image.asset('assets/images/splash.jpg'),
              noneView: Image.asset('assets/images/splash.jpg'),
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

class FillImage extends StatefulWidget {
  final imageUrl;
  FillImage({this.imageUrl});

  @override
  _FillImageState createState() => _FillImageState();
}

class _FillImageState extends State<FillImage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return LoadImage(
      widget.imageUrl,
      holderImg: "assets/images/splash.jpg",
      format: "",
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SplashTimeWidget extends StatefulWidget {
  @override
  _SplashTimeWidgetState createState() => _SplashTimeWidgetState();
}

class _SplashTimeWidgetState extends State<SplashTimeWidget> {
  int _endTime = 5;
  Timer _timer;

  @override
  void initState() {
    _endTimeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      width: 45,
      height: 45,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          _close();
          _goHomePage();
        },
        child: Text('$_endTime'),
      ),
    );
  }

  _endTimeState() {
    _timer = Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        _endTime--;
      });
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
  }
}
