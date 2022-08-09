import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/color.dart';
import 'package:hscs_flutter_app/modules/main/main.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'global_config.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'routers.dart';

class HSApp extends StatefulWidget {
  // const HSApp({Key? key}) : super(key: key);
  @override
  HSAppState  createState() => HSAppState();
}

class HSAppState extends State<HSApp>
{

  @override
  void initState(){
    DioManagerUtils.init(baseUrl: GlobalConfig.baseUrl2);
    Routers.initRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: '哈哈',
      theme: ThemeData(primaryColor: AppColors.theme),
      home:HSHoneApp(),
    );
  }
}

class HSHoneApp extends StatefulWidget {
  // const HSApp({Key? key}) : super(key: key);
  @override
  HSHoneState  createState() => HSHoneState();
}

class HSHoneState extends State<HSHoneApp>
{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Adapt.init(context);
    return Scaffold(
      body: MainPage(),
    );
  }
}
