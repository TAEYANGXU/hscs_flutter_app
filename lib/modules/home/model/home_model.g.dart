// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auto _$AutoFromJson(Map<String, dynamic> json) => Auto(
      data: HomeData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int,
      message: json['message'] as int,
    );

Map<String, dynamic> _$AutoToJson(Auto instance) => <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => HomeData(
      chiefComment: ChiefcommentData.fromJson(
          json['chiefComment'] as Map<String, dynamic>),
      levelTagHide: json['levelTagHide'] as bool,
      iconList: (json['iconList'] as List<dynamic>)
          .map((e) => IconlistData.fromJson(e as Map<String, dynamic>))
          .toList(),
      topFocus: TopfocusData.fromJson(json['topFocus'] as Map<String, dynamic>),
      appFunctions: (json['appFunctions'] as List<dynamic>)
          .map((e) => AppfunctionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      askTeacher:
          AskteacherData.fromJson(json['askTeacher'] as Map<String, dynamic>),
      wxmpOriginId: json['wxmpOriginId'] as String,
      myAssetsUrl: json['myAssetsUrl'] as String,
      jumpWxApp: json['jumpWxApp'] as bool,
      vipH5Url: json['vipH5Url'] as String,
      unRegisterUrl: json['unRegisterUrl'] as String,
    );

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
      'chiefComment': instance.chiefComment?.toJson(),
      'levelTagHide': instance.levelTagHide,
      'iconList': instance.iconList?.map((e) => e.toJson()).toList(),
      'topFocus': instance.topFocus?.toJson(),
      'appFunctions': instance.appFunctions?.map((e) => e.toJson()).toList(),
      'askTeacher': instance.askTeacher?.toJson(),
      'wxmpOriginId': instance.wxmpOriginId,
      'myAssetsUrl': instance.myAssetsUrl,
      'jumpWxApp': instance.jumpWxApp,
      'vipH5Url': instance.vipH5Url,
      'unRegisterUrl': instance.unRegisterUrl,
    };

AskteacherData _$AskteacherDataFromJson(Map<String, dynamic> json) =>
    AskteacherData(
      teacherList: (json['teacherList'] as List<dynamic>)
          .map((e) => TeacherlistData.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionDetail: QuestiondetailData.fromJson(
          json['questionDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AskteacherDataToJson(AskteacherData instance) =>
    <String, dynamic>{
      'teacherList': instance.teacherList?.map((e) => e.toJson()).toList(),
      'questionDetail': instance.questionDetail?.toJson(),
    };

QuestiondetailData _$QuestiondetailDataFromJson(Map<String, dynamic> json) =>
    QuestiondetailData(
      interval: json['interval'] as int,
      infos: json['infos'] as List<dynamic>,
    );

Map<String, dynamic> _$QuestiondetailDataToJson(QuestiondetailData instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'infos': instance.infos,
    };

TeacherlistData _$TeacherlistDataFromJson(Map<String, dynamic> json) =>
    TeacherlistData(
      isOnline: json['isOnline'] as int,
      linkUrl: json['linkUrl'] as String,
      des: json['des'] as String,
      skill: json['skill'] as String,
      avatar: json['avatar'] as String,
      typeDesc: json['typeDesc'] as String,
      audioTile: json['audioTile'] as String,
      id: json['id'] as int,
      style: json['style'] as String,
      nickName: json['nickName'] as String,
      audioDes: json['audioDes'] as String,
      posterImg: json['posterImg'] as String,
      title: json['title'] as String,
      isChief: json['isChief'] as bool,
      offlineHint: json['offlineHint'] as String,
      realName: json['realName'] as String,
      operationCardNo: json['operationCardNo'] as String,
    );

Map<String, dynamic> _$TeacherlistDataToJson(TeacherlistData instance) =>
    <String, dynamic>{
      'isOnline': instance.isOnline,
      'linkUrl': instance.linkUrl,
      'des': instance.des,
      'skill': instance.skill,
      'avatar': instance.avatar,
      'typeDesc': instance.typeDesc,
      'audioTile': instance.audioTile,
      'id': instance.id,
      'style': instance.style,
      'nickName': instance.nickName,
      'audioDes': instance.audioDes,
      'posterImg': instance.posterImg,
      'title': instance.title,
      'isChief': instance.isChief,
      'offlineHint': instance.offlineHint,
      'realName': instance.realName,
      'operationCardNo': instance.operationCardNo,
    };

AppfunctionsData _$AppfunctionsDataFromJson(Map<String, dynamic> json) =>
    AppfunctionsData(
      intro: json['intro'] as String,
      defaultValue: json['defaultValue'] as String,
      functionId: json['functionId'] as int,
      noEnterDeepLink: json['noEnterDeepLink'] as String,
      title: json['title'] as String,
      status: json['status'] as int,
      id: json['id'] as int,
      noEnterLevelArr: (json['noEnterLevelArr'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$AppfunctionsDataToJson(AppfunctionsData instance) =>
    <String, dynamic>{
      'intro': instance.intro,
      'defaultValue': instance.defaultValue,
      'functionId': instance.functionId,
      'noEnterDeepLink': instance.noEnterDeepLink,
      'title': instance.title,
      'status': instance.status,
      'id': instance.id,
      'noEnterLevelArr': instance.noEnterLevelArr,
    };

TopfocusData _$TopfocusDataFromJson(Map<String, dynamic> json) => TopfocusData(
      interval: json['interval'] as int,
      infos: (json['infos'] as List<dynamic>)
          .map((e) => InfosData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopfocusDataToJson(TopfocusData instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'infos': instance.infos?.map((e) => e.toJson()).toList(),
    };

InfosData _$InfosDataFromJson(Map<String, dynamic> json) => InfosData(
      link_url: json['link_url'] as String,
      ios_show_version: json['ios_show_version'] as String,
      android_show_version: json['android_show_version'] as String,
      user_level_arr: json['user_level_arr'] as String,
      img_url: json['img_url'] as String,
      title: json['title'] as String,
      platform_arr: json['platform_arr'] as String,
      deepLink: json['deepLink'] as String,
    );

Map<String, dynamic> _$InfosDataToJson(InfosData instance) => <String, dynamic>{
      'link_url': instance.link_url,
      'ios_show_version': instance.ios_show_version,
      'android_show_version': instance.android_show_version,
      'user_level_arr': instance.user_level_arr,
      'img_url': instance.img_url,
      'title': instance.title,
      'platform_arr': instance.platform_arr,
      'deepLink': instance.deepLink,
    };

IconlistData _$IconlistDataFromJson(Map<String, dynamic> json) => IconlistData(
      iosVersion: json['iosVersion'] as String,
      iconCategoryId: json['iconCategoryId'],
      isEnter: json['isEnter'] as bool,
      enterLevelArr: (json['enterLevelArr'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      backIconUrl: json['backIconUrl'] as String,
      deepLink: json['deepLink'] as String,
      alias: json['alias'] as String,
      sortId: json['sortId'] as int,
      userLevel: json['userLevel'] as int,
      nowUserLevel: json['nowUserLevel'] as int,
      noEnterDeepLink: json['noEnterDeepLink'] as String,
      indexShow: json['indexShow'],
      showType: json['showType'] as int,
      hotWord: json['hotWord'] as String,
      indexSort: json['indexSort'] as int,
      name: json['name'] as String,
      enterLevelDesArr: (json['enterLevelDesArr'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userLevelArr:
          (json['userLevelArr'] as List<dynamic>).map((e) => e as int).toList(),
      nowUid: json['nowUid'] as int,
      androidVersion: json['androidVersion'] as String,
      iconurl: json['iconurl'] as String,
    );

Map<String, dynamic> _$IconlistDataToJson(IconlistData instance) =>
    <String, dynamic>{
      'iosVersion': instance.iosVersion,
      'iconCategoryId': instance.iconCategoryId,
      'isEnter': instance.isEnter,
      'enterLevelArr': instance.enterLevelArr,
      'backIconUrl': instance.backIconUrl,
      'deepLink': instance.deepLink,
      'alias': instance.alias,
      'sortId': instance.sortId,
      'userLevel': instance.userLevel,
      'nowUserLevel': instance.nowUserLevel,
      'noEnterDeepLink': instance.noEnterDeepLink,
      'indexShow': instance.indexShow,
      'showType': instance.showType,
      'hotWord': instance.hotWord,
      'indexSort': instance.indexSort,
      'name': instance.name,
      'enterLevelDesArr': instance.enterLevelDesArr,
      'userLevelArr': instance.userLevelArr,
      'nowUid': instance.nowUid,
      'androidVersion': instance.androidVersion,
      'iconurl': instance.iconurl,
    };

ChiefcommentData _$ChiefcommentDataFromJson(Map<String, dynamic> json) =>
    ChiefcommentData(
      isOnline: json['isOnline'] as int,
      linkUrl: json['linkUrl'] as String,
      skill: json['skill'] as String,
      des: (json['des'] as List<dynamic>).map((e) => e as String).toList(),
      avatar: json['avatar'] as String,
      articleType: json['articleType'] as int,
      typeDesc: json['typeDesc'] as String,
      audioActId: json['audioActId'] as int,
      audioTile: json['audioTile'] as String,
      desc: json['desc'] as String,
      id: json['id'] as int,
      certificateNo: json['certificateNo'] as String,
      style: json['style'] as String,
      nickName: json['nickName'] as String,
      audioDes: json['audioDes'] as String,
      posterImg: json['posterImg'] as String,
      title: json['title'] as String,
      noEnterPic: json['noEnterPic'],
      offlineHint: json['offlineHint'] as String,
      realName: json['realName'] as String,
      operationCardNo: json['operationCardNo'] as String,
      isChief: json['isChief'] as bool,
    );

Map<String, dynamic> _$ChiefcommentDataToJson(ChiefcommentData instance) =>
    <String, dynamic>{
      'isOnline': instance.isOnline,
      'linkUrl': instance.linkUrl,
      'skill': instance.skill,
      'des': instance.des,
      'avatar': instance.avatar,
      'articleType': instance.articleType,
      'typeDesc': instance.typeDesc,
      'audioActId': instance.audioActId,
      'audioTile': instance.audioTile,
      'desc': instance.desc,
      'id': instance.id,
      'certificateNo': instance.certificateNo,
      'style': instance.style,
      'nickName': instance.nickName,
      'audioDes': instance.audioDes,
      'posterImg': instance.posterImg,
      'title': instance.title,
      'noEnterPic': instance.noEnterPic,
      'offlineHint': instance.offlineHint,
      'realName': instance.realName,
      'operationCardNo': instance.operationCardNo,
      'isChief': instance.isChief,
    };
