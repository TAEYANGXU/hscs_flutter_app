import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/color.dart';
import 'package:hscs_flutter_app/modules/main/main.dart';
import 'global_config.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'routers.dart';
import 'modules/main/router.dart';
import 'package:hscs_flutter_app/utils/index.dart';

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
      routes: {
        MainRouter.init:(context) => HSInitPage(),
      },
      initialRoute: MainRouter.init,
    );
  }
}

class HSInitPage extends StatefulWidget {
  // const HSApp({Key? key}) : super(key: key);
  @override
  HSInitPageState  createState() => HSInitPageState();
}

class HSInitPageState extends State<HSInitPage>
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
