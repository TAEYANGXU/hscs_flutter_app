import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'live.dart';
import 'search.dart';

class LiveRouter extends IRouter {
  static const String live = '/live';
  static const String search = '/search';
  @override
  void initRouter(FluroRouter router) {
    router.define(live, handler: Handler(handlerFunc: (_, __) => LivePage()));
    router.define(search,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var roomId = int.parse(params['roomId'][0]);

          return LiveSearchPage(
            roomId: roomId,
          );
        }));
  }
}