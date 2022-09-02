import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:date_format/date_format.dart';

class MineMSGListPage extends StatefulWidget {
  MineMSGListPage({Key? key, this.msgType}) : super(key: key);
  int? msgType;

  @override
  _MineMSGListPageState createState() => new _MineMSGListPageState();
}

class _MineMSGListPageState extends State<MineMSGListPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel
        .messageList({"page": 1, "size": 20, "msg_type": widget.msgType});
    setState(() {});
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
                child: Center(
                  child: Text(model.createdAt!.substring(5, 16) ?? ""),
                ),
                height: Adapt.px(25),
                width: Adapt.px(100),
                decoration: BoxDecoration(
                    color: HexColor("#E3E3E3"),
                    borderRadius: BorderRadius.circular(Adapt.px(25 / 2))),
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
                    offset: Offset(0, 2),
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
                SizedBox(height: Adapt.px(10),),
                Container(
                  padding: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15)),
                  child: Text(
                    model.content ?? "",
                    style: TextStyle(
                        fontSize: TextSize.big, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: Adapt.px(15),),
              ],
            ),
          )
        ],
      ),
    );
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
        title: Text(
          "消息",
          style: TextStyle(
              color: AppColors.text,
              fontSize: TextSize.larger,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: _cellForRow,
          itemCount: viewModel.msgList.length,
        ),
      ),
    );
  }
}
