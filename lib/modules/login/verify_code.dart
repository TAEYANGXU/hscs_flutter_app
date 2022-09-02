import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'view/index.dart';
import 'service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/modules/main/router.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginVeriftyCodePage extends StatefulWidget {
  LoginVeriftyCodePage({Key? key, this.mobile = ""}) : super(key: key);
  String mobile;
  @override
  _LoginVeriftyCodePageState createState() => _LoginVeriftyCodePageState();
}

class _LoginVeriftyCodePageState extends State<LoginVeriftyCodePage> {

  final loginViewModel = LoginViewModel();
  final TextEditingController codeController = TextEditingController();

  ///验证码输入完成
  void complteAction(String value){
    print("number =${codeController.text + value}");
    doLogin(value.trim());
  }

  ///重新获取验证码
  void requestCode(){
    getVerityCode();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVerityCode();
  }

  Future getVerityCode() async
  {
    await loginViewModel.verityCode(widget.mobile);
    if(loginViewModel.verity!.code != 200 && loginViewModel.verity?.msg != null){
      Fluttertoast.showToast(msg: loginViewModel.verity!.msg!);
      return;
    }
    setState(() {});
  }

  Future doLogin(String code) async {
    EasyLoading.show(status: "正在登录");
    bool suc = await loginViewModel.login(widget.mobile, code,context);
    setState(() {
      EasyLoading.dismiss();
      if(suc) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }else{
        Fluttertoast.showToast(msg: "登录失败");
        print("登录失败");
      }
      // Routers.push(context, MainRouter.main, params: {"tabIndex":"3"});
    });
  }

  Widget verityCodeView(){
    if(loginViewModel.verity != null){
      if(loginViewModel.verity?.code == 200){
        return LoginVeriftyCodeView(codeController: codeController,onCompleted: complteAction,seconds: 60,);
      }
      return LoginVeriftyCodeView(codeController: codeController,onCompleted: complteAction,seconds: 0,);
    }else{
      return LoginVeriftyCodeView(codeController: codeController,onCompleted: complteAction,seconds: 0,);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              LoginHeadView(title: "输入4位验证码",content: "验证码已发送至+86${widget.mobile}",),
              verityCodeView(),
            ],
          ),
        ),
      ),
    );
  }
}