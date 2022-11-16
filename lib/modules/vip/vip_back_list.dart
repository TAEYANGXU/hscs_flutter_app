import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../extension/loading_icon.dart';
import '../../global_config.dart';
import 'service.dart';

class VipBackListPage extends StatefulWidget {
  VipBackListPage({Key? key,this.roomId,this.actId}) : super(key: key);
  int? roomId;
  int? actId;
  @override
  State<StatefulWidget> createState() => _VipBackListPageState();
}

class _VipBackListPageState extends State<VipBackListPage> {
  final viewModel = VipViewModel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  int  page = 1;
  int  pageSize = 20;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getReviewListByAct({"roomId":widget.roomId,"actId":widget.actId,"page":page ,"pageSize": pageSize});
    setState(() {
      page += 1;
    });
  }

  Widget _cellForRow(BuildContext context, int index) {

    var model = viewModel.backReviewList![index];
    model.index = index;
    return GestureDetector(
      onTap: () async {
        model.type = 2;
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/video_play",{"json": model.toJson(),"title":"直播回放"});
      },
      child: Container(
        color: Colors.white,
        height: Adapt.px(100),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10),bottom: Adapt.px(10)),
              width: Adapt.px(120),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Stack(
                children: [
                  CacheImage(imageUrl: model.coverPic,width: Adapt.screenW() - Adapt.px(20),height: Adapt.px(140),),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(20),left: Adapt.px(40)),
                    height: Adapt.px(40),
                    width: Adapt.px(40),
                    // color: Colors.red,
                    child: Center(
                      child: loadLocalImage("home_video_play",width: Adapt.px(26),height: Adapt.px(26)),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: Adapt.px(15),left: Adapt.px(10)),
                  width: Adapt.screenW() - Adapt.px(30 + 120),
                  height: Adapt.px(60),
                  child: Text(model.title ?? "",
                    maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: TextSize.big,color: AppColors.text),
                  ),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(25 + 120),
                  padding: EdgeInsets.only(top: Adapt.px(5),left: Adapt.px(10)),
                  height: Adapt.px(40),
                  child: Text(model.createTime ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onRefresh() async{
    // monitor network fetch
    print("_onRefresh");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    print("_onLoading");
    fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: const Text(
          "直播回放",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (context,mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  const Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body = const CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = const Text("加载失败！点击重试！");
            }
            else if(mode == LoadStatus.canLoading){
              body = const Text("松手,加载更多!");
            }
            else{
              body = const Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: _cellForRow,
          itemCount: viewModel.backReviewList!.isNotEmpty ? viewModel.backReviewList!.length : 0,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}