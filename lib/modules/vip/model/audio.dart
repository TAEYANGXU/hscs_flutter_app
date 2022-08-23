class AudioData {
  int? totalNum;
  int? currPage;
  int? pageSize;
  List<AudioList>? list;

  AudioData({this.totalNum, this.currPage, this.pageSize, this.list});

  AudioData.fromJson(Map<String, dynamic> json) {
    totalNum = json['totalNum'];
    currPage = json['currPage'];
    pageSize = json['pageSize'];
    if (json['list'] != null) {
      list = <AudioList>[];
      json['list'].forEach((v) {
        list!.add(AudioList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalNum'] = this.totalNum;
    data['currPage'] = this.currPage;
    data['pageSize'] = this.pageSize;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AudioList {
  String? zmtime;
  int? ctime;
  String? title;
  String? content;
  String? audioUrl;
  String? audioLength;
  int? id;
  String? tag;
  int? actId;
  ActInfo? actInfo;

  AudioList(
      {this.zmtime,
        this.ctime,
        this.title,
        this.content,
        this.audioUrl,
        this.audioLength,
        this.id,
        this.tag,
        this.actId,
        this.actInfo});

  AudioList.fromJson(Map<String, dynamic> json) {
    zmtime = json['zmtime'];
    ctime = json['ctime'];
    title = json['title'];
    content = json['content'];
    audioUrl = json['audioUrl'];
    audioLength = json['audioLength'];
    id = json['id'];
    tag = json['tag'];
    actId = json['actId'];
    actInfo =
    json['actInfo'] != null ? new ActInfo.fromJson(json['actInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zmtime'] = this.zmtime;
    data['ctime'] = this.ctime;
    data['title'] = this.title;
    data['content'] = this.content;
    data['audioUrl'] = this.audioUrl;
    data['audioLength'] = this.audioLength;
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['actId'] = this.actId;
    if (this.actInfo != null) {
      data['actInfo'] = this.actInfo!.toJson();
    }
    return data;
  }
}

class ActInfo {
  int? id;
  String? name;
  String? description;
  String? actFeature;
  String? surfaceimg;
  String? icon;
  String? actTime;
  int? actType;
  String? actTypeDes;
  String? actTeacher;
  int? sort;
  String? ctime;
  int? teacherId;
  String? audioTile;
  String? audioDes;
  String? h5Url;

  ActInfo(
      {this.id,
        this.name,
        this.description,
        this.actFeature,
        this.surfaceimg,
        this.icon,
        this.actTime,
        this.actType,
        this.actTypeDes,
        this.actTeacher,
        this.sort,
        this.ctime,
        this.teacherId,
        this.audioTile,
        this.audioDes,
        this.h5Url});

  ActInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    actFeature = json['actFeature'];
    surfaceimg = json['surfaceimg'];
    icon = json['icon'];
    actTime = json['actTime'];
    actType = json['actType'];
    actTypeDes = json['actTypeDes'];
    actTeacher = json['actTeacher'];
    sort = json['sort'];
    ctime = json['ctime'];
    teacherId = json['teacherId'];
    audioTile = json['audioTile'];
    audioDes = json['audioDes'];
    h5Url = json['h5Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['actFeature'] = this.actFeature;
    data['surfaceimg'] = this.surfaceimg;
    data['icon'] = this.icon;
    data['actTime'] = this.actTime;
    data['actType'] = this.actType;
    data['actTypeDes'] = this.actTypeDes;
    data['actTeacher'] = this.actTeacher;
    data['sort'] = this.sort;
    data['ctime'] = this.ctime;
    data['teacherId'] = this.teacherId;
    data['audioTile'] = this.audioTile;
    data['audioDes'] = this.audioDes;
    data['h5Url'] = this.h5Url;
    return data;
  }
}