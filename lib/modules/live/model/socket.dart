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
  LiveList? data;

  PostData({this.msgType, this.data});

  PostData.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    data = json['data'] != null ? LiveList.fromJson(json['data']) : null;
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