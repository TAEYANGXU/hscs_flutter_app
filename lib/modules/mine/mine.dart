import 'package:flutter/material.dart';
import 'view/index.dart';
import 'package:flutter/services.dart';
import 'service.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';

class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => new MinePageState();
}

class MinePageState extends State<MinePage> {

  final viewModel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDA();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ));
  }

  Future getDA() async {
    await viewModel.getAD();
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
}
