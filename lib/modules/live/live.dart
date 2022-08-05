import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';

class LivePage extends StatefulWidget {
  @override
  LivePageState createState() => new  LivePageState();
}

class LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("直播"),
          backgroundColor: AppColors.theme,
          centerTitle: true,
        ),
        body: new Center(
          child: new Text("直播"),
        ),
      ),
    );
  }
}