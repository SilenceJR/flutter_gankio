import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gankio/futureProvider/load_image.dart';
import 'package:flutter_gankio/generated/i18n.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class ViewStateWidget extends StatefulWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;
  final bool initToggle;

  ViewStateWidget(
      {Key key,
        this.image,
//      = const Icon(IconFonts.pageError, size: 80, color: Color(0xFF9E9E9E))
        this.message,
        this.buttonText,
        @required this.onPressed,
        this.initToggle = false})
      : super(key: key);

  @override
  _ViewStateWidgetState createState() => _ViewStateWidgetState();
}

class _ViewStateWidgetState extends State<ViewStateWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.initToggle) {
      Future.delayed(Duration.zero, () {
        widget.onPressed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Offstage(
                offstage: widget.image == null ? true : false,
                child: Container(
                  margin:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
                  child: widget.image,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text(
                widget.message ?? "加载失败",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.grey),
              ),
            ),
            Center(
                child: Text(
                  "轻触屏幕重试",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ))
//            Offstage(
//              offstage: widget.buttonText == null ? true : false,
//              child: ViewStateButton(
//                child: widget.buttonText,
//                onPressed: widget.onPressed,
//              ),
//            )
          ],
        ),
      ),
    );
  }
}

///// 基础Widget
//class ViewStateWidget extends StatelessWidget {
//  final String message;
//  final Widget image;
//  final Widget buttonText;
//  final VoidCallback onPressed;
//
//  ViewStateWidget(
//      {Key key,
//      this.image,
//      this.message,
//      this.buttonText,
//      @required this.onPressed})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    onPressed();
//    return Center(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          image ?? Icon(IconFonts.pageError, size: 80, color: Colors.grey[500]),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(30, 20, 30, 150),
//            child: Text(
//              message ?? S.of(context).pageStateError,
//              style: Theme.of(context)
//                  .textTheme
//                  .body1
//                  .copyWith(color: Colors.grey),
//            ),
//          ),
//          ViewStateButton(
//            child: buttonText,
//            onPressed: onPressed,
//          )
//        ],
//      ),
//    );
//  }
//
//}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget(
      {Key key,
        this.image,
        this.message,
        this.buttonText,
        @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ??
//          const Icon(
//            IconFonts.pageEmpty,
//            size: 100,
//            color: Colors.grey,
//          ),
          const LoadAssetImage("icon_view_empty"),
      message: message ?? "暂无数据",
      buttonText: buttonText ??
          Text(
            "点击刷新",
            style: TextStyle(letterSpacing: 5),
          ),
    );
  }
}

///// 页面未授权
//class ViewStateUnAuthWidget extends StatelessWidget {
//  final String message;
//  final Widget image;
//  final Widget buttonText;
//  final VoidCallback onPressed;
//
//  const ViewStateUnAuthWidget(
//      {Key key,
//      this.image,
//      this.message,
//      this.buttonText,
//      @required this.onPressed})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return ViewStateWidget(
//      onPressed: this.onPressed,
//      image: image ?? ViewStateUnAuthImage(),
//      message: message ?? S.of(context).viewStateMessageUnAuth,
//      buttonText: buttonText ??
//          Text(
//            S.of(context).signIn,
//            style: TextStyle(wordSpacing: 5),
//          ),
//    );
//  }
//}
//
///// 未授权图片
//class ViewStateUnAuthImage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Hero(
//      tag: 'loginLogo',
//      child: Image.asset(
//        ImageHelper.wrapAssets('icon_view_empty.png'),
//        width: 130,
//        height: 100,
//        fit: BoxFit.fitWidth,
//        color: Theme.of(context).accentColor,
//        colorBlendMode: BlendMode.srcIn,
//      ),
//    );
//  }
//}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ViewStateButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
//    return CupertinoButton(child: child ??
//        Text(
//          S.of(context).pageStateRetry,
//          style: TextStyle(wordSpacing: 5, color: Colours.text_01C89F, backgroundColor: Colours.text_01C89F),
//        ),
//      onPressed: onPressed,
//    );

    return OutlineButton(
      child: child ??
          Text(
            "刷新",
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}
