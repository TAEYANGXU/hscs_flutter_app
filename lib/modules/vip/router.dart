import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'vip_article.dart';

class VipRouter extends IRouter {
  static const String vipArticle = '/vip_article';

  @override
  void initRouter(FluroRouter router) {
    router.define(vipArticle,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var articleType = params['articleType'][0];
      return VipArticlePage(
        articleType: int.parse(articleType),
      );
    }));
  }
}
