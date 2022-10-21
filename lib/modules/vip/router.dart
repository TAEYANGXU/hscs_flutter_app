import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'vip_article.dart';
import 'audio_line.dart';

class VipRouter extends IRouter {
  static const String vipArticle = '/vip_article';
  static const String audioLine = '/audio_line';

  @override
  void initRouter(FluroRouter router) {

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
  }
}
