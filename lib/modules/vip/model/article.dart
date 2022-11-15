class VipArticleData {
  int? page;
  int? pageSize;
  int? count;
  bool? canVisit;
  String? coverPic;
  String? description;
  String? title;
  String? shareUrl;
  String? shareImage;
  bool? showVipTag;
  List<VipArticleList>? list;

  VipArticleData(
      {this.page,
        this.pageSize,
        this.count,
        this.canVisit,
        this.coverPic,
        this.description,
        this.title,
        this.shareUrl,
        this.shareImage,
        this.showVipTag,
        this.list});

  VipArticleData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    count = json['count'];
    canVisit = json['canVisit'];
    coverPic = json['coverPic'];
    description = json['description'];
    title = json['title'];
    shareUrl = json['shareUrl'];
    shareImage = json['shareImage'];
    showVipTag = json['showVipTag'];
    if (json['list'] != null) {
      list = <VipArticleList>[];
      json['list'].forEach((v) {
        list!.add(new VipArticleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    data['canVisit'] = this.canVisit;
    data['coverPic'] = this.coverPic;
    data['description'] = this.description;
    data['title'] = this.title;
    data['shareUrl'] = this.shareUrl;
    data['shareImage'] = this.shareImage;
    data['showVipTag'] = this.showVipTag;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VipArticleList {
  int? id;
  String? title;
  String? summary;
  String? pdf;
  int? viewNum;
  String? cTime;
  bool? isRecommend;
  String? coverPic;
  String? linkUrl;
  String? author;
  bool? canExperience;
  String? h5Url;
  // List<int>? userLevelArr;
  // List<String>? enterLevelDesArr;
  bool? canVisit;
  String? noAccessHint;
  bool? isNew;

  VipArticleList(
      {this.id,
        this.title,
        this.summary,
        this.pdf,
        this.viewNum,
        this.cTime,
        this.isRecommend,
        this.coverPic,
        this.linkUrl,
        this.author,
        this.canExperience,
        this.h5Url,
        // this.userLevelArr,
        // this.enterLevelDesArr,
        this.canVisit,
        this.noAccessHint,
        this.isNew});

  VipArticleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    pdf = json['pdf'];
    viewNum = json['viewNum'];
    cTime = json['cTime'];
    isRecommend = json['isRecommend'];
    coverPic = json['coverPic'];
    linkUrl = json['linkUrl'];
    author = json['author'];
    canExperience = json['canExperience'];
    h5Url = json['h5Url'];
    // userLevelArr = json['userLevelArr'];
    // enterLevelDesArr = json['enterLevelDesArr'];
    canVisit = json['canVisit'];
    noAccessHint = json['noAccessHint'];
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['pdf'] = this.pdf;
    data['viewNum'] = this.viewNum;
    data['cTime'] = this.cTime;
    data['isRecommend'] = this.isRecommend;
    data['coverPic'] = this.coverPic;
    data['linkUrl'] = this.linkUrl;
    data['author'] = this.author;
    data['canExperience'] = this.canExperience;
    data['h5Url'] = this.h5Url;
    // data['userLevelArr'] = this.userLevelArr;
    // data['enterLevelDesArr'] = this.enterLevelDesArr;
    data['canVisit'] = this.canVisit;
    data['noAccessHint'] = this.noAccessHint;
    data['isNew'] = this.isNew;
    return data;
  }
}