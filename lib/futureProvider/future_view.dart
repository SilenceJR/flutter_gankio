import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/futureProvider/view_state_widget.dart';

///带状态的View
///[child]需要正确显示的childWidget
///[loadData]加载数据的方法
///[isFull]是否是铺满的
class FutureView<T> extends StatelessWidget {
  final Widget child;
  final Future loadData;
  final bool isFull;
  final Function(T) childView;

  const FutureView({Key key, this.loadData, this.child, this.isFull, this.childView})  : super();



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData,
        builder: (ctx, snapshot) {
          ///准备阶段
          if (snapshot.connectionState == ConnectionState.none) {
            return Container();

            ///等待阶段
          } else if (ConnectionState.waiting == snapshot.connectionState) {
            return Center(
              child: CircularProgressIndicator(),
            );

            ///
          } else if (ConnectionState.active == snapshot.connectionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
            ///完成
          } else if (ConnectionState.done == snapshot.connectionState) {
            if (snapshot.hasError) {
              return ViewStateEmptyWidget(
                onPressed: () {},
                message: snapshot.error.toString(),
              );
            }
            return Material(
              child: childView(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
