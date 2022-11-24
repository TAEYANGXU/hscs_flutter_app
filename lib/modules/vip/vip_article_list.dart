import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../extension/loading_icon.dart';
import '../../global_config.dart';
import '../../style/index.dart';
import '../../utils/index.dart';
import 'service.dart';

class VipArticleListPage extends StatefulWidget{
  VipArticleListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipArticleListPageState();
  }
}

class _VipArticleListPageState extends State<VipArticleListPage> {

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
    await viewModel.getColumnList2({"type":2,"page":page,"pageSize":pageSize});
    setState(() {
      page += 1;
    });
  }

  Widget _cellForRow(BuildContext context,int index){
    var model =  viewModel.moreColumnList![index];
    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":model.detailLink});
        // var title = data.title!;
        // debugPrint("title = $title");
      },
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(110),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      height: Adapt.px(60),
                      child: Text(model.title ?? "",
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: TextSize.main1,color: AppColors.text),
                      ),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(25 + 120),
                      padding: EdgeInsets.only(top: Adapt.px(10),left: Adapt.px(15)),
                      height: Adapt.px(40),
                      child: Text(model.createdAt ?? "",style: const TextStyle(fontSize: TextSize.main,color: AppColors.gredText),),
                    ),
                  ],
                ),
                // SizedBox(width: Adapt.px(10),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: Adapt.px(15)),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: model.coverPic!.isNotEmpty ? CacheImage(imageUrl: model.coverPic!,width: Adapt.px(90),height: Adapt.px(70),) : Container(),
                    )
                  ],
                ) ,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.px(109),left: Adapt.px(10),right: Adapt.px(10)),
            height: Adapt.px(0.5),
            color: AppColors.line,
          )
        ],
      ),
    );
  }

  void _onRefresh() async{
    // monitor network fetch
    print("_onRefresh");
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    print("_onLoading");
    fetchData();
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: loadLocalImage("page_back",
                width: Adapt.px(11), height: Adapt.px(18)),
          ),
          title: const Text(
            "理财头条",
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
          child: ListView.builder(itemBuilder: _cellForRow,
          itemCount:  viewModel.moreColumnList!.isNotEmpty ? viewModel.moreColumnList!.length : 0,
          ),
        )
    );
  }
  
}