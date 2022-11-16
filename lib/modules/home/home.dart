import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'model/index.dart';
import 'view/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>  _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final viewModel = HomeViewModel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData();
    getFundData();
    getHeadlineTop();
    getBottomAD();
    if (mounted) setState(() {});
  }

   Future getHomeData() async {
    await viewModel.getHomeData();
    setState(() { });
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
    await viewModel.getAD({"type":22});
    setState(() {});
  }

  Widget bottomView(AdvertListData? listData) {
      if(listData != null ){
          return HomeBottomView(advertData: listData,);
      }else{
        return Container();
      }
  }

  void _onRefresh() async{
    print("_onRefresh");
    getHomeData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    print("_onLoading");

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context){
    super.build(context);
    if(viewModel.homeData == null){
      return Scaffold();
    }
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: CustomHeader(
          builder: (context,mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body = const Text("下拉刷新");
            }
            else if(mode==LoadStatus.loading){
              body = const CupertinoActivityIndicator();
            }
            else{
              body = Text("下拉刷新 ${DateTime.now().toString().substring(10,16)}");
            }
            return  SizedBox(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              HomeTopFocusView(infos: viewModel.homeData?.topFocus?.infos),
              HomeSudokuView(iconList: viewModel.homeData?.iconList),
              HomeMarqueeView(text: "8月8日上午，第二艘国产大型邮轮（H1509船）在中国船舶集团有限公司旗下上海外高桥造船有限公司（下称“外高桥造船”）开工建造。",),
              viewModel.fundData != null ? HomeMarketView(fundData: viewModel.fundData,) : Container(),
              HomeMasterView(chiefComment: viewModel.homeData?.chiefComment,askTeacher: viewModel.homeData?.askTeacher,),
              HomeHeadlineView(list: viewModel.headLineData?.list,),
              bottomView(viewModel.adData),
              SizedBox(height: Adapt.px(30),)
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