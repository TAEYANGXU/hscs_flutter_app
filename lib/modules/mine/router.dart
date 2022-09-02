import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/modules/mine/mine.dart';
import 'package:hscs_flutter_app/modules/mine/message_group.dart';
import 'package:hscs_flutter_app/modules/mine/message_list.dart';
import 'setting.dart';

class MineRouter extends IRouter {
  static const String mine = '/mine';
  static const String setting = '/setting';
  static const String msgGroup = '/msgGroup';
  static const String msgList = '/msgList';
  @override
  void initRouter(FluroRouter router) {
    router.define(mine, handler: Handler(handlerFunc: (_, __) => MinePage()));
    router.define(setting, handler: Handler(handlerFunc: (_, __) => MineSettingPage()));
    router.define(msgGroup, handler: Handler(handlerFunc: (_, __) => MineMSGGroupPage()));
    router.define(msgList,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var msgType = int.parse(params['msgType'][0]);
          return MineMSGListPage(
            msgType: msgType,
          );
        }));
  }
}