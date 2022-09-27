import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'mine.dart';
import 'message_group.dart';
import 'message_list.dart';
import 'order.dart';
import 'order_detail.dart';
import 'setting.dart';
import 'coupon.dart';
import 'card.dart';
import 'discount.dart';
import 'user_info.dart';
import 'page/birthday.dart';
import 'nickname.dart';
import 'address_list.dart';
import 'address_add.dart';
import 'feedback.dart';
import 'aboutus.dart';
import 'integral_center.dart';

class MineRouter extends IRouter {
  static const String mine = '/mine';
  static const String setting = '/setting';
  static const String msgGroup = '/msgGroup';
  static const String msgList = '/msgList';
  static const String order = '/order';
  static const String orderDetail = '/orderDetail';
  static const String coupon = '/coupon';
  static const String card = '/card';
  static const String discount = '/discount';
  static const String userInfo = '/userInfo';
  static const String birthday = '/birthday';
  static const String nickname = '/nickname';
  static const String addressList = '/address_list';
  static const String addressAdd = '/address_add';
  static const String addressUpdate = '/address_update';
  static const String aboutUs = '/aboutUs';
  static const String feedback = '/feedback';
  static const String integral = '/integral';

  @override
  void initRouter(FluroRouter router) {
    router.define(mine, handler: Handler(handlerFunc: (_, __) => MinePage()));
    router.define(setting,
        handler: Handler(handlerFunc: (_, __) => MineSettingPage()));
    router.define(msgGroup,
        handler: Handler(handlerFunc: (_, __) => MineMSGGroupPage()));
    router.define(order,
        handler: Handler(handlerFunc: (_, __) => MineOrderPage()));
    router.define(userInfo,
        handler: Handler(handlerFunc: (_, __) => UserInfoPage()));
    router.define(birthday,
        handler: Handler(handlerFunc: (_, __) => UserBirthdayPage()));
    router.define(nickname,
        handler: Handler(handlerFunc: (_, __) => UserNikenamePage()));
    router.define(addressList,
        handler: Handler(handlerFunc: (_, __) => MineAddressPage()));
    router.define(addressAdd,
        handler: Handler(handlerFunc: (_, __) => MineAddressAddPage()));
    router.define(aboutUs,
        handler: Handler(handlerFunc: (_, __) => MineAboutUsPage()));
    router.define(feedback,
        handler: Handler(handlerFunc: (_, __) => MineFeedbackPage()));
    router.define(integral,
        handler: Handler(handlerFunc: (_, __) => MineIntegralPage()));
    router.define(addressUpdate,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var address = params['address'][0];
          return MineAddressAddPage(
            address: address,
          );
        }));
    router.define(card,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var type = params['type'][0];
      return MineCardPage(
        type: int.parse(type),
      );
    }));
    router.define(discount,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var type = params['type'][0];
      return MineDiscountPage(
        type: int.parse(type),
      );
    }));
    router.define(orderDetail,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var order = params['order'][0];
      return MineOrderDetailPage(
        order: order,
      );
    }));
    router.define(coupon,
        handler: Handler(handlerFunc: (_, __) => MineCouponPage()));
    router.define(msgList,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var msgType = int.parse(params['msgType'][0]);
      return MineMSGListPage(
        msgType: msgType,
      );
    }));
  }
}
