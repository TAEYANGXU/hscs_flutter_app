import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/api/dio_user_manager.dart';
import 'dart:convert' as Convert;
import 'package:hscs_flutter_app/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'model/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MineViewModel {
  AdvertListData? listData;
  List<MsgGroup> groupList = [];
  List<MsgList> msgList = [];
  List<OrderData> orderArray = [];
  List<CouponData> couponList = [];

  ///广告位
  Future getAD() async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",
        params: {"type": 58});
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if (array.isNotEmpty) {
      listData = array[0];
    }
  }

  ///用户信息
  Future userInfo(BuildContext context) async {
    var model = await DioManagerUserUtils.get("/v2/user/info");
    var prefs = await SharedPreferences.getInstance();
    if (model.code == 200) {
      // Provider.of<UserInfo>(context, listen: false).setInfo(model.data);
      // var json = Convert.jsonEncode(model.data).toString();
      ///持久化
      // prefs.setString(GlobalConfig.kUserInfo, json);
    }
    if (model.code == 400002) {
      //重新登录
      EasyLoading.showToast("登录已失效，请重新登录");
      prefs.remove(GlobalConfig.kToken);
      prefs.remove(GlobalConfig.kUserInfo);
      Provider.of<UserInfo>(context, listen: false).setInfo(null);
    }
  }

  ///解绑
  Future userCleanWechat() async {
    var model = await DioManagerUserUtils.get("/v2/user/clean-wechat");
    if (model.code == 200) {
      return true;
    }
    return false;
  }

  ///消息分组
  Future messageCenter() async {
    var model = await DioManagerUserUtils.get("/v2/message/msg-cnt");
    if (model.code == 200) {
      List list = model.data;
      groupList = list.map((e) => MsgGroup.fromJson(e)).toList();
    }
  }

  ///消息列表
  Future messageList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/message/msg-list",params: param);
    if (model.code == 200) {
      Map<String,dynamic> data = model.data;
      List list = data["list"];
      msgList = list.map((e) => MsgList.fromJson(e)).toList();
    }
  }
  /// 购买列表
  Future orderList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.get("/v2/order/my-bought",params: param);
    if (model.code == 200) {
      List list = model.data;
      orderArray = list.map((e) => OrderData.fromJson(e)).toList();
    }
  }

  ///  卡券分组
  Future getCouponList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.get("/v2/coupon/type-list",params: param);
    if (model.code == 200) {
      List list = model.data;
      couponList = list.map((e) => CouponData.fromJson(e)).toList();
    }
  }

  ///  礼品卡、优惠券列表
  Future getCouponDetailList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.get("/v2/coupon/detail-list",params: param);
    if (model.code == 200) {
      // List list = model.data;
      // couponList = list.map((e) => CouponData.fromJson(e)).toList();
    }
  }
}
