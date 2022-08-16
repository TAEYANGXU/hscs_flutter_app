import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';


class LoginHeadView extends StatefulWidget {

  LoginHeadView({Key? key,this.title = "",this.content = ""}) : super(key:key);

  @required String title;
  @required String content;

  @override
  _LoginHeadViewState createState() => _LoginHeadViewState();
}

class _LoginHeadViewState extends State<LoginHeadView> {

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
              widget.title,
              style: TextStyle(
                  fontSize: TextSize.s22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Adapt.px(5),
          ),
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20)),
            child: Text(widget.content,
                style: TextStyle(
                    fontSize: TextSize.main1, fontWeight: FontWeight.normal)),
          )
        ],
      ),
    );
  }
}
