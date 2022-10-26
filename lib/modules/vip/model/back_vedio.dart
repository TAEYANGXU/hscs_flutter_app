
class ReviewActData {
  int? actId;
  String? actName;

  ReviewActData({this.actId, this.actName});

  ReviewActData.fromJson(Map<String, dynamic> json) {
    actId = json['actId'];
    actName = json['actName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actId'] = this.actId;
    data['actName'] = this.actName;
    return data;
  }
}

class BackReviewList {
  int? reviewId;
  int? roomId;
  int? actId;
  int? reviewNum;
  int? vhallAid;
  int? createdAt;
  String? createTime;
  String? title;
  String? content;
  String? coverPic;
  List<ActTeachers>? teachers;
  String? smallCoverPic;
  int? type;
  int? index;
  BackReviewList(
      {this.reviewId,
        this.roomId,
        this.actId,
        this.reviewNum,
        this.vhallAid,
        this.createdAt,
        this.createTime,
        this.title,
        this.content,
        this.coverPic,
        this.teachers,
        this.smallCoverPic,
        this.type,
        this.index});

  BackReviewList.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'];
    roomId = json['roomId'];
    actId = json['actId'];
    reviewNum = json['reviewNum'];
    vhallAid = json['vhallAid'];
    createdAt = json['createdAt'];
    createTime = json['createTime'];
    title = json['title'];
    content = json['content'];
    coverPic = json['coverPic'];
    if (json['teachers'] != null) {
      teachers = <ActTeachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new ActTeachers.fromJson(v));
      });
    }
    smallCoverPic = json['small_cover_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = this.reviewId;
    data['roomId'] = this.roomId;
    data['actId'] = this.actId;
    data['reviewNum'] = this.reviewNum;
    data['vhallAid'] = this.vhallAid;
    data['createdAt'] = this.createdAt;
    data['createTime'] = this.createTime;
    data['title'] = this.title;
    data['content'] = this.content;
    data['coverPic'] = this.coverPic;
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    data['small_cover_pic'] = this.smallCoverPic;
    data['type'] = this.type;
    data['index'] = this.index;
    return data;
  }
}

class ActTeachers {
  int? id;
  int? uid;
  String? nickName;
  String? avatar;
  String? realName;
  String? title;
  String? skill;
  String? typeDesc;
  String? style;
  String? des;
  String? linkUrl;
  String? posterImg;
  String? icon;
  String? audioTile;
  String? audioDes;
  bool? isChief;
  String? operationCardNo;
  int? isOnline;
  String? offlineHint;

  ActTeachers(
      {this.id,
        this.uid,
        this.nickName,
        this.avatar,
        this.realName,
        this.title,
        this.skill,
        this.typeDesc,
        this.style,
        this.des,
        this.linkUrl,
        this.posterImg,
        this.icon,
        this.audioTile,
        this.audioDes,
        this.isChief,
        this.operationCardNo,
        this.isOnline,
        this.offlineHint});

  ActTeachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    nickName = json['nickName'];
    avatar = json['avatar'];
    realName = json['realName'];
    title = json['title'];
    skill = json['skill'];
    typeDesc = json['typeDesc'];
    style = json['style'];
    des = json['des'];
    linkUrl = json['linkUrl'];
    posterImg = json['posterImg'];
    icon = json['icon'];
    audioTile = json['audioTile'];
    audioDes = json['audioDes'];
    isChief = json['isChief'];
    operationCardNo = json['operationCardNo'];
    isOnline = json['isOnline'];
    offlineHint = json['offlineHint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['nickName'] = this.nickName;
    data['avatar'] = this.avatar;
    data['realName'] = this.realName;
    data['title'] = this.title;
    data['skill'] = this.skill;
    data['typeDesc'] = this.typeDesc;
    data['style'] = this.style;
    data['des'] = this.des;
    data['linkUrl'] = this.linkUrl;
    data['posterImg'] = this.posterImg;
    data['icon'] = this.icon;
    data['audioTile'] = this.audioTile;
    data['audioDes'] = this.audioDes;
    data['isChief'] = this.isChief;
    data['operationCardNo'] = this.operationCardNo;
    data['isOnline'] = this.isOnline;
    data['offlineHint'] = this.offlineHint;
    return data;
  }
}