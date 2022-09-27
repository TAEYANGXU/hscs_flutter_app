import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global_config.dart';
import 'model/user.dart';
import 'service.dart';
import 'dart:convert' as Convert;
import 'view/integral_list.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class MineIntegralPage extends StatefulWidget {
  MineIntegralPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MineIntegralPageState();
}

class _MineIntegralPageState extends State<MineIntegralPage> {
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
    await viewModel.integralGoodsList({"user_id":userModel.uid});
    await viewModel.getAD({"type":"53"});
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
      backgroundColor: HexColor("F7F7F7"),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: Adapt.px(220),
                    decoration: BoxDecoration(
                      color: HexColor("F7F7F7"),
                      gradient: LinearGradient(colors: [HexColor("#FF8837"),HexColor("#FFA345")],begin: Alignment.topRight,end: Alignment.bottomRight),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(44)),
                    height: Adapt.px(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: Adapt.px(15)),
                            child: loadLocalImage("mine/integral_white_back",
                                width: Adapt.px(14), height: Adapt.px(22)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: Adapt.px(40)),
                          child: const Center(
                            child: Text("积分中心",style:  TextStyle(fontSize: TextSize.larger,color: Colors.white),),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":"https://wxpay.jinoufe.com/user/score"});
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: Adapt.px(15)),
                            child: const Text("积分规则",style:  TextStyle(fontSize: TextSize.main,color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(120),left: Adapt.px(15)),
                    width: Adapt.px(200),
                    height: Adapt.px(80),
                    // color: Colors.yellow,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: Adapt.px(40),
                          child: Row(
                            children: [
                              Container(
                                height: Adapt.px(40),
                                child: Text("100",style: TextStyle(fontSize: TextSize.s36,fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                              SizedBox(width: Adapt.px(5),),
                              Container(
                                padding: EdgeInsets.only(top: Adapt.px(8)),
                                height: Adapt.px(30),
                                child: const Text("积分",style: TextStyle(fontSize: TextSize.big,color: Colors.white),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Adapt.px(5),),
                        GestureDetector(
                          onTap: (){
                            print("查看积分明细");
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text("查看积分明细",style: TextStyle(color: HexColor("#FED7B4")),),
                                SizedBox(width: Adapt.px(5),),
                                loadLocalImage("mine/integral_arrown",width: Adapt.px(6),height: Adapt.px(10)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: Adapt.px(220) - Adapt.px(130),left: Adapt.screenW() - Adapt.px(137) - Adapt.px(20)),
                    child: loadLocalImage("mine/integral_logo",
                        width: Adapt.px(137), height: Adapt.px(139)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(200)),
                    width: double.infinity,
                    height: Adapt.px(50),
                    decoration: BoxDecoration(
                      color: HexColor("F7F7F7"),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Adapt.px(100),
                          // height: Adapt.px(50),
                          // color: Colors.yellow,
                          child: Row(
                            children: [
                              Container(
                                width: Adapt.px(3),
                                height: Adapt.px(10),
                                margin: EdgeInsets.only(left: Adapt.px(15)),
                                decoration: BoxDecoration(
                                  color: HexColor("#F39D30"),
                                  borderRadius: BorderRadius.circular(1.5)
                                ),
                              ),
                              SizedBox(width: Adapt.px(5),),
                              Text("兑好礼",style: TextStyle(fontSize: TextSize.main1,fontWeight: FontWeight.bold,color: AppColors.text),)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            print("更多福利");
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: Adapt.px(15)),
                            width: Adapt.px(64),
                            // height: Adapt.px(50),
                            child: Container(
                              width: Adapt.px(64),
                              height: Adapt.px(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: HexColor("#C5C6CB"))
                              ),
                              child: Center(child:  Text("更多福利",style: TextStyle(color: HexColor("#62666C"),fontSize: TextSize.small),),),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              viewModel.integralList.isNotEmpty ? IntegralListView(integralList: viewModel.integralList,) : Container(),
              GestureDetector(
                onTap: () async {
                  await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":viewModel.listData?.linkUrl});
                },
                child: Container(
                  margin: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15)),
                  height: Adapt.px(70),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: viewModel.listData != null ? CacheImage(imageUrl: viewModel.listData?.imgUrl,height: Adapt.px(70),width: double.infinity,) : Container(),
                ),
              ),
              SizedBox(height: Adapt.px(50),),
            ],
          ),
        ),
      ),
    );
  }
}