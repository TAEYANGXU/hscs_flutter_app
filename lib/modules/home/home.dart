import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/home_model.dart';

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
    var HomeDataModel = HomeData.fromJson(model.data!);
    var vipH5Url =  HomeDataModel.vipH5Url;
    print("vipH5Url = $vipH5Url");
    // return model;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text("首页"),
      ),
    );
  }
}