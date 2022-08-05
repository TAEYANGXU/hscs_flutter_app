import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new  HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("首页"),
          backgroundColor: AppColors.theme,
          centerTitle: true,
        ),
        body: new Center(
          child: new Text("首页"),
        ),
      ),
    );
  }
}