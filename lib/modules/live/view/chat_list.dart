import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import '../cell/livelist.dart';
import '../cell/chatlist.dart';
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key, this.chatList,this.chatController}) : super(key: key);
  List<LiveList>? chatList;
  ScrollController? chatController = ScrollController();
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if (widget.chatList!.length > 0) {
        // if(_controller.offset == _controller.position.maxScrollExtent){
        //   return;
        // }
        widget.chatController!.jumpTo(widget.chatController!.position.maxScrollExtent);
        // _controller.animateTo(_controller.position.maxScrollExtent, duration: const Duration(milliseconds: 20), curve: Curves.linear);
      }
    });
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (widget.chatList!.length == index) {
      return Container(
        padding: EdgeInsets.only(
            left: Adapt.px(60), right: Adapt.px(40), bottom: Adapt.px(20)),
        child: Text(
          "本界面内容及分析仅供您参考学习，不构成对任何金融产品的投资建议，投资有风险，入市需谨慎！",
          style: TextStyle(color: AppColors.gredText),
        ),
      );
    }
    var model = widget.chatList![index];
    if (model.msgType == 1) {
      // print("liveMsg-summary ${model.liveMsg?.richContent}");
      // print("liveMsg-pics ${model.liveMsg?.pics!.length}");
      if (int.parse(model.liveMsg!.type!) == 0) {
        return LiveListCell(
          model: model,
        );
      }
      return Container(//音频
        width: double.infinity,
        height: Adapt.px(0),
        // color: Colors.red,
      );
    } else {
      return Container(
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: _cellForRow,
        controller: widget.chatController,
        itemCount: widget.chatList != null ? widget.chatList!.length + 1 : 0,
        // physics: BouncingScrollPhysics(),
      ),
    );
  }
}
