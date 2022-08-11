import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'model/index.dart';
import 'view/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'service.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new  HomePageState();
}

class HomePageState extends State<HomePage> {

  final viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
    getFundData();
    getHeadlineTop();
    getBottomAD();
  }

   Future getHomeData() async {
    await viewModel.getHomeData();
    setState(() {});
  }

  Future getFundData() async {
    await viewModel.getFundData();
    setState(() { });
  }

  Future getHeadlineTop() async {
    await viewModel.getHeadlineTop();
    setState(() {});
  }

  Future getBottomAD() async {
    await viewModel.getBottomAD();
    setState(() {});
  }

  Widget bottomView(AdvertListData? listData) {
      if(listData != null ){
          return HomeBottomView(advertData: listData,);
      }else{
        return Container();
      }
  }

  Future  _onRefresh() async {
      getHomeData();
  }

  @override
  Widget build(BuildContext context){
    if(viewModel.homeData == null){
      return Scaffold();
    }
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: EasyRefresh(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                HomeTopFocusView(infos: viewModel.homeData!.topFocus!.infos),
                HomeSudokuView(iconList: viewModel.homeData!.iconList),
                HomeMarqueeView(text: "8月8日上午，第二艘国产大型邮轮（H1509船）在中国船舶集团有限公司旗下上海外高桥造船有限公司（下称“外高桥造船”）开工建造。",),
                HomeMarketView(fundList: viewModel.fundData!.fundList,),
                HomeMasterView(chiefComment: viewModel.homeData!.chiefComment,askTeacher: viewModel.homeData!.askTeacher,),
                HomeHeadlineView(list: viewModel.headLineData!.list,),
                bottomView(viewModel.listData!),
                SizedBox(height: Adapt.px(30),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}