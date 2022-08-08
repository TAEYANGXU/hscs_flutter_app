
/// https://czero1995.github.io/json-to-model/
class BaseEntity {
  int? code;
  Map<String,dynamic>? data;
  String? msg;
  BaseEntity({this.code,this.data,this.msg});

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    return BaseEntity(
        code: json['code'] as int, msg: json['msg'] as String,data: json['data'] as Map<String, dynamic>);
  }
}