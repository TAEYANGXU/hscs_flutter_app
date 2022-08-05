import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';

class VipPage extends StatefulWidget {
  @override
  VipPageState createState() => new  VipPageState();
}

class VipPageState extends State<VipPage> {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("会员专区"),
          backgroundColor: AppColors.theme,
          centerTitle: true,
        ),
        body: new Center(
          child: new Text("会员专区"),
        ),
      ),
    );
  }
}