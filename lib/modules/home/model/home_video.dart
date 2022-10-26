class VideoList {
  String? vid;
  String? vTitle;
  String? vContent;
  String? createdAt;
  String? vUrl;
  int? admireNum;
  int? commentNum;
  String? videoLength;
  String? vCoverImgUrl;
  bool? isAdmire;
  int? clickNum;
  String? checkCode;
  int? actId;
  String? hotWord;
  HomeActInfo? actInfo;
  int? index;
  int? type;

  VideoList(
      {this.vid,
        this.vTitle,
        this.vContent,
        this.createdAt,
        this.vUrl,
        this.admireNum,
        this.commentNum,
        this.videoLength,
        this.vCoverImgUrl,
        this.isAdmire,
        this.clickNum,
        this.checkCode,
        this.actId,
        this.hotWord,
        this.actInfo,
        this.index,
        this.type});

  VideoList.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
    vTitle = json['vTitle'];
    vContent = json['vContent'];
    createdAt = json['createdAt'];
    vUrl = json['vUrl'];
    admireNum = json['admireNum'];
    commentNum = json['commentNum'];
    videoLength = json['videoLength'];
    vCoverImgUrl = json['vCoverImgUrl'];
    isAdmire = json['isAdmire'];
    clickNum = json['clickNum'];
    checkCode = json['checkCode'];
    actId = json['actId'];
    hotWord = json['hotWord'];
    actInfo =
    json['actInfo'] != null ? new HomeActInfo.fromJson(json['actInfo']) : null;
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    data['vTitle'] = this.vTitle;
    data['vContent'] = this.vContent;
    data['createdAt'] = this.createdAt;
    data['vUrl'] = this.vUrl;
    data['admireNum'] = this.admireNum;
    data['commentNum'] = this.commentNum;
    data['videoLength'] = this.videoLength;
    data['vCoverImgUrl'] = this.vCoverImgUrl;
    data['isAdmire'] = this.isAdmire;
    data['clickNum'] = this.clickNum;
    data['checkCode'] = this.checkCode;
    data['actId'] = this.actId;
    data['hotWord'] = this.hotWord;
    if (this.actInfo != null) {
      data['actInfo'] = this.actInfo!.toJson();
    }
    data['index'] = this.index;
    data['type'] = this.type;
    return data;
  }
}

class HomeActInfo {
  int? id;
  String? name;
  String? pgmtime;
  String? des;
  String? surfaceImg;
  String? icon;
  String? actType;
  String? actTypeDes;
  List<String>? teacher;
  List<String>? teaherUids;

  HomeActInfo(
      {this.id,
        this.name,
        this.pgmtime,
        this.des,
        this.surfaceImg,
        this.icon,
        this.actType,
        this.actTypeDes,
        this.teacher,
        this.teaherUids});

  HomeActInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pgmtime = json['pgmtime'];
    des = json['des'];
    surfaceImg = json['surfaceImg'];
    icon = json['icon'];
    actType = json['actType'];
    actTypeDes = json['actTypeDes'];
    teacher = json['teacher'].cast<String>();
    teaherUids = json['teaherUids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pgmtime'] = this.pgmtime;
    data['des'] = this.des;
    data['surfaceImg'] = this.surfaceImg;
    data['icon'] = this.icon;
    data['actType'] = this.actType;
    data['actTypeDes'] = this.actTypeDes;
    data['teacher'] = this.teacher;
    data['teaherUids'] = this.teaherUids;
    return data;
  }
}