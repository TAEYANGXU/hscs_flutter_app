import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'model/index.dart';
import 'view/index.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new  HomePageState();
}

class HomePageState extends State<HomePage> {

  HomeData?  homeData;
  FundData?  fundData;
  HeadLineData? headLineData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
    getFundData();
    getHeadlineTop();
  }

   Future getHomeData() async {
    var model = await DioManagerUtils.get("/v3/home/index2");
    var data = model.data;
    homeData = HomeData.fromJson(data!);
    var vipH5Url =  homeData!.vipH5Url;
    debugPrint("vipH5Url = $vipH5Url");
    setState(() {});
  }

  Future getFundData() async {
    var model = await DioManagerUtils.get("/v3/fund/fund-list");
    var data = model.data;
    fundData = FundData.fromJson(data!);
    var h5Url =  fundData!.h5Url;
    debugPrint("h5Url = $h5Url");
    setState(() {});
  }

  Future getHeadlineTop() async {
    var model = await DioManagerUtils.get("/v3/headline/top");
    var data = model.data;
    headLineData = HeadLineData.fromJson(data!);
    var updatedAt =  headLineData!.updatedAt;
    debugPrint("updatedAt = $updatedAt");
    setState(() {});
  }
  @override
  Widget build(BuildContext context){
    if(homeData == null){
      return Scaffold();
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              HomeTopFocusView(infos: homeData!.topFocus!.infos),
              HomeSudokuView(iconList: homeData!.iconList),
              HomeMarqueeView(text: "8月8日上午，第二艘国产大型邮轮（H1509船）在中国船舶集团有限公司旗下上海外高桥造船有限公司（下称“外高桥造船”）开工建造。",),
              HomeMarketView(fundList: fundData!.fundList,),
              HomeMasterView(chiefComment: homeData!.chiefComment,askTeacher: homeData!.askTeacher,),
              HomeHeadlineView(list: headLineData!.list,),
              
              SizedBox(height: Adapt.px(30),)
            ],
          ),
        ),
      ),
    );
  }
}