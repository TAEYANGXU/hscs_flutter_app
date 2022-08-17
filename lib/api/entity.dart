
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';
import 'package:hscs_flutter_app/modules/live/model/index.dart';
/// https://czero1995.github.io/json-to-model/
class BaseEntity<T> {
  int? code;
  T? data;
  String? msg;
  BaseEntity({this.code,this.data,this.msg});

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    if(data is Map){
      return BaseEntity(
          code: json['code'] as int, msg: json['msg'] as String,data: JsonConvert._getFromJson(T, json['data']));
    }else {
      return BaseEntity(
          code: json['code'] as int, msg: json['msg'] as String,data: json['data']);
    }
  }
}

class JsonConvert<T> {
  static _getFromJson<T>(Type type, json) {
    switch (type) {
      case HomeData:
        return HomeData.fromJson(json);
        break;
      case FundData:
        return FundData.fromJson(json);
        break;
      case HeadLineData:
        return HeadLineData.fromJson(json);
        break;
      case UserModel:
        return UserModel.fromJson(json);
        break;
      case RoomInfo:
        return RoomInfo.fromJson(json);
        break;
      // case List<AdvertListData>:
      //   return AdvertData.fromJson(json);
      //   break;
      default:
        return json;
    }
  }
}