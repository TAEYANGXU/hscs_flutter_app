import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'view/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              LoginHeadView(),
              LoginMobileView(mobileController: mobileController,),
              LoginOtherView(),
              LoginProtocolView()
            ],
          ),
        ),
      ),
    );
  }
}