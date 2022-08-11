// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertData _$AdvertDataFromJson(Map<String, dynamic> json) => AdvertData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdvertListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$AdvertDataToJson(AdvertData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'message': instance.message,
    };

AdvertListData _$AdvertListDataFromJson(Map<String, dynamic> json) =>
    AdvertListData(
      title: json['title'] as String?,
      content: json['content'] as String?,
      imgUrl: json['imgUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      jisuLink: json['jisuLink'],
      showType: json['showType'] as String?,
      id: json['id'],
      userLevel: json['userLevel'] as int?,
      userLevelArr: (json['userLevelArr'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      createTime: json['createTime'] as String?,
    );

Map<String, dynamic> _$AdvertListDataToJson(AdvertListData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'imgUrl': instance.imgUrl,
      'linkUrl': instance.linkUrl,
      'jisuLink': instance.jisuLink,
      'showType': instance.showType,
      'id': instance.id,
      'userLevel': instance.userLevel,
      'userLevelArr': instance.userLevelArr,
      'createTime': instance.createTime,
    };
