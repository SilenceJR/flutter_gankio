import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawerWidget(),
      drawerScrimColor: Colors.white,
      drawerDragStartBehavior: DragStartBehavior.down,
      appBar: AppBar(
        centerTitle: true,
        title: Text("GankIo", style: TextStyle(),),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 25,
              child: Row(
                children: <Widget>[],
              ),
            ),
            Container(
              child: Text("首页"),
            ),
          ],
        ),
      ),
    );
  }

  _drawerWidget() {
    return ListView(
      padding: const EdgeInsets.only(right: 100),
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("images/splash.jpg"),),
          onDetailsPressed: () {},
          accountName: Text("用户名"),
          accountEmail: null,
          
          // arrowColor: Colors.white,
        ), 
        ListTile(title: Text("fasfaf")),
        DrawerHeader(child: ListTile(title: Text("fasfaf"),),),
        AboutListTile(
          icon: Image.asset("images/splash.jpg"),
          applicationName: "Gankio",
          applicationVersion: "0.0.1",
          applicationLegalese: "版权为个人所有",
          
        )
      ],
    );
  }
}
