import 'package:json_annotation/json_annotation.dart';
part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Auto {
  HomeData? data;
  int? code;
  int? message;
  Auto({
    this.data,
    this.code,
    this.message
  });

  factory Auto.fromJson(Map<String, dynamic> json) => _$AutoFromJson(json);
  Map<String, dynamic> toJson() => _$AutoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HomeData {
  ChiefcommentData? chiefComment;
  bool? levelTagHide;
  List<IconlistData>? iconList;
  TopfocusData? topFocus;
  List<AppfunctionsData>? appFunctions;
  AskteacherData? askTeacher;
  String? wxmpOriginId;
  String? myAssetsUrl;
  bool? jumpWxApp;
  String? vipH5Url;
  String? unRegisterUrl;

  HomeData({
    this.chiefComment,
    this.levelTagHide,
    this.iconList,
    this.topFocus,
    this.appFunctions,
    this.askTeacher,
    this.wxmpOriginId,
    this.myAssetsUrl,
    this.jumpWxApp,
    this.vipH5Url,
    this.unRegisterUrl,

  });

  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AskteacherData{
  List<TeacherlistData>? teacherList;
  QuestiondetailData? questionDetail;

  AskteacherData({
    this.teacherList,
    this.questionDetail,
  });

  factory AskteacherData.fromJson(Map<String, dynamic> json) => _$AskteacherDataFromJson(json);
  Map<String, dynamic> toJson() => _$AskteacherDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class QuestiondetailData{
  int? interval;
  List<dynamic>? infos;

  QuestiondetailData({
    this.interval,
    this.infos,
  });

  factory QuestiondetailData.fromJson(Map<String, dynamic> json) => _$QuestiondetailDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuestiondetailDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class TeacherlistData{
  int? isOnline;
  String? linkUrl;
  String? des;
  String? skill;
  String? avatar;
  String? typeDesc;
  String? audioTile;
  int? id;
  String? style;
  String? nickName;
  String? audioDes;
  String? posterImg;
  String? title;
  bool? isChief;
  String? offlineHint;
  String? realName;
  String? operationCardNo;

  TeacherlistData({
    this.isOnline,
    this.linkUrl,
    this.des,
    this.skill,
    this.avatar,
    this.typeDesc,
    this.audioTile,
    this.id,
    this.style,
    this.nickName,
    this.audioDes,
    this.posterImg,
    this.title,
    this.isChief,
    this.offlineHint,
    this.realName,
    this.operationCardNo,
  });

  factory TeacherlistData.fromJson(Map<String, dynamic> json) => _$TeacherlistDataFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherlistDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AppfunctionsData{
  String? intro;
  String? defaultValue;
  int? functionId;
  String? noEnterDeepLink;
  String? title;
  int? status;
  int? id;
  List<int>? noEnterLevelArr;

  AppfunctionsData({
    this.intro,
    this.defaultValue,
    this.functionId,
    this.noEnterDeepLink,
    this.title,
    this.status,
    this.id,
    this.noEnterLevelArr,
  });

  factory AppfunctionsData.fromJson(Map<String, dynamic> json) => _$AppfunctionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$AppfunctionsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class TopfocusData{
  int? interval;
  List<InfosData>? infos;

  TopfocusData({
    this.interval,
    this.infos,
  });

  factory TopfocusData.fromJson(Map<String, dynamic> json) => _$TopfocusDataFromJson(json);
  Map<String, dynamic> toJson() => _$TopfocusDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class InfosData{
  String? link_url;
  String? ios_show_version;
  String? android_show_version;
  String? user_level_arr;
  String? img_url;
  String? title;
  String? platform_arr;
  String? deepLink;

  InfosData({
    this.link_url,
    this.ios_show_version,
    this.android_show_version,
    this.user_level_arr,
    this.img_url,
    this.title,
    this.platform_arr,
    this.deepLink,
  });

  factory InfosData.fromJson(Map<String, dynamic> json) => _$InfosDataFromJson(json);
  Map<String, dynamic> toJson() => _$InfosDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class IconlistData{
  String? iosVersion;
  late var iconCategoryId;
  bool? isEnter;
  List<int>? enterLevelArr;
  String? backIconUrl;
  String? deepLink;
  String? alias;
  int? sortId;
  int? userLevel;
  int? nowUserLevel;
  String? noEnterDeepLink;
  late var indexShow;
  int? showType;
  String? hotWord;
  int? indexSort;
  String? name;
  List<String>? enterLevelDesArr;
  List<int>? userLevelArr;
  int? nowUid;
  String? androidVersion;
  String? iconurl;

  IconlistData({
    this.iosVersion,
    this.iconCategoryId,
    this.isEnter,
    this.enterLevelArr,
    this.backIconUrl,
    this.deepLink,
    this.alias,
    this.sortId,
    this.userLevel,
    this.nowUserLevel,
    this.noEnterDeepLink,
    this.indexShow,
    this.showType,
    this.hotWord,
    this.indexSort,
    this.name,
    this.enterLevelDesArr,
    this.userLevelArr,
    this.nowUid,
    this.androidVersion,
    this.iconurl,
  });

  factory IconlistData.fromJson(Map<String, dynamic> json) => _$IconlistDataFromJson(json);
  Map<String, dynamic> toJson() => _$IconlistDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class ChiefcommentData{
  int? isOnline;
  String? linkUrl;
  String? skill;
  List<String>? des;
  String? avatar;
  int? articleType;
  String? typeDesc;
  int? audioActId;
  String? audioTile;
  String? desc;
  int? id;
  String? certificateNo;
  String? style;
  String? nickName;
  String? audioDes;
  String? posterImg;
  String? title;
  late var noEnterPic;
  String? offlineHint;
  String? realName;
  String? operationCardNo;
  bool? isChief;

  ChiefcommentData({
    this.isOnline,
    this.linkUrl,
    this.skill,
    this.des,
    this.avatar,
    this.articleType,
    this.typeDesc,
    this.audioActId,
    this.audioTile,
    this.desc,
    this.id,
    this.certificateNo,
    this.style,
    this.nickName,
    this.audioDes,
    this.posterImg,
    this.title,
    this.noEnterPic,
    this.offlineHint,
    this.realName,
    this.operationCardNo,
    this.isChief,
  });

  factory ChiefcommentData.fromJson(Map<String, dynamic> json) => _$ChiefcommentDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChiefcommentDataToJson(this);

}