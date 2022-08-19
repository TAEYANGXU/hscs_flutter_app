import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/index.dart';


class LiveViewModel {

  RoomInfo? room;
  List<LiveList> liveList = [];
  List<LiveList> chatList = [];
  List<LiveMsg> topList = [];
  List<ResearchList> researchList = [];

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

  ///直播室置顶消息
  Future requestRecomendMsg(int roomId) async{
    var model = await DioManagerUtils.get("/v3/chat-room/recomend-msg",params: {"rid":roomId});
    List list = model.data["list"];
    topList = list.map((item) => LiveMsg.fromJson(item)).toList();
    // print("code = ${model.code}");
    // print("topList = ${topList.length}");
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

  ///研究列表
  Future requestResearchList(int roomId,int page) async{
    var model = await DioManagerUtils.getT<ResearchData>("/v3/chat-room/research-list",params: {"roomId":roomId,"page":page,"pageSize":20});
    if(model.data?.list != null) {
      researchList = model.data!.list!;
    }
    print("ResearchData array = ${model.data!.list!.length}");
  }
}