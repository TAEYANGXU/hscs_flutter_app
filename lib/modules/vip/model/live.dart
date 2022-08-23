
class LiveVideoData {
  int? actId;
  int? roomId;
  int? newlistId;
  String? actName;
  String? uid;
  int? actStatus;
  String? imStatus;
  String? foreshow;
  String? actTime;
  String? startTime;
  String? endTime;
  String? actNum;
  String? weekday;
  String? actTeacher;
  int? playbackStatus;
  int? actType;
  String? rollingCoverPic;
  String? listCoverPic;
  String? actDesPic;
  String? liveFrequency;
  String? monthDay;
  List<Teachers>? teachers;
  int? startTimeStamp;

  LiveVideoData(
      {this.actId,
        this.roomId,
        this.newlistId,
        this.actName,
        this.uid,
        this.actStatus,
        this.imStatus,
        this.foreshow,
        this.actTime,
        this.startTime,
        this.endTime,
        this.actNum,
        this.weekday,
        this.actTeacher,
        this.playbackStatus,
        this.actType,
        this.rollingCoverPic,
        this.listCoverPic,
        this.actDesPic,
        this.liveFrequency,
        this.monthDay,
        this.teachers,
        this.startTimeStamp});

  LiveVideoData.fromJson(Map<String, dynamic> json) {
    actId = json['actId'];
    roomId = json['roomId'];
    newlistId = json['newlistId'];
    actName = json['actName'];
    uid = json['uid'];
    actStatus = json['actStatus'];
    imStatus = json['imStatus'];
    foreshow = json['foreshow'];
    actTime = json['actTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    actNum = json['actNum'];
    weekday = json['weekday'];
    actTeacher = json['actTeacher'];
    playbackStatus = json['playbackStatus'];
    actType = json['actType'];
    rollingCoverPic = json['rollingCoverPic'];
    listCoverPic = json['listCoverPic'];
    actDesPic = json['actDesPic'];
    liveFrequency = json['liveFrequency'];
    monthDay = json['monthDay'];
    startTimeStamp = json['startTimeStamp'];
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actId'] = this.actId;
    data['roomId'] = this.roomId;
    data['newlistId'] = this.newlistId;
    data['actName'] = this.actName;
    data['uid'] = this.uid;
    data['actStatus'] = this.actStatus;
    data['imStatus'] = this.imStatus;
    data['foreshow'] = this.foreshow;
    data['actTime'] = this.actTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['actNum'] = this.actNum;
    data['weekday'] = this.weekday;
    data['actTeacher'] = this.actTeacher;
    data['playbackStatus'] = this.playbackStatus;
    data['actType'] = this.actType;
    data['rollingCoverPic'] = this.rollingCoverPic;
    data['listCoverPic'] = this.listCoverPic;
    data['actDesPic'] = this.actDesPic;
    data['liveFrequency'] = this.liveFrequency;
    data['monthDay'] = this.monthDay;
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teachers {
  int? id;
  int? uid;
  String? nickName;
  String? avatar;

  Teachers({this.id, this.uid, this.nickName, this.avatar});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    nickName = json['nickName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['nickName'] = this.nickName;
    data['avatar'] = this.avatar;
    return data;
  }
}