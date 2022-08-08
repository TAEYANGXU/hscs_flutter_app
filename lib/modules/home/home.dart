import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new  HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

   Future getData() async {
    var model = await DioManagerUtils.get("/v3/home/index2");
    var data = model.data;
    return model;
  }

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