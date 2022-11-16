import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'service.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:date_format/date_format.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'dart:convert';
import 'package:hscs_flutter_app/modules/web/router.dart';
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';

// ignore: must_be_immutable
class MineMSGListPage extends StatefulWidget {
  MineMSGListPage({Key? key, this.msgType}) : super(key: key);
  int? msgType;

  @override
  _MineMSGListPageState createState() =>  _MineMSGListPageState();
}

class _MineMSGListPageState extends State<MineMSGListPage> {
  final viewModel = MineViewModel();
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
    await viewModel
        .messageList({"page": page, "size": pageSize, "msg_type": widget.msgType});
    setState(() {
      page += 1;
    });
  }

  Widget _cell(BuildContext content, int index) {
    var model = viewModel.msgList[index];
    if (model.msgType == 5) {
      return _cellForRow2(content, index);
    }
    if (model.msgType == 2) {
      return _cellForRow3(content, index);
    }
    return _cellForRow(content, index);
  }

  Widget _cellForRow3(BuildContext content, int index) {
    var model = viewModel.msgList[index];

    Map<String, dynamic> map = json.decode(model.extJson.toString());
    var scheme = map["data"]["scheme"];
    print("scheme =${scheme}");

    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":scheme});
        // Routers.push(content, WebViewRouter.webView, params: {"url": scheme});
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: Adapt.px(15),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //model.createdAt
                  height: Adapt.px(25),
                  width: Adapt.px(100),
                  decoration: BoxDecoration(
                      color: HexColor("#E3E3E3"),
                      borderRadius: BorderRadius.circular(Adapt.px(25 / 2))),
                  //model.createdAt
                  child: Center(
                    child: Text(
                      model.createdAt!.substring(5, 16),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              // height: Adapt.px(190),
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: Adapt.px(15), right: Adapt.px(15), top: Adapt.px(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: Adapt.px(10), top: Adapt.px(10)),
                    child: Text(
                      '${model.msgDetail?.commentNickname}评论了你',
                      style: const TextStyle(
                          fontSize: TextSize.big,
                          color: AppColors.text,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: Adapt.px(10), top: Adapt.px(3)),
                    child: Text(model.msgDetail?.commentContent ?? "",
                        style: TextStyle(fontSize: TextSize.big)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: Adapt.px(10),
                        right: Adapt.px(10),
                        top: Adapt.px(5),
                        bottom: Adapt.px(10)),
                    decoration: BoxDecoration(
                        color: HexColor("#F0F0F0"),
                        borderRadius: BorderRadius.circular(3)),
                    child: Consumer<UserInfo>(
                      builder: (content, user, child) {
                        return Container(
                          margin: EdgeInsets.all(Adapt.px(6)),
                          child: Text(
                            '${user.info?.nickname}: ${model.msgDetail?.originalComment}',
                            style: const TextStyle(fontSize: TextSize.big),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cellForRow2(BuildContext content, int index) {
    var model = viewModel.msgList[index];

    Map<String, dynamic> map = json.decode(model.extJson.toString());
    var scheme = map["data"]["scheme"];
    print("scheme =${scheme}");

    return GestureDetector(
      onTap: () async {
        await GlobalConfig.channel.invokeMethod("lyitp://diqiu/webview",{"url":scheme});
        // Routers.push(content, WebViewRouter.webView, params: {"url": scheme});
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: Adapt.px(15),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //model.createdAt
                  height: Adapt.px(25),
                  width: Adapt.px(100),
                  decoration: BoxDecoration(
                      color: HexColor("#E3E3E3"),
                      borderRadius: BorderRadius.circular(Adapt.px(25 / 2))),
                  //model.createdAt
                  child: Center(
                    child: Text(
                      model.createdAt!.substring(5, 16),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              height: Adapt.px(190),
              margin: EdgeInsets.only(
                  left: Adapt.px(15), right: Adapt.px(15), top: Adapt.px(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6),
                    )),
                    child: CacheImage(
                      imageUrl: model.content,
                      width: double.infinity,
                      height: Adapt.px(150),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(3),
                  ),
                  SizedBox(
                    height: Adapt.px(30),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Adapt.px(15),
                        ),
                        Text(
                          model.title ?? "",
                          style: const TextStyle(
                              fontSize: TextSize.big,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cellForRow(BuildContext content, int index) {
    var model = viewModel.msgList[index];

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: Adapt.px(15),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //model.createdAt
                height: Adapt.px(25),
                width: Adapt.px(100),
                decoration: BoxDecoration(
                    color: HexColor("#E3E3E3"),
                    borderRadius: BorderRadius.circular(Adapt.px(25 / 2))),
                //model.createdAt
                child: Center(
                  child: Text(
                    model.createdAt!.substring(5, 16),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0], //[渐变起始点, 渐变结束点]
                    //渐变颜色[始点颜色, 结束颜色]
                    colors: [HexColor("#FFF3E4"), HexColor("#FFFFFF")])),
            // height: Adapt.px(100),
            margin: EdgeInsets.only(
                left: Adapt.px(15), right: Adapt.px(15), top: Adapt.px(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Adapt.screenW() - Adapt.px(60) - Adapt.px(60),
                      padding: EdgeInsets.only(
                          left: Adapt.px(15), top: Adapt.px(15)),
                      child: Text(
                        model.title ?? '',
                        style: const TextStyle(
                            fontSize: TextSize.big,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: Adapt.px(15), top: Adapt.px(15)),
                      child: Row(
                        children: [
                          const Text(
                            '查看详情',
                            style: TextStyle(color: AppColors.orangeText),
                          ),
                          SizedBox(
                            width: Adapt.px(2),
                          ),
                          loadLocalImage("home_more_arrow",
                              width: Adapt.px(9), height: Adapt.px(14)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: Adapt.px(15), right: Adapt.px(15)),
                  child: Text(
                    model.content ?? "",
                    style: const TextStyle(
                        fontSize: TextSize.big, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Adapt.px(15),
                ),
              ],
            ),
          )
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
    fetchData();
    await Future.delayed(Duration(milliseconds: 1000));
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
        title:  const Text(
          "消息",
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
          itemBuilder: _cell,
          itemCount: viewModel.msgList.length,
        ),
      ),
    );
  }
}
