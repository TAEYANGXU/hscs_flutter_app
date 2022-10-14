
class HomeData {
  List<IconList>? iconList;
  TopFocus? topFocus;
  String? vipH5Url;
  AskTeacher? askTeacher;
  ChiefComment? chiefComment;
  List<AppFunctions>? appFunctions;
  bool? jumpWxApp;
  String? wxmpOriginId;
  String? unRegisterUrl;
  String? myAssetsUrl;
  bool? levelTagHide;

  HomeData(
      {this.iconList,
        this.topFocus,
        this.vipH5Url,
        this.askTeacher,
        this.chiefComment,
        this.appFunctions,
        this.jumpWxApp,
        this.wxmpOriginId,
        this.unRegisterUrl,
        this.myAssetsUrl,
        this.levelTagHide});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['iconList'] != null) {
      iconList = <IconList>[];
      json['iconList'].forEach((v) {
        iconList!.add(new IconList.fromJson(v));
      });
    }
    topFocus = json['topFocus'] != null
        ? new TopFocus.fromJson(json['topFocus'])
        : null;
    vipH5Url = json['vipH5Url'];
    askTeacher = json['askTeacher'] != null
        ? new AskTeacher.fromJson(json['askTeacher'])
        : null;
    chiefComment = json['chiefComment'] != null
        ? new ChiefComment.fromJson(json['chiefComment'])
        : null;
    if (json['appFunctions'] != null) {
      appFunctions = <AppFunctions>[];
      json['appFunctions'].forEach((v) {
        appFunctions!.add(new AppFunctions.fromJson(v));
      });
    }
    jumpWxApp = json['jumpWxApp'];
    wxmpOriginId = json['wxmpOriginId'];
    unRegisterUrl = json['unRegisterUrl'];
    myAssetsUrl = json['myAssetsUrl'];
    levelTagHide = json['levelTagHide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iconList != null) {
      data['iconList'] = this.iconList!.map((v) => v.toJson()).toList();
    }
    if (this.topFocus != null) {
      data['topFocus'] = this.topFocus!.toJson();
    }
    data['vipH5Url'] = this.vipH5Url;
    if (this.askTeacher != null) {
      data['askTeacher'] = this.askTeacher!.toJson();
    }
    if (this.chiefComment != null) {
      data['chiefComment'] = this.chiefComment!.toJson();
    }
    if (this.appFunctions != null) {
      data['appFunctions'] = this.appFunctions!.map((v) => v.toJson()).toList();
    }
    data['jumpWxApp'] = this.jumpWxApp;
    data['wxmpOriginId'] = this.wxmpOriginId;
    data['unRegisterUrl'] = this.unRegisterUrl;
    data['myAssetsUrl'] = this.myAssetsUrl;
    data['levelTagHide'] = this.levelTagHide;
    return data;
  }
}

class IconList {
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
  Null? iconCategoryId;
  Null? indexShow;
  String? noEnterDeepLink;
  int? indexSort;

  IconList(
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
        this.indexShow,
        this.noEnterDeepLink,
        this.indexSort});

  IconList.fromJson(Map<String, dynamic> json) {
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
    indexShow = json['indexShow'];
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
    data['indexShow'] = this.indexShow;
    data['noEnterDeepLink'] = this.noEnterDeepLink;
    data['indexSort'] = this.indexSort;
    return data;
  }
}

class TopFocus {
  int? interval;
  List<Infos>? infos;

  TopFocus({this.interval, this.infos});

  TopFocus.fromJson(Map<String, dynamic> json) {
    interval = json['interval'];
    if (json['infos'] != null) {
      infos = <Infos>[];
      json['infos'].forEach((v) {
        infos!.add(new Infos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interval'] = this.interval;
    if (this.infos != null) {
      data['infos'] = this.infos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Infos {
  String? deepLink;
  String? linkUrl;
  String? title;
  String? imgUrl;
  String? userLevelArr;
  String? platformArr;
  String? androidShowVersion;
  String? iosShowVersion;

  Infos(
      {this.deepLink,
        this.linkUrl,
        this.title,
        this.imgUrl,
        this.userLevelArr,
        this.platformArr,
        this.androidShowVersion,
        this.iosShowVersion});

  Infos.fromJson(Map<String, dynamic> json) {
    deepLink = json['deepLink'];
    linkUrl = json['link_url'];
    title = json['title'];
    imgUrl = json['img_url'];
    userLevelArr = json['user_level_arr'];
    platformArr = json['platform_arr'];
    androidShowVersion = json['android_show_version'];
    iosShowVersion = json['ios_show_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deepLink'] = this.deepLink;
    data['link_url'] = this.linkUrl;
    data['title'] = this.title;
    data['img_url'] = this.imgUrl;
    data['user_level_arr'] = this.userLevelArr;
    data['platform_arr'] = this.platformArr;
    data['android_show_version'] = this.androidShowVersion;
    data['ios_show_version'] = this.iosShowVersion;
    return data;
  }
}

class AskTeacher {
  List<TeacherList>? teacherList;
  QuestionDetail? questionDetail;

  AskTeacher({this.teacherList, this.questionDetail});

  AskTeacher.fromJson(Map<String, dynamic> json) {
    if (json['teacherList'] != null) {
      teacherList = <TeacherList>[];
      json['teacherList'].forEach((v) {
        teacherList!.add(new TeacherList.fromJson(v));
      });
    }
    questionDetail = json['questionDetail'] != null
        ? new QuestionDetail.fromJson(json['questionDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teacherList != null) {
      data['teacherList'] = this.teacherList!.map((v) => v.toJson()).toList();
    }
    if (this.questionDetail != null) {
      data['questionDetail'] = this.questionDetail!.toJson();
    }
    return data;
  }
}

class TeacherList {
  String? nickName;
  int? id;
  String? avatar;
  String? realName;
  bool? isChief;
  String? title;
  String? des;
  String? skill;
  String? typeDesc;
  String? style;
  String? linkUrl;
  String? audioTile;
  String? audioDes;
  String? operationCardNo;
  int? isOnline;
  String? offlineHint;
  String? posterImg;

  TeacherList(
      {this.nickName,
        this.id,
        this.avatar,
        this.realName,
        this.isChief,
        this.title,
        this.des,
        this.skill,
        this.typeDesc,
        this.style,
        this.linkUrl,
        this.audioTile,
        this.audioDes,
        this.operationCardNo,
        this.isOnline,
        this.offlineHint,
        this.posterImg});

  TeacherList.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    id = json['id'];
    avatar = json['avatar'];
    realName = json['realName'];
    isChief = json['isChief'];
    title = json['title'];
    des = json['des'];
    skill = json['skill'];
    typeDesc = json['typeDesc'];
    style = json['style'];
    linkUrl = json['linkUrl'];
    audioTile = json['audioTile'];
    audioDes = json['audioDes'];
    operationCardNo = json['operationCardNo'];
    isOnline = json['isOnline'];
    offlineHint = json['offlineHint'];
    posterImg = json['posterImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['realName'] = this.realName;
    data['isChief'] = this.isChief;
    data['title'] = this.title;
    data['des'] = this.des;
    data['skill'] = this.skill;
    data['typeDesc'] = this.typeDesc;
    data['style'] = this.style;
    data['linkUrl'] = this.linkUrl;
    data['audioTile'] = this.audioTile;
    data['audioDes'] = this.audioDes;
    data['operationCardNo'] = this.operationCardNo;
    data['isOnline'] = this.isOnline;
    data['offlineHint'] = this.offlineHint;
    data['posterImg'] = this.posterImg;
    return data;
  }
}

class QuestionDetail {
  int? interval;
  List<String>? infos;

  QuestionDetail({this.interval, this.infos});

  QuestionDetail.fromJson(Map<String, dynamic> json) {
    interval = json['interval'];
    if (json['infos'] != null) {

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interval'] = this.interval;
    if (this.infos != null) {

    }
    return data;
  }
}

class ChiefComment {
  String? nickName;
  int? id;
  String? avatar;
  String? realName;
  bool? isChief;
  String? title;
  List<String>? des;
  String? skill;
  String? typeDesc;
  String? style;
  String? linkUrl;
  String? audioTile;
  String? audioDes;
  String? operationCardNo;
  int? isOnline;
  String? offlineHint;
  String? posterImg;
  String? certificateNo;
  int? audioActId;
  int? articleType;
  Null? noEnterPic;
  String? desc;

  ChiefComment(
      {this.nickName,
        this.id,
        this.avatar,
        this.realName,
        this.isChief,
        this.title,
        this.des,
        this.skill,
        this.typeDesc,
        this.style,
        this.linkUrl,
        this.audioTile,
        this.audioDes,
        this.operationCardNo,
        this.isOnline,
        this.offlineHint,
        this.posterImg,
        this.certificateNo,
        this.audioActId,
        this.articleType,
        this.noEnterPic,
        this.desc});

  ChiefComment.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    id = json['id'];
    avatar = json['avatar'];
    realName = json['realName'];
    isChief = json['isChief'];
    title = json['title'];
    des = json['des'].cast<String>();
    skill = json['skill'];
    typeDesc = json['typeDesc'];
    style = json['style'];
    linkUrl = json['linkUrl'];
    audioTile = json['audioTile'];
    audioDes = json['audioDes'];
    operationCardNo = json['operationCardNo'];
    isOnline = json['isOnline'];
    offlineHint = json['offlineHint'];
    posterImg = json['posterImg'];
    certificateNo = json['certificateNo'];
    audioActId = json['audioActId'];
    articleType = json['articleType'];
    noEnterPic = json['noEnterPic'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['realName'] = this.realName;
    data['isChief'] = this.isChief;
    data['title'] = this.title;
    data['des'] = this.des;
    data['skill'] = this.skill;
    data['typeDesc'] = this.typeDesc;
    data['style'] = this.style;
    data['linkUrl'] = this.linkUrl;
    data['audioTile'] = this.audioTile;
    data['audioDes'] = this.audioDes;
    data['operationCardNo'] = this.operationCardNo;
    data['isOnline'] = this.isOnline;
    data['offlineHint'] = this.offlineHint;
    data['posterImg'] = this.posterImg;
    data['certificateNo'] = this.certificateNo;
    data['audioActId'] = this.audioActId;
    data['articleType'] = this.articleType;
    data['noEnterPic'] = this.noEnterPic;
    data['desc'] = this.desc;
    return data;
  }
}

class AppFunctions {
  int? id;
  String? title;
  String? intro;
  int? functionId;
  List<int>? noEnterLevelArr;
  String? noEnterDeepLink;
  String? defaultValue;
  int? status;

  AppFunctions(
      {this.id,
        this.title,
        this.intro,
        this.functionId,
        this.noEnterLevelArr,
        this.noEnterDeepLink,
        this.defaultValue,
        this.status});

  AppFunctions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    intro = json['intro'];
    functionId = json['functionId'];
    noEnterLevelArr = json['noEnterLevelArr'].cast<int>();
    noEnterDeepLink = json['noEnterDeepLink'];
    defaultValue = json['defaultValue'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['intro'] = this.intro;
    data['functionId'] = this.functionId;
    data['noEnterLevelArr'] = this.noEnterLevelArr;
    data['noEnterDeepLink'] = this.noEnterDeepLink;
    data['defaultValue'] = this.defaultValue;
    data['status'] = this.status;
    return data;
  }
}
