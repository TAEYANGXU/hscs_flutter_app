import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier {

  UserModel? _info;
  UserModel? get info => _info ?? null;
  void setInfo(Map<String,dynamic> info){
    _info = UserModel.fromJson(info);
    notifyListeners();
  }
}

class UserModel{
  String? uid;
  String? avatar;
  String? nickname;
  String? mobile;
  int? role;
  String? roleText;
  bool? isVip;
  String? verifyAvatar;
  String? verifyNickname;
  String? wechatNickname;
  String? openid;
  String? vhallEmail;
  String? serviceDay;
  String? vipExpireDay;
  bool? isOldUser;
  int? score;
  String? birthday;
  Null? channel;
  String? token;
  int? unReadNum;

  UserModel(
      {this.uid,
        this.avatar,
        this.nickname,
        this.mobile,
        this.role,
        this.roleText,
        this.isVip,
        this.verifyAvatar,
        this.verifyNickname,
        this.wechatNickname,
        this.openid,
        this.vhallEmail,
        this.serviceDay,
        this.vipExpireDay,
        this.isOldUser,
        this.score,
        this.birthday,
        this.channel,
        this.token,
        this.unReadNum});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    mobile = json['mobile'];
    role = json['role'];
    roleText = json['role_text'];
    isVip = json['isVip'];
    verifyAvatar = json['verify_avatar'];
    verifyNickname = json['verify_nickname'];
    wechatNickname = json['wechat_nickname'];
    openid = json['openid'];
    vhallEmail = json['vhallEmail'];
    serviceDay = json['serviceDay'];
    vipExpireDay = json['vipExpireDay'];
    isOldUser = json['isOldUser'];
    score = json['score'];
    birthday = json['birthday'];
    channel = json['channel'];
    token = json['token'];
    unReadNum = json['unReadNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    data['role_text'] = this.roleText;
    data['isVip'] = this.isVip;
    data['verify_avatar'] = this.verifyAvatar;
    data['verify_nickname'] = this.verifyNickname;
    data['wechat_nickname'] = this.wechatNickname;
    data['openid'] = this.openid;
    data['vhallEmail'] = this.vhallEmail;
    data['serviceDay'] = this.serviceDay;
    data['vipExpireDay'] = this.vipExpireDay;
    data['isOldUser'] = this.isOldUser;
    data['score'] = this.score;
    data['birthday'] = this.birthday;
    data['channel'] = this.channel;
    data['token'] = this.token;
    data['unReadNum'] = this.unReadNum;
    return data;
  }
}