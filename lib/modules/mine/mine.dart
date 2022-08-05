import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';

class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => new  MinePageState();
}

class MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("我的"),
          backgroundColor: AppColors.theme,
          centerTitle: true,
        ),
        body: new Center(
          child: new Text("我的"),
        ),
      ),
    );
  }
}