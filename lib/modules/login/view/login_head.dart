import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';

class LoginHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: Adapt.px(220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: Adapt.px(80), left: Adapt.px(20)),
              width: Adapt.px(25),
              height: Adapt.px(25),
              child: localImage("login/login_back",
                  width: Adapt.px(20),
                  height: Adapt.px(20),
                  fit: BoxFit.contain),
            ),
          ),
          SizedBox(
            height: Adapt.px(20),
          ),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            child: Text(
              "手机动态密码登录",
              style: TextStyle(
                  fontSize: TextSize.s22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Adapt.px(5),
          ),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            child: Text("未注册的手机号验证后将自动创建新账号",
                style: TextStyle(
                    fontSize: TextSize.main1, fontWeight: FontWeight.normal)),
          )
        ],
      ),
    );
  }
}
