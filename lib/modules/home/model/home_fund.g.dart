// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeFund _$HomeFundFromJson(Map<String, dynamic> json) => HomeFund(
      data: json['data'] == null
          ? null
          : FundData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$HomeFundToJson(HomeFund instance) => <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

FundData _$FundDataFromJson(Map<String, dynamic> json) => FundData(
      h5Url: json['h5Url'] as String?,
      fundList: (json['fundList'] as List<dynamic>?)
          ?.map((e) => FundlistData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundDataToJson(FundData instance) => <String, dynamic>{
      'h5Url': instance.h5Url,
      'fundList': instance.fundList?.map((e) => e.toJson()).toList(),
    };

FundlistData _$FundlistDataFromJson(Map<String, dynamic> json) => FundlistData(
      url: json['url'] as String?,
      type: json['type'] as int?,
      suggestTime: json['suggestTime'] as String?,
      sort: json['sort'] as int?,
      noAccessLink: json['noAccessLink'] as String?,
      tagArr:
          (json['tagArr'] as List<dynamic>?)?.map((e) => e as String).toList(),
      canVisit: json['canVisit'] as bool?,
      enterLevelArr: json['enterLevelArr'] as String?,
      surfaceImg: json['surfaceImg'] as String?,
      status: json['status'] as int?,
      profitRate: json['profitRate'] as String?,
      intro: json['intro'] as String?,
      objectDetail: json['objectDetail'] as List<dynamic>?,
      assetRadio: (json['assetRadio'] as List<dynamic>?)
          ?.map((e) => AssetradioData.fromJson(e as Map<String, dynamic>))
          .toList(),
      tagIdArr:
          (json['tagIdArr'] as List<dynamic>?)?.map((e) => e as int).toList(),
      buttonDes: json['buttonDes'] as String?,
      profitTypeDes: json['profitTypeDes'] as String?,
      indexShow: json['indexShow'] as int?,
      createdAt: json['createdAt'] as int?,
      minimumAmount: json['minimumAmount'] as String?,
      profitType: json['profitType'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FundlistDataToJson(FundlistData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'suggestTime': instance.suggestTime,
      'sort': instance.sort,
      'noAccessLink': instance.noAccessLink,
      'tagArr': instance.tagArr,
      'canVisit': instance.canVisit,
      'enterLevelArr': instance.enterLevelArr,
      'surfaceImg': instance.surfaceImg,
      'status': instance.status,
      'profitRate': instance.profitRate,
      'intro': instance.intro,
      'objectDetail': instance.objectDetail,
      'assetRadio': instance.assetRadio?.map((e) => e.toJson()).toList(),
      'tagIdArr': instance.tagIdArr,
      'buttonDes': instance.buttonDes,
      'profitTypeDes': instance.profitTypeDes,
      'indexShow': instance.indexShow,
      'createdAt': instance.createdAt,
      'minimumAmount': instance.minimumAmount,
      'profitType': instance.profitType,
      'name': instance.name,
    };

AssetradioData _$AssetradioDataFromJson(Map<String, dynamic> json) =>
    AssetradioData(
      color: json['color'] as String?,
      assetName: json['assetName'] as String?,
      radio: json['radio'] as num?,
    )..status = json['status'] as int;

Map<String, dynamic> _$AssetradioDataToJson(AssetradioData instance) =>
    <String, dynamic>{
      'color': instance.color,
      'assetName': instance.assetName,
      'radio': instance.radio,
      'status': instance.status,
    };
