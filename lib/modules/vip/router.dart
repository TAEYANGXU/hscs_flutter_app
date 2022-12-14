import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'vip_article.dart';
import 'audio_line.dart';
import 'vip_back_list.dart';
import 'vip_article_list.dart';

class VipRouter extends IRouter {
  static const String vipArticle = '/vip_article';
  static const String audioLine = '/audio_line';
  static const String backList = '/back_list';
  static const String vipArticleList = '/vip_article_list';

  @override
  void initRouter(FluroRouter router) {
    router.define(backList,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var roomId = params['roomId'][0];
      var actId = params['actId'][0];
      return VipBackListPage(
        roomId: int.parse(roomId),
        actId: int.parse(actId),
      );
    }));

    router.define(vipArticle,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var articleType = params['articleType'][0];
      return VipArticlePage(
        articleType: int.parse(articleType),
      );
    }));

    router.define(audioLine,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var actId = params['actId'][0];
      return VipAudioLinePage(
        actId: int.parse(actId),
      );
    }));

    router.define(vipArticleList,
        handler: Handler(handlerFunc: (_, __) => VipArticleListPage()));
  }
}
