import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/api/dio_user_manager.dart';
import 'package:hscs_flutter_app/api/entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hscs_flutter_app/modules/mine/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as Convert;
import 'package:provider/provider.dart';
import 'package:hscs_flutter_app/global_config.dart';


class LoginViewModel {

  BaseEntity?  verity;
  UserModel?  userModel;
  bool suc = true;
  ///获取验证码
  Future verityCode(String mobile) async {
    verity = await DioManagerUserUtils.post("/v2/user/sms",params: {"mobile":mobile});
  }

  ///验证码登录
  Future<bool> login(String mobile,String code,BuildContext context) async {
    var model = await DioManagerUserUtils.post("/v2/user/login",params: {"sms_code":code,"mobile":mobile});
    if(model.code == 200){
      userModel = UserModel.fromJson(model.data);
      var json = Convert.jsonEncode(model.data).toString();
      Provider.of<UserInfo>(context, listen: false).setInfo(model.data);
      ///持久化
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(GlobalConfig.kUserInfo, json);
      prefs.setString(GlobalConfig.kToken, userModel!.token!);

      // var res = await GlobalConfig.channel.invokeMethod("lyitp://diqiu/userInfo",{"userInfo":json,"token":userModel!.token!});
      // GlobalConfig.channel.invokeMethod("lyitp://diqiu/userInfo",json);
      return true;
    }
    return true;
  }

  ///退出登录
  Future loginOut() async {
    var model = await DioManagerUserUtils.get("/v2/user/logout");
    if(model.code == 200){
      Fluttertoast.showToast(msg: "退出登录成功");
      return true;
    }
    return false;
  }
}