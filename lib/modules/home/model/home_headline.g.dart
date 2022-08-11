// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_headline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeadLine _$HeadLineFromJson(Map<String, dynamic> json) => HeadLine(
      data: json['data'] == null
          ? null
          : HeadLineData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HeadLineToJson(HeadLine instance) => <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

HeadLineData _$HeadLineDataFromJson(Map<String, dynamic> json) => HeadLineData(
      updatedAt: json['updatedAt'] as String?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => ListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HeadLineDataToJson(HeadLineData instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'list': instance.list?.map((e) => e.toJson()).toList(),
    };

ListData _$ListDataFromJson(Map<String, dynamic> json) => ListData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      detailLink: json['detailLink'] as String?,
      coverPic: json['coverPic'] as String?,
      shareTitle: json['shareTitle'] as String?,
      shareContent: json['shareContent'] as String?,
      createdAt: json['createdAt'] as String?,
      createTime: json['createTime'] as int?,
      canVisit: json['canVisit'] as bool?,
      isNew: json['isNew'] as bool?,
    );

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detailLink': instance.detailLink,
      'coverPic': instance.coverPic,
      'shareTitle': instance.shareTitle,
      'shareContent': instance.shareContent,
      'createdAt': instance.createdAt,
      'createTime': instance.createTime,
      'canVisit': instance.canVisit,
      'isNew': instance.isNew,
    };
