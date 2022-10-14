import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'model/index.dart';
import 'view/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>  _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final viewModel = HomeViewModel();
  final EasyRefreshController _controller = EasyRefreshController();

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
    _controller.resetLoadState();
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

  Future  _onRefresh() async {
    print("_onRefresh");
    _controller.callRefresh();
    getHomeData();
  }

  // Future _onLoad() async{
  //   print("_onLoad");
  // }

  @override
  Widget build(BuildContext context){
    super.build(context);
    if(viewModel.homeData == null){
      return Scaffold();
    }
    return Scaffold(
      body: EasyRefresh(
        controller: _controller,
        onRefresh: _onRefresh,
        header: ClassicalHeader(
            refreshText: "下拉刷新",
            refreshReadyText: "释放刷新",
            refreshingText: "刷新中...",
            refreshedText: "刷新完成",
            refreshFailedText: "刷新失败",
            noMoreText: "没有更多",
            showInfo: true,
            infoText: "更新时间 %T",
        ),
        // onLoad: _onLoad,
        // enableControlFinishLoad: true,
        // enableControlFinishRefresh: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              HomeTopFocusView(infos: viewModel.homeData?.topFocus?.infos),
              HomeSudokuView(iconList: viewModel.homeData?.iconList),
              HomeMarqueeView(text: "8月8日上午，第二艘国产大型邮轮（H1509船）在中国船舶集团有限公司旗下上海外高桥造船有限公司（下称“外高桥造船”）开工建造。",),
              viewModel.fundData != null ? HomeMarketView(fundList: viewModel.fundData?.fundList,) : Container(),
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