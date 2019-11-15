import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/model/gank_io_welfare_model_entity.dart';
import 'package:flutter_gankio/weiget/title_card.dart';
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

  List<GankIoWelfareModel> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNet();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: StaggeredGridView.countBuilder(
        itemCount: _list.length,
        itemBuilder: (ctx, index) {
          GankIoWelfareModel list = _list[index];
          return TitleCard(img: list.url,title: list.type,);
        },
        crossAxisCount: null,
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(2);
        },
      ),
    );
  }

  void _initNet() async{

  }
}
