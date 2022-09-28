import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global_config.dart';
import 'model/user.dart';
import 'service.dart';
import 'view/integral_list.dart';
import 'dart:convert' as Convert;

class MineIntegralMorePage extends StatefulWidget {
  MineIntegralMorePage({Key? key,this.type}) : super(key: key);
  int? type;
  @override
  State<StatefulWidget> createState() => _MineIntegralMorePageState();
}

class _MineIntegralMorePageState extends State<MineIntegralMorePage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    var prefs = await SharedPreferences.getInstance();
    var userModel = UserModel.fromJson(Convert.jsonDecode(prefs.get(GlobalConfig.kUserInfo).toString()));
    await viewModel.integralGoodsListByType({"user_id":userModel.uid,"goods_type":"1,2"});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.couponList[index];
    return GestureDetector(
      onTap: (){

      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "兑换好礼",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: Adapt.px(15),top: Adapt.px(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Adapt.px(3),
                      height: Adapt.px(10),
                      decoration: BoxDecoration(
                          color: HexColor("#F39D30"),
                          borderRadius: BorderRadius.circular(1.5)
                      ),
                    ),
                    SizedBox(width: Adapt.px(5),),
                    const Text("会员优惠",style: TextStyle(fontSize: TextSize.main1,fontWeight: FontWeight.bold,color: AppColors.text),)
                  ],
                ),
              ),
              viewModel.integralList.isNotEmpty ? IntegralListView(integralList: viewModel.integralList,) : Container(),
              Container(
                padding: EdgeInsets.only(left: Adapt.px(15),top: Adapt.px(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Adapt.px(3),
                      height: Adapt.px(10),
                      decoration: BoxDecoration(
                          color: HexColor("#F39D30"),
                          borderRadius: BorderRadius.circular(1.5)
                      ),
                    ),
                    SizedBox(width: Adapt.px(5),),
                    const Text("限时好礼",style: TextStyle(fontSize: TextSize.main1,fontWeight: FontWeight.bold,color: AppColors.text),)
                  ],
                ),
              ),
              viewModel.integralList.isNotEmpty ? IntegralListView(integralList: viewModel.integralList,) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}