import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';

class LivePage extends StatefulWidget {
  @override
  LivePageState createState() => new  LivePageState();
}

class LivePageState extends State<LivePage> {

  LiveViewModel viewModel = LiveViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatRoomInfo();
  }

  getChatRoomInfo() async {
    await viewModel.requestChatRoomInfo();
    if(viewModel.room != null){
      getChatRoomMergeMsg(viewModel.room!.roomId!,1);
    }
    setState(() {});
  }

  getChatRoomMergeMsg(int roomId,int type) async {
    await viewModel.requestChatRoomMergeMsg(roomId,type);
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: Adapt.px(30),),
            Container(
              color: Colors.yellow,
              width: double.infinity,
              height: Adapt.px(40),
              child: Row(

              ),
            ),
          ],
        ),
      ),
    );
  }
}