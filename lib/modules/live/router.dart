import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'live.dart';

class LiveRouter extends IRouter {
  static const String live = '/live';

  @override
  void initRouter(FluroRouter router) {
    router.define(live, handler: Handler(handlerFunc: (_, __) => LivePage()));
  }
}