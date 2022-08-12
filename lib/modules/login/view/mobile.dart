import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/extension/gradient_button.dart';

class LoginMobileView extends StatefulWidget {
  LoginMobileView({Key? key, this.mobileController}) : super(key: key);
  TextEditingController? mobileController;

  _LoginMobileViewState createState() => _LoginMobileViewState();
}

class _LoginMobileViewState extends State<LoginMobileView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: Adapt.px(300),
      // color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            child: Text(
              "手机号码",
              style: TextStyle(
                  fontSize: TextSize.big, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            width: double.infinity,
            height: Adapt.px(45),
            child: Row(
              children: [
                Container(
                  width: Adapt.px(40),
                  height: Adapt.px(25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Colors.black, width: Adapt.px(0.5))),
                  child: Center(
                    child: Text("+86"),
                  ),
                ),
                SizedBox(
                  width: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(90),
                  height: Adapt.px(35),
                  // color: Colors.red,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: widget.mobileController,
                    style: TextStyle(fontSize: TextSize.s22),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: Adapt.px(20)),
            width: Adapt.screenW() - Adapt.px(40),
            height: Adapt.px(1),
            color: AppColors.line,
          ),
          SizedBox(height: Adapt.px(80),),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20),right: Adapt.px(20)),
            height: Adapt.px(45),
            child: GradientButton(
              onPressed: () {
                print("text = ${widget.mobileController?.text}");
              },
              colors: [HexColor("#FFAB1A"), HexColor("#FB6700")],
              child: Text(
                '发送验证码',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TextSize.larger),
              ),
              borderRadius: BorderRadius.circular(Adapt.px(45)),
            ),
          ),
        ],
      ),
    );
  }
}
