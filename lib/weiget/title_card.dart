import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gankio/futureProvider/load_image.dart';

class TitleCard extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final String authorUrl;
  final String type;
  final String worksAspectRatio;

  TitleCard(
      {this.img,
      this.title,
      this.author,
      this.authorUrl,
      this.type,
      this.worksAspectRatio});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.deepOrange,
            child: LoadImage('$img'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 20),
            color: Color(0x80000000),
            child: Text(
              '$title',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
