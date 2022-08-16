import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/modules/mine/mine.dart';

class MineRouter extends IRouter {
  static const String mine = '/mine';

  @override
  void initRouter(FluroRouter router) {
    router.define(mine, handler: Handler(handlerFunc: (_, __) => MinePage()));
  }
}