import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'live.dart';
import 'search.dart';
import 'search_detail.dart';

class LiveRouter extends IRouter {
  static const String live = '/live';
  static const String search = '/search';
  static const String searchDetail = '/searchDetail';

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
    router.define(searchDetail,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var feedId = int.parse(params['feedId'][0]);
          var nikeName = params['nickname'][0];;
          return LiveSearchDetailPage(
            nickname: nikeName,
            feedId: feedId,
          );
        }));
  }
}