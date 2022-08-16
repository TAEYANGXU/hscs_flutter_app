import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'view/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool selected = true;

  void complteAction(String number){
    print("number =$number");
    Routers.push(context, '${LoginRouter.loginVerity}?mobile=${number}');
    // Routers.push(context, LoginRouter.loginVerity);
  }

  final TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              LoginHeadView(title: "手机动态密码登录",content: "未注册的手机号验证后将自动创建新账号",),
              LoginMobileView(mobileController: mobileController,onCall: complteAction,),
              LoginOtherView(),
              LoginProtocolView(selected: selected,)
            ],
          ),
        ),
      ),
    );
  }
}