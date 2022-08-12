import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';

class LoginOtherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: Adapt.,
      child: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                "其他登录方式",
                style: TextStyle(
                    fontSize: TextSize.main1, color: AppColors.gredText),
              ),
            ),
          ),
          SizedBox(height: Adapt.px(20),),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    localImage("login/login_wx",width: Adapt.px(40),height: Adapt.px(40)),
                    SizedBox(width: Adapt.px(10),),
                    Text("微信登录",style: TextStyle(color: AppColors.gredText),)
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Row(
                  children: [
                    localImage("login/login_cmcc",width: Adapt.px(40),height: Adapt.px(40),fit: BoxFit.cover),
                    SizedBox(width: Adapt.px(10),),
                    Text("一键登录",style: TextStyle(color: AppColors.gredText),)
                  ],
                ),
                flex: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LoginProtocolView extends StatefulWidget {

  LoginProtocolView({Key? key}) : super(key: key);

  _LoginProtocolViewState createState() => _LoginProtocolViewState();
}

class _LoginProtocolViewState extends State<LoginProtocolView> {

  bool selected = true;
  // String checkImg = selected ? "login/login_agree_2" : "login/login_agree_1";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Adapt.px(50),
      // color: Colors.red,
      margin: EdgeInsets.only(top: Adapt.px(120)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Adapt.px(50),
            // height: Adapt.px(60),
            // color: Colors.red,
            child: MaterialButton(onPressed: (){
              selected = !selected;
              setState(() {});
            },
              child: localImage(selected ? "login/login_agree_2" : "login/login_agree_1",width: Adapt.px(18),height: Adapt.px(18),fit: BoxFit.fill),
            ),
          ),
          Container(
            child: Text("登录表明您同意",style: TextStyle(color: AppColors.gredText)),
          ),
          Container(
            child: Text("《用户协议》",style: TextStyle(color: HexColor("#F39D30")),),
          ),
          Container(
            child: Text("和",style: TextStyle(color: AppColors.gredText)),
          ),
          Container(
            child: Text("《隐私政策》",style: TextStyle(color: HexColor("#F39D30"))),
          ),
        ],
      ),
    );
  }
}
