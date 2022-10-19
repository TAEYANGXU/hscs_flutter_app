
class TeacherData {
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

  TeacherData(
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

  TeacherData.fromJson(Map<String, dynamic> json) {
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