import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'view/index.dart';
import 'service.dart';

class VipPage extends StatefulWidget {
  @override
  VipPageState createState() => new VipPageState();
}

class VipPageState extends State<VipPage> with SingleTickerProviderStateMixin {
  TabController? tabController;
  var viewModel = VipRecommendViewModel();

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getVipTopTableList();
    await viewModel.getVipIconList();
    await viewModel.getReportList();
    await viewModel.getAudioActList();
    await viewModel.getLiveActList();
    await viewModel.getColumnList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        backgroundColor: AppColors.text,
        elevation: 0,
        title: VipUserView(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
              isScrollable: true,
              //未选择样式
              unselectedLabelStyle: TextStyle(fontSize: TextSize.big),
              //选择样式
              labelStyle: const TextStyle(
                  fontSize: TextSize.s20, fontWeight: FontWeight.w200),
              //选中的颜色
              labelColor: HexColor("#EEE4C1"),
              //未选中的颜色
              unselectedLabelColor: HexColor("#EEE4C1"),
              //自定义指示器
              indicatorColor: Colors.black,
              // // 指示器的大小
              indicatorSize: TabBarIndicatorSize.label,
              // // 指示器的权重，即线条高度
              indicatorWeight: 0.01,
              // indicatorPadding: EdgeInsets.only(bottom: Adapt.px(10)),
              tabs: const [
                Tab(text: "推荐"),
                Tab(text: "跟投精选"),
                Tab(text: "独家报告"),
                Tab(text: "精品课程"),
              ],
              controller: tabController,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          VipRecommendPage(
            reportList: viewModel.repostList ?? [],
            iconList: viewModel.iconList,
            audio: viewModel.audio,
            liveData: viewModel.liveData,
            columnList: viewModel.columnList,
          ),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
