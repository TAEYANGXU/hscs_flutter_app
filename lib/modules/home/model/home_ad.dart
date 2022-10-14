

class AdvertData {
  int? code;
  String? msg;
  List<AdvertListData>? data;
  int? serverTime;

  AdvertData({this.code, this.msg, this.data, this.serverTime});

  AdvertData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AdvertListData>[];
      json['data'].forEach((v) {
        data!.add(new AdvertListData.fromJson(v));
      });
    }
    serverTime = json['serverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['serverTime'] = this.serverTime;
    return data;
  }
}

class AdvertListData {
  String? title;
  String? content;
  String? imgUrl;
  String? linkUrl;
  Null? jisuLink;
  String? showType;
  Null? id;
  int? userLevel;
  List<int>? userLevelArr;
  String? createTime;

  AdvertListData(
      {this.title,
        this.content,
        this.imgUrl,
        this.linkUrl,
        this.jisuLink,
        this.showType,
        this.id,
        this.userLevel,
        this.userLevelArr,
        this.createTime});

  AdvertListData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imgUrl = json['imgUrl'];
    linkUrl = json['linkUrl'];
    jisuLink = json['jisuLink'];
    showType = json['showType'];
    id = json['id'];
    userLevel = json['userLevel'];
    userLevelArr = json['userLevelArr'].cast<int>();
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['imgUrl'] = this.imgUrl;
    data['linkUrl'] = this.linkUrl;
    data['jisuLink'] = this.jisuLink;
    data['showType'] = this.showType;
    data['id'] = this.id;
    data['userLevel'] = this.userLevel;
    data['userLevelArr'] = this.userLevelArr;
    data['createTime'] = this.createTime;
    return data;
  }
}