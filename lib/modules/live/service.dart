import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/index.dart';


class LiveViewModel {

  RoomInfo? room;
  List<LiveList> liveList = [];

  ///直播室信息
  Future requestChatRoomInfo() async{
    var model = await DioManagerUtils.getT<RoomInfo>("/v3/chat-room/room-id");
    room = model.data;
    return room;
  }

  ///直播消息
  Future requestChatRoomMergeMsg(int roomId,int type) async{
    var model = await DioManagerUtils.post("/v3/chat-room/merge-msg",params: {"rid":roomId,"msgType":type});
    List list = model.data["list"];
    liveList = list.map((item) => LiveList.fromJson(item)).toList();
    print("array = ${liveList.length}");
  }
}