
class LiveData {
  List<LiveList>? list;
  String? roomId;
  String? roomName;
  String? wsRoom;
  String? checkCode;

  LiveData({this.list, this.roomId, this.roomName, this.wsRoom, this.checkCode});

  LiveData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <LiveList>[];
      json['list'].forEach((v) {
        list!.add(LiveList.fromJson(v));
      });
    }
    roomId = json['roomId'];
    roomName = json['roomName'];
    wsRoom = json['wsRoom'];
    checkCode = json['checkCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['roomId'] = this.roomId;
    data['roomName'] = this.roomName;
    data['wsRoom'] = this.wsRoom;
    data['checkCode'] = this.checkCode;
    return data;
  }
}

class LiveList {
  int? msgType;
  int? feedId;
  int? ctime;
  ChatMsg? chatMsg;
  int? isMass;
  LiveMsg? liveMsg;
  int? isInteract;

  LiveList(
      {this.msgType,
        this.feedId,
        this.ctime,
        this.chatMsg,
        this.isMass,
        this.liveMsg,
        this.isInteract,});

  LiveList.fromJson(Map<String, dynamic> json) {
    msgType = json['msgType'];
    feedId = json['feedId'];
    ctime = json['ctime'];
    chatMsg =
    json['chatMsg'] != null ? ChatMsg.fromJson(json['chatMsg']) : null;
    isMass = json['isMass'];
    liveMsg =
    json['liveMsg'] != null ? LiveMsg.fromJson(json['liveMsg']) : null;
    isInteract =  json['isInteract'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msgType'] = this.msgType;
    data['feedId'] = this.feedId;
    data['ctime'] = this.ctime;
    if (this.chatMsg != null) {
      data['chatMsg'] = this.chatMsg!.toJson();
    }
    data['isMass'] = this.isMass;
    if (this.liveMsg != null) {
      data['liveMsg'] = this.liveMsg!.toJson();
    }
    return data;
  }
}

class ChatMsg {
  int? chatId;
  String? content;
  int? replyId;
  int? roomId;
  int? onlyUid;
  int? status;
  String? zmtime;
  ChatUserInfo? userInfo;
  int? ctime;
  List? pics;
  ReplyUserInfo? replyUserInfo;

  ChatMsg(
      {this.chatId,
        this.content,
        this.replyId,
        this.roomId,
        this.onlyUid,
        this.status,
        this.zmtime,
        this.userInfo,
        this.ctime,
        this.pics,
        this.replyUserInfo});

  ChatMsg.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    content = json['content'];
    replyId = json['replyId'];
    roomId = json['roomId'];
    onlyUid = json['onlyUid'];
    status = json['status'];
    zmtime = json['zmtime'];
    userInfo = json['userInfo'] != null
        ? ChatUserInfo.fromJson(json['userInfo'])
        : null;
    ctime = json['ctime'];
    if (json['pics'] != null) {
      pics = json['pics'].cast<String>();
    }
    replyUserInfo = json['replyUserInfo'] != null
        ? new ReplyUserInfo.fromJson(json['replyUserInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['content'] = this.content;
    data['replyId'] = this.replyId;
    data['roomId'] = this.roomId;
    data['onlyUid'] = this.onlyUid;
    data['status'] = this.status;
    data['zmtime'] = this.zmtime;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    data['ctime'] = this.ctime;
    if (this.pics != null) {
      data['pics'] = this.pics;
    }
    if (this.replyUserInfo != null) {
      data['replyUserInfo'] = this.replyUserInfo!.toJson();
    }
    return data;
  }
}

class ChatUserInfo {
  int? uid;
  String? nickname;
  String? avatar;
  int? userLevel;
  String? userLevelDes;
  bool? isVip;
  int? role;
  String? roleDes;
  int? isTeacher;
  String? title;
  String? realName;
  int? teacherId;
  bool? isChief;
  int? teacherType;

  ChatUserInfo(
      {this.uid,
        this.nickname,
        this.avatar,
        this.userLevel,
        this.userLevelDes,
        this.isVip,
        this.role,
        this.roleDes,
        this.isTeacher,
        this.title,
        this.realName,
        this.teacherId,
        this.isChief,
        this.teacherType});

  ChatUserInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    userLevel = json['userLevel'];
    userLevelDes = json['userLevelDes'];
    isVip = json['isVip'];
    role = json['role'];
    roleDes = json['roleDes'];
    isTeacher = json['isTeacher'];
    title = json['title'];
    realName = json['realName'];
    teacherId = json['teacherId'];
    isChief = json['isChief'];
    teacherType = json['teacherType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['userLevel'] = this.userLevel;
    data['userLevelDes'] = this.userLevelDes;
    data['isVip'] = this.isVip;
    data['role'] = this.role;
    data['roleDes'] = this.roleDes;
    data['isTeacher'] = this.isTeacher;
    data['title'] = this.title;
    data['realName'] = this.realName;
    data['teacherId'] = this.teacherId;
    data['isChief'] = this.isChief;
    data['teacherType'] = this.teacherType;
    return data;
  }
}

class ReplyUserInfo {
  int? uid;
  String? nickname;
  String? avatar;
  int? userLevel;
  String? userLevelDes;
  bool? isVip;
  int? role;
  String? roleDes;
  int? isTeacher;
  String? title;
  String? realName;
  int? teacherId;
  bool? isChief;
  int? teacherType;
  String? replyComment;

  ReplyUserInfo(
      {
        this.uid,
        this.nickname,
        this.avatar,
        this.userLevel,
        this.userLevelDes,
        this.isVip,
        this.role,
        this.roleDes,
        this.isTeacher,
        this.title,
        this.realName,
        this.teacherId,
        this.isChief,
        this.teacherType,
        this.replyComment});

  ReplyUserInfo.fromJson(Map<String, dynamic> json) {
    // uid = json['uid'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    userLevel = json['userLevel'];
    userLevelDes = json['userLevelDes'];
    isVip = json['isVip'];
    role = json['role'];
    roleDes = json['roleDes'];
    isTeacher = json['isTeacher'];
    title = json['title'];
    realName = json['realName'];
    teacherId = json['teacherId'];
    // isChief = json['isChief'];
    teacherType = json['teacherType'];
    replyComment = json['replyComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['userLevel'] = this.userLevel;
    data['userLevelDes'] = this.userLevelDes;
    data['isVip'] = this.isVip;
    data['role'] = this.role;
    data['roleDes'] = this.roleDes;
    data['isTeacher'] = this.isTeacher;
    data['title'] = this.title;
    data['realName'] = this.realName;
    data['teacherId'] = this.teacherId;
    data['isChief'] = this.isChief;
    data['teacherType'] = this.teacherType;
    data['replyComment'] = this.replyComment;
    return data;
  }
}

class LiveMsg {
  String? ctime;
  String? zmtime;
  String? msgId;
  String? type;
  int? onlyVip;
  String? summary;
  List? pics;
  int? isRecomend;
  String? viewUserLevels;
  String? richContent;
  List? userLevelArr;
  List? userLevelDesArr;
  bool? isEnter;
  Teacher? teacher;

  LiveMsg(
      {this.ctime,
        this.zmtime,
        this.msgId,
        this.type,
        this.onlyVip,
        this.summary,
        this.pics,
        this.isRecomend,
        this.viewUserLevels,
        this.richContent,
        this.userLevelArr,
        this.userLevelDesArr,
        this.isEnter,
        this.teacher});

  LiveMsg.fromJson(Map<String, dynamic> json) {
    ctime = '${json['ctime']}';
    zmtime = json['zmtime'];
    msgId = '${json['msgId']}';
    type = '${json['type']}';
    onlyVip = json['onlyVip'];
    summary = json['summary'];
    if (json['pics'] != null) {
      pics = json['pics'];
    }
    isRecomend = json['isRecomend'];
    viewUserLevels = json['view_user_levels'];
    richContent = json['richContent'];
    userLevelArr = json['userLevelArr'].cast<int>();
    userLevelDesArr = json['userLevelDesArr'].cast<String>();
    isEnter = json['isEnter'];
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctime'] = this.ctime;
    data['zmtime'] = this.zmtime;
    data['msgId'] = this.msgId;
    data['type'] = this.type;
    data['onlyVip'] = this.onlyVip;
    data['summary'] = this.summary;
    if (this.pics != null) {
      data['pics'] = this.pics;
    }
    data['isRecomend'] = this.isRecomend;
    data['view_user_levels'] = this.viewUserLevels;
    data['richContent'] = this.richContent;
    data['userLevelArr'] = this.userLevelArr;
    data['userLevelDesArr'] = this.userLevelDesArr;
    data['isEnter'] = this.isEnter;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  String? nickname;
  String? avatar;
  int? isTeacher;
  String? realName;
  String? title;
  String? uid;
  String? teacherId;
  bool? isChief;

  Teacher(
      {this.nickname,
        this.avatar,
        this.isTeacher,
        this.realName,
        this.title,
        this.uid,
        this.teacherId,
        this.isChief});

  Teacher.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    avatar = json['avatar'];
    isTeacher = json['isTeacher'];
    realName = json['realName'];
    title = json['title'];
    uid = json['uid'];
    teacherId = json['teacherId'];
    isChief = json['isChief'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['isTeacher'] = this.isTeacher;
    data['realName'] = this.realName;
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['teacherId'] = this.teacherId;
    data['isChief'] = this.isChief;
    return data;
  }
}