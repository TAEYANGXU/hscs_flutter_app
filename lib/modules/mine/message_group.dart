import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';
import 'package:hscs_flutter_app/modules/mine/router.dart';

class MineMSGGroupPage extends StatefulWidget {
  MineMSGGroupPage({Key? key}) : super(key: key);

  @override
  _MineMSGGroupPageState createState() => new _MineMSGGroupPageState();
}

class _MineMSGGroupPageState extends State<MineMSGGroupPage> {
  final viewModel = MineViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.messageCenter();
    setState(() {});
  }

  Widget _cellForRow(BuildContext content, int index) {
    var model = viewModel.groupList[index];
    return GestureDetector(
      onTap: () {
        if (index == 1 || index == 2) {
          Routers.push(context, MineRouter.msgList,
              params: {"msgType": '${model.msgType}'});
        }
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: Adapt.px(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: Adapt.px(10)),
              child: Row(
                children: [
                  Container(
                    child: CacheImage(
                      imageUrl: model.icon ?? "",
                      width: Adapt.px(40),
                      height: Adapt.px(40),
                    ),
                  ),
                  SizedBox(
                    width: Adapt.px(10),
                  ),
                  Text(
                    model.title ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: TextSize.s17,
                        color: AppColors.text),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: Adapt.px(20)),
              child: loadLocalImage("mine/mine_arrown_right",
                  width: Adapt.px(9), height: Adapt.px(16)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: loadLocalImage("page_back",
              width: Adapt.px(11), height: Adapt.px(18)),
        ),
        title: Text(
          "我的消息",
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
          itemCount: viewModel.groupList.length,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
