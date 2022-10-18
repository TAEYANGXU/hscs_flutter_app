import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'view/index.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert' as Convert;
import 'model/index.dart';

class LivePage extends StatefulWidget {
  LivePage({Key? key}) : super(key: key);

  @override
  LivePageState createState() => LivePageState();
}

class LivePageState extends State<LivePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LiveViewModel viewModel = LiveViewModel();
  final ScrollController liveController = ScrollController();
  final ScrollController chatController = ScrollController();
  TabController? tabController;
  IO.Socket? socket;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    getChatRoomInfo();
    Future.delayed(Duration(milliseconds: 3000), () {
      receiveLiveMessage();
    });
  }

  Future receiveLiveMessage() async {
    // 和服务器端建立连接  ws://47.104.228.200:8099  wss://chat3.jinoufe.com/socket.io
    socket = IO.io('wss://chat3.jinoufe.com', <String, dynamic>{
      'transports': ['websocket'],
      'namespace': ['/socket.io/'],
      'path': '/socket.io/',
    });
    // 连接事件
    socket?.on('connect', (_) {
      print('connect..');
      socket!.emit("joinRoom", "diqiusocial:msgLive:10");
    });

    // // 断开连接
    socket?.on('disconnect', (data) {
      print('disconnect ${data.toString()}');
    });

    // 接受来自服务端的数据
    socket?.on('commonMessage', (data) {
      print("socket data = ${data}");
      Map<String, dynamic> map = Convert.jsonDecode(data);
      var socketData = SocketData.fromJson(map);
      // print("socket postData = ${socketData.postData}");
      Map<String, dynamic> post = Convert.jsonDecode(socketData.postData);
      // print("socket post = ${post}");
      var msgType = post["msgType"];
      if (msgType == 9) {
        print("消息1");
        var postData = PostData.fromJson(post);
        print("消息2");
        if (postData.data!.msgType == 1) {
          print("直播消息");
          if (mounted) {
            setState(() {
              //具体的操作
              viewModel.liveList.add(postData.data!);
            });
            if (liveController.positions.isNotEmpty) {
              liveController
                  .jumpTo(liveController.position.maxScrollExtent + 80);
            }
          }
        }
        if (postData.data!.msgType == 2) {
          print("互动消息");
          if (mounted) {
            setState(() {
              //具体的操作
              viewModel.chatList.add(postData.data!);
            });
            if (chatController.positions.isNotEmpty) {
              chatController
                  .jumpTo(chatController.position.maxScrollExtent + 80);
            }
          }
        }
      }
    });

    ///需要回执
    socket?.on('ensureMessage', (data) {
      print("ensureMessage data = $data");
      Map<String, dynamic> map = Convert.jsonDecode(data);
      var socketData = SocketData.fromJson(map);
      socket?.emit('confirmMessage',socketData.msgId);
      Map<String, dynamic> post = Convert.jsonDecode(socketData.postData);
      // print("socket post = ${post}");
      var msgType = post["msgType"];
      if (msgType == 9) {
        var postData = PostData.fromJson(post);
        if (postData.data!.msgType == 1) {
          print("直播消息");
          if (mounted) {
            setState(() {
              //具体的操作
              viewModel.liveList.add(postData.data!);
            });
            if (liveController.positions.isNotEmpty) {
              liveController
                  .jumpTo(liveController.position.maxScrollExtent + 80);
            }
            if(postData.data!.isInteract == 1){
              viewModel.chatList.add(postData.data!);
              setState(() {});
              chatController
                  .jumpTo(chatController.position.maxScrollExtent + 80);
            }
          }
        }
      }
    });
  }

  getChatRoomInfo() async {
    await viewModel.requestChatRoomInfo();
    if (viewModel.room != null) {
      getChatRoomMergeMsg(viewModel.room!.roomId!, 1);
      requestChatRoomMergeChat(viewModel.room!.roomId!);
      requestRecomendMsg(viewModel.room!.roomId!);
      requestResearchList(viewModel.room!.roomId!);
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

  requestRecomendMsg(int roomId) async {
    await viewModel.requestRecomendMsg(roomId);
    setState(() {});
  }

  requestResearchList(int roomId) async {
    await viewModel.requestResearchList(roomId,1);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // if(socket != null){ socket!.dispose(); }
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
            : const Text(""),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              //未选择样式
              unselectedLabelStyle: const TextStyle(fontSize: TextSize.larger),
              //选择样式
              labelStyle: const TextStyle(
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
              tabs: const [
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
        controller: tabController,
        //点击bar对应的内容,第一个组件对应第一个bar,第二个对应第二个,以此类推
        children: [
          viewModel.liveList.isNotEmpty
              ? LiveListPage(
                  liveList: viewModel.liveList,
                  liveController: liveController,
                  topList: viewModel.topList,
                )
              : Container(
                  color: Colors.white,
                ),
          viewModel.chatList.isNotEmpty
              ? ChatListPage(
                  chatList: viewModel.chatList,
                  chatController: chatController,
                )
              : Container(
                  color: Colors.white,
                ),
          viewModel.researchList.isNotEmpty ? ResearchPage(list: viewModel.researchList,)
          : Container(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
