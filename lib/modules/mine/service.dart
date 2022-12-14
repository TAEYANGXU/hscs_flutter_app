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
import 'model/address.dart';
import 'model/integral.dart';

class MineViewModel {
  AdvertListData? listData;
  List<MsgGroup> groupList = [];
  List<MsgList> msgList = [];
  List<OrderData> orderArray = [];
  List<CouponData> couponList = [];
  List<AddressData> addressList = [];
  List<IntegralData> integralList = [];

  ///广告位
  Future getAD(Map<String, dynamic>? param) async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",
        params: param);
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
      Provider.of<UserInfo>(context, listen: false).setInfo(model.data);
      var json = Convert.jsonEncode(model.data).toString();
      ///持久化
      prefs.setString(GlobalConfig.kUserInfo, json);
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
      List<MsgList> mlist= list.map((e) => MsgList.fromJson(e)).toList();
      msgList.addAll(mlist);
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

  ///  设置用户生日
  Future<bool> setUserBirthday(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/user/birthday",params: param);
    if (model.code == 200) {
      return true;
    }
    return false;
  }

  ///  更新用户信息（昵称、头像）
  Future<bool> updateUser(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/user/update",params: param);
    if (model.code == 200) {
      return true;
    }
    return false;
  }
  ///  地址列表
  Future getAddressList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/address/list",params: param);
    if (model.code == 200) {
      List list = model.data;
      addressList = list.map((e) => AddressData.fromJson(e)).toList();
      print("addressList = ${addressList.length}");
    }
  }

  ///  新增、修改地址
  Future<bool> saveAddress(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/address/save",params: param);
    if (model.code == 200) {
      return true;
    }
    return false;
  }

  ///  删除地址
  Future<bool> deleteAddress(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/address/del",params: param);
    if (model.code == 200) {
      return true;
    }
    return false;
  }

  ///积分中心商品列表
  Future integralGoodsList(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/integral-goods/list",params: param);
    if (model.code == 200) {
      List list = model.data;
      integralList = list.map((e) => IntegralData.fromJson(e)).toList();
      print("integralList = ${integralList.length}");
    }
  }

  Future integralGoodsListByType(Map<String, dynamic>? param) async {
    var model = await DioManagerUserUtils.post("/v2/integral-goods/list-by-type",params: param);
    if (model.code == 200) {
      List list = model.data;
      integralList = list.map((e) => IntegralData.fromJson(e)).toList();
      print("integralList = ${integralList.length}");
    }
  }
}
