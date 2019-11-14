import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GankIoWelfarePage extends StatelessWidget {
  const GankIoWelfarePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GankIoWelfare extends StatefulWidget {
  @override
  _GankIoWelfareState createState() => _GankIoWelfareState();
}

class _GankIoWelfareState extends State<GankIoWelfare> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: StaggeredGridView.countBuilder(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return Card();
        },
        crossAxisCount: null,
        staggeredTileBuilder: (int index) {},
      ),
    );
  }
}
