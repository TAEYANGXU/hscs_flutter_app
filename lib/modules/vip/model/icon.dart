class IconData {
  String? alias;
  String? iconurl;
  String? name;
  String? deepLink;
  String? hotWord;
  int? sortId;
  int? userLevel;
  String? iosVersion;
  String? androidVersion;
  int? showType;
  List<int>? userLevelArr;
  List<int>? enterLevelArr;
  List<String>? enterLevelDesArr;
  bool? isEnter;
  int? nowUid;
  int? nowUserLevel;
  String? backIconUrl;
  String? iconCategoryId;
  String? noEnterDeepLink;
  int? indexSort;

  IconData(
      {this.alias,
        this.iconurl,
        this.name,
        this.deepLink,
        this.hotWord,
        this.sortId,
        this.userLevel,
        this.iosVersion,
        this.androidVersion,
        this.showType,
        this.userLevelArr,
        this.enterLevelArr,
        this.enterLevelDesArr,
        this.isEnter,
        this.nowUid,
        this.nowUserLevel,
        this.backIconUrl,
        this.iconCategoryId,
        this.noEnterDeepLink,
        this.indexSort});

  IconData.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    iconurl = json['iconurl'];
    name = json['name'];
    deepLink = json['deepLink'];
    hotWord = json['hotWord'];
    sortId = json['sortId'];
    userLevel = json['userLevel'];
    iosVersion = json['iosVersion'];
    androidVersion = json['androidVersion'];
    showType = json['showType'];
    userLevelArr = json['userLevelArr'].cast<int>();
    enterLevelArr = json['enterLevelArr'].cast<int>();
    enterLevelDesArr = json['enterLevelDesArr'].cast<String>();
    isEnter = json['isEnter'];
    nowUid = json['nowUid'];
    nowUserLevel = json['nowUserLevel'];
    backIconUrl = json['backIconUrl'];
    iconCategoryId = json['iconCategoryId'];
    noEnterDeepLink = json['noEnterDeepLink'];
    indexSort = json['indexSort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alias'] = this.alias;
    data['iconurl'] = this.iconurl;
    data['name'] = this.name;
    data['deepLink'] = this.deepLink;
    data['hotWord'] = this.hotWord;
    data['sortId'] = this.sortId;
    data['userLevel'] = this.userLevel;
    data['iosVersion'] = this.iosVersion;
    data['androidVersion'] = this.androidVersion;
    data['showType'] = this.showType;
    data['userLevelArr'] = this.userLevelArr;
    data['enterLevelArr'] = this.enterLevelArr;
    data['enterLevelDesArr'] = this.enterLevelDesArr;
    data['isEnter'] = this.isEnter;
    data['nowUid'] = this.nowUid;
    data['nowUserLevel'] = this.nowUserLevel;
    data['backIconUrl'] = this.backIconUrl;
    data['iconCategoryId'] = this.iconCategoryId;
    data['noEnterDeepLink'] = this.noEnterDeepLink;
    data['indexSort'] = this.indexSort;
    return data;
  }
}