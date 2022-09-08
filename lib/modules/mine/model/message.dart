
class MsgGroup {
  int? msgType;
  String? title;
  String? icon;
  int? unReadNum;

  MsgGroup({this.msgType, this.title, this.icon, this.unReadNum});

  MsgGroup.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    title = json['title'];
    icon = json['icon'];
    unReadNum = json['unReadNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['unReadNum'] = this.unReadNum;
    return data;
  }
}


class MsgList {
  String? msgId;
  String? title;
  String? content;
  String? extJson;
  String? createdAt;
  int? msgType;
  String? type;
  String? picture;
  MsgDetail? msgDetail;

  MsgList(
      {this.msgId,
        this.title,
        this.content,
        this.extJson,
        this.createdAt,
        this.msgType,
        this.type,
        this.picture,
        this.msgDetail});

  MsgList.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    title = json['title'];
    content = json['content'];
    extJson = json['ext_json'];
    createdAt = json['createdAt'];
    msgType = json['msgType'];
    type = json['type'];
    picture = json['picture'];
    msgDetail = json['msgDetail'] != null
        ? MsgDetail.fromJson(json['msgDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgId'] = this.msgId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['ext_json'] = this.extJson;
    data['createdAt'] = this.createdAt;
    data['msgType'] = this.msgType;
    data['type'] = this.type;
    data['picture'] = this.picture;
    if (this.msgDetail != null) {
      data['msgDetail'] = this.msgDetail!.toJson();
    }
    return data;
  }
}

class MsgDetail {
  String? commentNickname;
  String? commentContent;
  String? originalComment;

  MsgDetail({this.commentNickname, this.commentContent, this.originalComment});

  MsgDetail.fromJson(Map<String, dynamic> json) {
    commentNickname = json['commentNickname'];
    commentContent = json['commentContent'];
    originalComment = json['originalComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentNickname'] = this.commentNickname;
    data['commentContent'] = this.commentContent;
    data['originalComment'] = this.originalComment;
    return data;
  }
}