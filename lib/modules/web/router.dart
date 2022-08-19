import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'web.dart';

class WebViewRouter extends IRouter {
  static const String webView = '/webView';

  @override
  void initRouter(FluroRouter router) {
    router.define(webView, handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var url = params['url'][0];
      return WebViewPage(
        url: url,
      );
    }));
  }
}