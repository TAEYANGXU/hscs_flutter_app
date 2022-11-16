
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../extension/loading_icon.dart';
import '../../global_config.dart';
import 'model/article.dart';
import 'service.dart';
import 'view/vip_article_header.dart';
import 'view/vip_article_list.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class VipArticlePage extends StatefulWidget
{
  int? articleType;
  VipArticlePage({Key? key, this.articleType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipArticlePageState();
  }
}

class _VipArticlePageState extends State<VipArticlePage>
{

  final viewModel = VipViewModel();
  List<VipArticleList>? list = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  int  page = 1;
  int  pageSize = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  Future fetchData() async {
    await viewModel.getPDFList({"articleType":widget.articleType,"page":page ,"pageSize": pageSize});
    list?.addAll(viewModel.vipArticleData!.list!);
    setState(() {
      page += 1;
    });
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

  Widget _cellForRow(BuildContext context, int index) {

    var model = list![index];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.linkUrl});
      },
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(110),
            width: double.infinity,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      width: Adapt.screenW() - Adapt.px(190),
                      height: Adapt.px(20),
                      child: Text(model.title ?? "",
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: TextSize.big,color: AppColors.text,fontWeight: FontWeight.w600,),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(125),
                      margin: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      height: Adapt.px(40),
                      child: Text(model.summary ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.text),maxLines: 2,overflow:TextOverflow.ellipsis),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(115),
                      margin: EdgeInsets.only(top: Adapt.px(5),left: Adapt.px(15)),
                      height: Adapt.px(20),
                      child: Text(model.cTime ??="",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                SizedBox(width: Adapt.px(0),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: model.coverPic!.isNotEmpty ? CacheImage(imageUrl: model.coverPic ??="",width: Adapt.px(90),height: Adapt.px(70),) : Container(),
                    )
                  ],
                ) ,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(110),left: Adapt.px(15),right: Adapt.px(0)),
            height: Adapt.px(0.8),
            color: AppColors.line,
          ),
          model.isNew! ? Container(
            margin: EdgeInsets.only(left:Adapt.px(200),top: Adapt.px(5)),
            child: loadLocalImage("vip/vip_article_new",
                width: Adapt.px(25), height: Adapt.px(17)),
          ) : Container(),
        ],
      ),
    );
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
              expandedHeight: Adapt.px(235),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(""),
                background: viewModel.vipArticleData != null ? VipArticleHeaderView(articleData: viewModel.vipArticleData,) : Container(),
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
            itemCount: list!.isNotEmpty ? list!.length : 0,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}