import 'package:flutter/material.dart';
import 'view/index.dart';
import 'package:flutter/services.dart';
import 'service.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hscs_flutter_app/global_config.dart';

class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => new MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {

  final viewModel = MineViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDA();
    getUserInfo();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.light,
    // ));
  }
  
  getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConfig.kToken).toString();
    setState(() {
      if(token != null){
        viewModel.userInfo(context);
      }
    });
  }

  Future getDA() async {
    await viewModel.getAD({"type": 57});
    setState(() {});
  }

  // ignore: non_constant_identifier_names
  Widget ADView() {
    if(viewModel.listData != null ){
      return MineADView(advertData: viewModel.listData);
    }else{
      print("55555");
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              MineHeadView(),
              MineActivityView(),
              ADView(),
              MineOtherView(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
