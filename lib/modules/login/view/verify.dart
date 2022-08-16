import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

typedef OnCompleted = Function(String string);

class LoginVeriftyCodeView extends StatefulWidget {
  LoginVeriftyCodeView({Key? key, this.codeController, this.onCompleted,this.requestCode,this.seconds = 60})
      : super(key: key);
  TextEditingController? codeController;
  OnCompleted? onCompleted;
  Function? requestCode;
  int seconds = 60;
  _LoginVeriftyCodeViewState createState() => _LoginVeriftyCodeViewState();
}

class _LoginVeriftyCodeViewState extends State<LoginVeriftyCodeView> {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      widget.seconds--;
      if (widget.seconds < 0) {
        widget.seconds = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  Widget showText(int second) {
    if (widget.seconds == 0) {
      return GestureDetector(
        child: Text("重新获取验证码",
            style: TextStyle(color: AppColors.theme, fontSize: TextSize.big)),
        onTap: () {
          if(widget.requestCode != null){
            widget.requestCode!();
          }
          widget.seconds = 60;
          setState(() {});
        },
      );
    } else {
      return Text(
        "${second}秒后重新获取",
        style: TextStyle(color: AppColors.theme, fontSize: TextSize.big),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            child: Text(
              "4位验证码",
              style: TextStyle(fontSize: TextSize.big, color: AppColors.text),
            ),
          ),
          Container(
            width: Adapt.screenW() - Adapt.px(60),
            padding: EdgeInsets.only(
                left: Adapt.px(20), right: Adapt.px(20), top: Adapt.px(10)),
            child: PinCodeTextField(
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.yellow,
                  activeColor: AppColors.theme,
                  inactiveColor: AppColors.gredText),
              animationDuration: const Duration(milliseconds: 300),
              // backgroundColor: Colors.blue.shade50,
              // enableActiveFill: true,
              controller: widget.codeController,
              onCompleted: widget.onCompleted,
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  // currentText = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
              autoFocus: true,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: Adapt.px(20)),
            child: showText(widget.seconds),
          )
        ],
      ),
    );
  }
}
