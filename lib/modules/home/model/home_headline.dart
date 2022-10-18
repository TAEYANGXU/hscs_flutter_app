

class HeadLine {
  int? code;
  String? msg;
  HeadLineData? data;
  int? serverTime;

  HeadLine({this.code, this.msg, this.data, this.serverTime});

  HeadLine.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new HeadLineData.fromJson(json['data']) : null;
    serverTime = json['serverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['serverTime'] = this.serverTime;
    return data;
  }
}

class HeadLineData {
  String? updatedAt;
  List<ListData>? list = [];

  HeadLineData({this.updatedAt, this.list});

  HeadLineData.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    if (json['list'] != null) {
      list = <ListData>[];
      json['list'].forEach((v) {
        list!.add(ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['updatedAt'] = this.updatedAt;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  int? id;
  String? title;
  String? detailLink;
  String? coverPic;
  String? shareTitle;
  String? shareContent;
  String? createdAt;
  int? createTime;
  bool? canVisit;
  bool? isNew;

  ListData(
      {this.id,
        this.title,
        this.detailLink,
        this.coverPic,
        this.shareTitle,
        this.shareContent,
        this.createdAt,
        this.createTime,
        this.canVisit,
        this.isNew});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detailLink = json['detailLink'];
    coverPic = json['coverPic'];
    shareTitle = json['shareTitle'];
    shareContent = json['shareContent'];
    createdAt = json['createdAt'];
    createTime = json['createTime'];
    canVisit = json['canVisit'];
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['detailLink'] = this.detailLink;
    data['coverPic'] = this.coverPic;
    data['shareTitle'] = this.shareTitle;
    data['shareContent'] = this.shareContent;
    data['createdAt'] = this.createdAt;
    data['createTime'] = this.createTime;
    data['canVisit'] = this.canVisit;
    data['isNew'] = this.isNew;
    return data;
  }
}