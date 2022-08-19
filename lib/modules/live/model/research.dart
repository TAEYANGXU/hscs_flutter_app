
class ResearchData {
  int? page;
  int? pageSize;
  int? totalCount;
  List<ResearchList>? list = [];

  ResearchData({this.page, this.pageSize, this.totalCount, this.list});

  ResearchData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    if (json['list'] != null) {
      list = <ResearchList>[];
      json['list'].forEach((v) {
        list!.add(new ResearchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['totalCount'] = this.totalCount;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResearchList {
  int? id;
  String? title;
  String? summary;
  String? createdAt;
  int? createTime;
  String? coverImage;
  String? detailLink;
  int? displayType;
  bool? isRecommend;

  ResearchList(
      {this.id,
        this.title,
        this.summary,
        this.createdAt,
        this.createTime,
        this.coverImage,
        this.detailLink,
        this.displayType,
        this.isRecommend});

  ResearchList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    createdAt = json['createdAt'];
    createTime = json['createTime'];
    coverImage = json['coverImage'];
    detailLink = json['detailLink'];
    displayType = json['displayType'];
    isRecommend = json['isRecommend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['createdAt'] = this.createdAt;
    data['createTime'] = this.createTime;
    data['coverImage'] = this.coverImage;
    data['detailLink'] = this.detailLink;
    data['displayType'] = this.displayType;
    data['isRecommend'] = this.isRecommend;
    return data;
  }
}