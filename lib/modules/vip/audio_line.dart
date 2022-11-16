
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/modules/vip/view/audio_line_list.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'service.dart';
import 'view/vip_article_list.dart';
import 'view/audio_line_haeder.dart';

class VipAudioLinePage extends StatefulWidget
{
  int? actId;
  VipAudioLinePage({Key? key, this.actId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipAudioLinePageState();
  }
}

class _VipAudioLinePageState extends State<VipAudioLinePage>
{

  final viewModel = VipViewModel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  int  page = 1;
  int  pageSize = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    getAudioList();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  Future fetchData() async {
    await viewModel.getAudioDetail({"actId":widget.actId});
    setState(() {});
  }
  Future getAudioList() async {
    await viewModel.getAudioActList({"actId":widget.actId,"page":page ,"pageSize": pageSize});
    setState(() {
      page += 1;
    });
  }


  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.audioList![index];
    return GestureDetector(
      onTap: () async {
        // await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(90),
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(15)),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(15)),
                      child: loadLocalImage("vip/audio_play",
                          width: Adapt.px(7), height: Adapt.px(9)),
                    ),
                    SizedBox(
                      width: Adapt.px(5),
                    ),
                    Container(
                        height: Adapt.px(55),
                        margin: EdgeInsets.only(top: Adapt.px(10)),
                        width: Adapt.screenW() - Adapt.px(50),
                        child: Text(model.title ?? "",style: const TextStyle(fontSize: TextSize.main1),maxLines: 2,)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4,child: Container(
                      child: Row(
                        children: [
                          loadLocalImage("vip/audio_length",width: Adapt.px(13),height: Adapt.px(12)),
                          SizedBox(width: Adapt.px(5),),
                          Text(model.audioLength ?? "",style: const TextStyle(color: AppColors.gredText),),
                        ],
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(model.zmtime ?? "",style: const TextStyle(color: AppColors.gredText),),
                      ],
                    )
                  ],
                ),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Adapt.px(90), left: Adapt.px(15), right: Adapt.px(0)),
            height: Adapt.px(0.8),
            color: AppColors.line,
          ),
        ],
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
    getAudioList();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                ///
                child: loadLocalImage("vip/vip_white_back",
                    width: Adapt.px(12), height: Adapt.px(22)),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {

                  },
                  child: loadLocalImage("vip/vip_white_share",
                      width: Adapt.px(22), height: Adapt.px(22)),
                )],
              expandedHeight: Adapt.px(245),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(""),
                background: AudioLineHeaderView(actInfoData: viewModel.actInfo,),
              ),
            ),
          ];
        },
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
              itemCount: viewModel.audioList!.length,
              padding: EdgeInsets.zero,
            ),
        ),
      ),
    );
  }
}