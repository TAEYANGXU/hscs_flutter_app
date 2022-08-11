import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home_fund.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeFund {
  FundData? data;
  int? code;
  int? message;
  HomeFund({
    this.data,
    this.code,
    this.message
  });

  factory HomeFund.fromJson(Map<String, dynamic> json) => _$HomeFundFromJson(json);
  Map<String, dynamic> toJson() => _$HomeFundToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FundData {
  String? h5Url;
  List<FundlistData>? fundList;

  FundData({
    this.h5Url,
    this.fundList,

  });

  factory FundData.fromJson(Map<String, dynamic> json) => _$FundDataFromJson(json);
  Map<String, dynamic> toJson() => _$FundDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FundlistData{
  String? url;
  int? type;
  String? suggestTime;
  int? sort;
  String? noAccessLink;
  List<String>? tagArr;
  bool? canVisit;
  String? enterLevelArr;
  String? surfaceImg;
  int? status;
  String? profitRate;
  String? intro;
  List<dynamic>? objectDetail;
  List<AssetradioData>? assetRadio;
  List<int>? tagIdArr;
  String? buttonDes;
  String? profitTypeDes;
  int? indexShow;
  int? createdAt;
  String? minimumAmount;
  int? profitType;
  String? name;

  FundlistData({
    this.url,
    this.type,
    this.suggestTime,
    this.sort,
    this.noAccessLink,
    this.tagArr,
    this.canVisit,
    this.enterLevelArr,
    this.surfaceImg,
    this.status,
    this.profitRate,
    this.intro,
    this.objectDetail,
    this.assetRadio,
    this.tagIdArr,
    this.buttonDes,
    this.profitTypeDes,
    this.indexShow,
    this.createdAt,
    this.minimumAmount,
    this.profitType,
    this.name,
  });

  factory FundlistData.fromJson(Map<String, dynamic> json) => _$FundlistDataFromJson(json);
  Map<String, dynamic> toJson() => _$FundlistDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AssetradioData{
  String? color;
  String? assetName;
  num? radio;
  int status = 0;
  // Color hexColor = Colors.white;

  AssetradioData({
    this.color,
    this.assetName,
    this.radio,
  });

  factory AssetradioData.fromJson(Map<String, dynamic> json) => _$AssetradioDataFromJson(json);
  Map<String, dynamic> toJson() => _$AssetradioDataToJson(this);

}

