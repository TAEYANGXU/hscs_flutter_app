import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style/index.dart';
import '../../utils/index.dart';
import '../mine/model/user.dart';
import 'cell/chatlist.dart';
import 'cell/livelist.dart';
import 'service.dart';

class LiveSearchDetailPage extends StatefulWidget {
  LiveSearchDetailPage({Key? key, this.nickname, this.feedId})
      : super(key: key);
  String? nickname;
  int? feedId;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LiveSearchDetailPageState();
  }
}

class _LiveSearchDetailPageState extends State<LiveSearchDetailPage> {

  final viewModel = LiveViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    await viewModel.requestChatRoomSearchDetail({"feedId":widget.feedId});
    setState(() {

    });
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (viewModel.searchDetailList.length == index) {
      return Container(
        padding: EdgeInsets.only(
            left: Adapt.px(60), right: Adapt.px(40), bottom: Adapt.px(20)),
        child: const Text(
          "本界面内容及分析仅供您参考学习，不构成对任何金融产品的投资建议，投资有风险，入市需谨慎！",
          style: TextStyle(color: AppColors.gredText),
        ),
      );
    }
    var model = viewModel.searchDetailList[index];
    if (model.msgType == 1) {
      // print("liveMsg-summary ${model.liveMsg?.richContent}");
      // print("liveMsg-pics ${model.liveMsg?.pics!.length}");
      if (int.parse(model.liveMsg!.type!) == 0) {
        return Column(
          children: [
            SizedBox(height: Adapt.px(20),),
            LiveListCell(
              model: model,
            )
          ],
        );
      }
      return Container(//音频
        width: double.infinity,
        height: Adapt.px(0),
        // color: Colors.red,
      );
    } else {
      return Column(
        children: [
          SizedBox(height: Adapt.px(20),),
          Container(
            width: double.infinity,
            child: Consumer<UserInfo>(
              builder: (context, user, cjild) {
                if (model.chatMsg!.userInfo!.uid == int.parse(user.info!.uid!) ||
                    model.chatMsg!.userInfo!.isTeacher! == 0) {
                  return ChatListCell(
                    model: model,
                    showLeft: false,
                  );
                } else {
                  return ChatListCell(
                    model: model,
                    showLeft: true,
                  );
                }
              },
            ),
          )
        ],
      );
    }
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
            widget.nickname ?? "",
            style: const TextStyle(
                color: AppColors.text,
                fontSize: TextSize.larger,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: _cellForRow,
            itemCount: viewModel.searchDetailList.isNotEmpty ? viewModel.searchDetailList.length + 1 : 0,
            // physics: BouncingScrollPhysics(),
          ),
        )
    );
  }
}
