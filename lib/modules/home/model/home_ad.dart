
import 'package:json_annotation/json_annotation.dart';
part 'home_ad.g.dart';

@JsonSerializable(explicitToJson: true)
class AdvertData {
  List<AdvertListData>? data;
  int? code;
  int? message;
  AdvertData({
    this.data,
    this.code,
    this.message
  });

  factory AdvertData.fromJson(Map<String, dynamic> json) => _$AdvertDataFromJson(json);
  Map<String, dynamic> toJson() => _$AdvertDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdvertListData {
  String? title;
  String? content;
  String? imgUrl;
  String? linkUrl;
  late var jisuLink;
  String? showType;
  late var id;
  int? userLevel;
  List<int>? userLevelArr;
  String? createTime;

  AdvertListData({
    this.title,
    this.content,
    this.imgUrl,
    this.linkUrl,
    this.jisuLink,
    this.showType,
    this.id,
    this.userLevel,
    this.userLevelArr,
    this.createTime,
  });

  factory AdvertListData.fromJson(Map<String, dynamic> json) => _$AdvertListDataFromJson(json);
  Map<String, dynamic> toJson() => _$AdvertListDataToJson(this);
}

