import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'model/home_video.dart';
import 'service.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/global_config.dart';

class VideoListPage extends StatefulWidget {

  VideoListPage({Key? key,this.type}) : super(key: key);
  String? type = "2";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoListPageState();
  }
}

class _VideoListPageState extends State<VideoListPage> {

  final HomeViewModel viewModel = HomeViewModel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  int  page = 1;
  int  pageSize = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    getVideoListByType();
  }

  Future fetchData() async {
    await viewModel.getAD({"type":5});
    setState(() {
    });
  }

  Future getVideoListByType() async {
    await viewModel.getVideoListByType({"actType": widget.type,"page":page,"pageSize":pageSize});
    setState(() {
      page +=1;
    });
  }

  Widget _cellForRow(BuildContext context, int index) {

    if(viewModel.adData != null && index == 0){
      return GestureDetector(
        onTap: () async {
          if(viewModel.adData!.linkUrl!.isNotEmpty){
            await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":viewModel.adData!.linkUrl});
          }
        },
        child: Container(
          height: Adapt.px(140),
          margin: EdgeInsets.all(Adapt.px(10)),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6)
          ),
          child: CacheImage(imageUrl: viewModel.adData!.imgUrl,width: Adapt.screenW() - Adapt.px(20),height: Adapt.px(140),),
        ),
      );
    }
    var model = viewModel.videoList[index - 1];
    model.index = index - 1;
    return GestureDetector(
      onTap: () async {
        model.type = 1;
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/video_play",{"json": model.toJson(),"title":"限时免费课"});
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
                  CacheImage(imageUrl: model.vCoverImgUrl,width: Adapt.screenW() - Adapt.px(20),height: Adapt.px(140),),
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
                  padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(10)),
                  width: Adapt.screenW() - Adapt.px(30 + 120),
                  // height: Adapt.px(50),
                  child: Text(model.vTitle ?? "",
                    maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: TextSize.big,color: AppColors.text),
                  ),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(25 + 120),
                  padding: EdgeInsets.only(top: Adapt.px(5),left: Adapt.px(10)),
                  height: Adapt.px(40),
                  child: Text(model.vContent ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
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
    getVideoListByType();
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
          "限时免费课",
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
          itemCount: viewModel.videoList.length + (viewModel.adData != null ? 1 : 0),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}