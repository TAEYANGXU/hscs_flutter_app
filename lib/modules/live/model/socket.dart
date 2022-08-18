import 'live.dart';

class SocketData<T> {
  String? msgId;
  String? room;
  T? postData;
  bool? isEnsure;

  SocketData({this.msgId, this.room, this.postData, this.isEnsure});

  SocketData.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    room = json['room'];
    postData = json['postData'];
    isEnsure = json['isEnsure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgId'] = this.msgId;
    data['room'] = this.room;
    if (this.postData != null) {
      data['postData'] = postData;
    }
    data['isEnsure'] = this.isEnsure;
    return data;
  }
}

class PostData {
  int? msgType;
  PushData? data;

  PostData({this.msgType, this.data});

  PostData.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    data = json['data'] != null ? PushData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msgType'] = this.msgType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PushData {
  int? msgType;
  int? feedId;
  int? ctime;
  ChatMsg? chatMsg;
  LiveMsg? liveMsg;

  PushData({this.msgType, this.feedId, this.ctime, this.chatMsg, this.liveMsg});

  PushData.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    feedId = json['feedId'];
    ctime = json['ctime'];
    chatMsg =
    json['chatMsg'] != null ? ChatMsg.fromJson(json['chatMsg']) : null;
    liveMsg = json['liveMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['feedId'] = this.feedId;
    data['ctime'] = this.ctime;
    if (this.chatMsg != null) {
      data['chatMsg'] = this.chatMsg!.toJson();
    }
    data['liveMsg'] = this.liveMsg;
    return data;
  }
}