import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'view/index.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert' as Convert;
import 'model/index.dart';

class LivePage extends StatefulWidget {
  @override
  LivePageState createState() => LivePageState();
}

class LivePageState extends State<LivePage>
    with SingleTickerProviderStateMixin {
  LiveViewModel viewModel = LiveViewModel();
  TabController? tabController;
  IO.Socket? socket;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    getChatRoomInfo();
    receiveLiveMessage();
  }

  void receiveLiveMessage() {
    // 和服务器端建立连接  ws://47.104.228.200:8099  wss://chat3.jinoufe.com/socket.io
    this.socket = IO.io('wss://chat3.jinoufe.com', <String, dynamic>{
      'transports': ['websocket'],
      'namespace': ['/socket.io/'],
      'path': '/socket.io/',
    });
    // 连接事件
    this.socket?.on('connect', (_) {
      print('connect..');
      socket!.emit("joinRoom","diqiusocial:msgLive:10");
    });

    // // 断开连接
    this.socket?.on('disconnect', (data) {
      print('disconnect ${data.toString()}');
    });

    // 接受来自服务端的数据
    this.socket?.on('commonMessage', (data) {
      print("socket data = ${data}");
      Map<String, dynamic> map = Convert.jsonDecode(data);
      var socketData = SocketData.fromJson(map);

      print("socketData.postData = ${socketData.postData}");

      Map<String, dynamic> post = Convert.jsonDecode(socketData.postData);
      var postData = PostData.fromJson(post);
      if(postData.msgType == 9){
        if(postData.data!.msgType == 1){
          print("直播消息");
        }
        if(postData.data!.msgType == 2){
          print("互动消息");
        }
      }
      print("postData.data = ${postData.data!.ctime}");
      setState(() {
        // this.messageList.add(data);
      });
      // 改变滚动条的位置
      // this._scrollController.jumpTo(_scrollController.position.maxScrollExtent+80);
    });

    ///需要回执
    this.socket?.on('ensureMessage', (data) {
      print("socket data = ${data}");
      setState(() {
        // this.messageList.add(data);
      });
      // 改变滚动条的位置
      // this._scrollController.jumpTo(_scrollController.position.maxScrollExtent+80);
    });
  }

  //diqiusocial:msgLive:10

  getChatRoomInfo() async {
    await viewModel.requestChatRoomInfo();
    if (viewModel.room != null) {
      getChatRoomMergeMsg(viewModel.room!.roomId!, 1);
      requestChatRoomMergeChat(viewModel.room!.roomId!);
    }
    setState(() {});
  }

  getChatRoomMergeMsg(int roomId, int type) async {
    await viewModel.requestChatRoomMergeMsg(roomId, type);
    setState(() {});
  }

  requestChatRoomMergeChat(int roomId) async {
    await viewModel.requestChatRoomMergeChat(roomId, 0);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: viewModel.room != null
            ? LiveTopView(
                room: viewModel.room,
              )
            : Text(""),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              //未选择样式
              unselectedLabelStyle: TextStyle(fontSize: TextSize.larger),
              //选择样式
              labelStyle: TextStyle(
                  fontSize: TextSize.s22, fontWeight: FontWeight.w600),
              //选中的颜色
              labelColor: AppColors.theme,
              //未选中的颜色
              unselectedLabelColor: AppColors.text,
              //自定义指示器
              indicatorColor: AppColors.theme,
              // 指示器的大小
              indicatorSize: TabBarIndicatorSize.label,
              // 指示器的权重，即线条高度
              indicatorWeight: 2.0,
              indicatorPadding: EdgeInsets.only(bottom: Adapt.px(10)),
              tabs: [
                Tab(text: "直播"),
                Tab(text: "互动"),
                Tab(text: "研究"),
              ],
              controller: tabController,
            ),
          ),
        ),
      ),
      body: TabBarView(
        //点击bar对应的内容,第一个组件对应第一个bar,第二个对应第二个,以此类推
        children: [
          viewModel.liveList.length > 0
              ? LiveListPage(
                  liveList: viewModel.liveList,
                )
              : Container(
                  color: Colors.white,
                ),
          Container(),
          Container(),
        ],
        controller: tabController,
      ),
    );
  }
}
