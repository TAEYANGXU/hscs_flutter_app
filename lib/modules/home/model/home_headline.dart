
import 'package:json_annotation/json_annotation.dart';
part 'home_headline.g.dart';

@JsonSerializable(explicitToJson: true)
class HeadLine {
  HeadLineData? data;
  int? code;
  String? message;
  HeadLine({
    this.data,
    this.code,
    this.message
  });

  factory HeadLine.fromJson(Map<String, dynamic> json) => _$HeadLineFromJson(json);
  Map<String, dynamic> toJson() => _$HeadLineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HeadLineData {
  String? updatedAt;
  List<ListData>? list;

  HeadLineData({
    this.updatedAt,
    this.list,

  });

  factory HeadLineData.fromJson(Map<String, dynamic> json) => _$HeadLineDataFromJson(json);
  Map<String, dynamic> toJson() => _$HeadLineDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListData{
  int? id;
  String? title;
  String? detailLink;
  String? coverPic;
  String? shareTitle;
  String? shareContent;
  String? createdAt;
  int? createTime;
  bool? canVisit;
  bool? isNew;

  ListData({
    this.id,
    this.title,
    this.detailLink,
    this.coverPic,
    this.shareTitle,
    this.shareContent,
    this.createdAt,
    this.createTime,
    this.canVisit,
    this.isNew,
  });

  factory ListData.fromJson(Map<String, dynamic> json) => _$ListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ListDataToJson(this);

}

