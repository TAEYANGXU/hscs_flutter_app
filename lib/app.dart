import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/style/color.dart';
import 'package:hscs_flutter_app/modules/main/main.dart';
import 'global_config.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'package:hscs_flutter_app/api/dio_user_manager.dart';
import 'routers.dart';
import 'modules/main/router.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as Convert;
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    DioManagerUserUtils.init(baseUrl: GlobalConfig.baseUrl);
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
      builder: EasyLoading.init(),
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
    getUserInfo();
  }

  void getUserInfo() async {

    var prefs = await SharedPreferences.getInstance();
    // prefs.remove(GlobalConfig.kUserInfo);
    var userInfo = prefs.get(GlobalConfig.kUserInfo).toString();
    print("userInfo=${userInfo}");
    var userInfoMap = Convert.jsonDecode(userInfo);
    Provider.of<UserInfo>(context,listen: false).setInfo(userInfoMap);

    var res = await GlobalConfig.channel.invokeMethod("lyitp://diqiu/userInfo",userInfo);
    print("访问swift = ${res}");
  }

  @override
  Widget build(BuildContext context){
    Adapt.init(context);
    return Scaffold(
      body: MainPage(),
    );
  }
}
