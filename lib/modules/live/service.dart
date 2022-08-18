import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/index.dart';


class LiveViewModel {

  RoomInfo? room;
  List<LiveList> liveList = [];
  List<LiveList> chatList = [];
  String? wsRoom;

  ///直播室信息
  Future requestChatRoomInfo() async{
    var model = await DioManagerUtils.getT<RoomInfo>("/v3/chat-room/room-id");
    room = model.data;
    return room;
  }

  ///直播消息
  Future requestChatRoomMergeMsg(int roomId,int type) async{
    var model = await DioManagerUtils.post("/v3/chat-room/merge-msg",params: {"rid":roomId,"msgType":type});
    wsRoom = model.data["wsRoom"];
    List list = model.data["list"];
    liveList = list.map((item) => LiveList.fromJson(item)).toList();
    print("wsRoom = ${wsRoom}");
    print("array = ${liveList.length}");
  }

  ///互动消息
  Future requestChatRoomMergeChat(int roomId,int teacherOnly) async{
    var model = await DioManagerUtils.post("/v3/chat-room/merge-msg",params: {"rid":roomId,"teacherOnly":teacherOnly});
    wsRoom = model.data["wsRoom"];
    List list = model.data["list"];
    chatList = list.map((item) => LiveList.fromJson(item)).toList();
    // print("wsRoom = ${wsRoom}");
    print("chat array = ${chatList.length}");
  }
}