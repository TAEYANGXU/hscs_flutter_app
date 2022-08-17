import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/api/dio_user_manager.dart';
import 'dart:convert' as Convert;
import 'package:hscs_flutter_app/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MineViewModel {

  AdvertListData?  listData;
  ///广告位
  Future getAD() async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",params: {"type":58});
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      listData = array[0];
    }
  }

  ///用户信息
  Future userInfo(BuildContext context) async {
    var model = await DioManagerUserUtils.get("/v2/user/info");
    var prefs = await SharedPreferences.getInstance();
    if(model.code == 200){
      Provider.of<UserInfo>(context, listen: false).setInfo(model.data);
      var json = Convert.jsonEncode(model.data).toString();
      ///持久化
      prefs.setString(GlobalConfig.kUserInfo, json);
    }
    if(model.code == 400002){//重新登录
      EasyLoading.showToast("登录已失效，请重新登录");
      prefs.remove(GlobalConfig.kToken);
      prefs.remove(GlobalConfig.kUserInfo);
      Provider.of<UserInfo>(context, listen: false).setInfo(null);
    }
  }


  ///解绑
  Future userCleanWechat() async {
    var model = await DioManagerUserUtils.get("/v2/user/clean-wechat");
    if(model.code == 200){
      return true;
    }
    return false;
  }
}