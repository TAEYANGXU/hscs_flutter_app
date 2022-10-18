import 'package:fluro/fluro.dart';
import 'home.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'video_list.dart';
import 'article_list.dart';

class HomeRouter extends IRouter
{
  static const String root = '/home';
  static const String videoList = '/video_list';
  static const String articleList = '/article_list';
  @override
  void initRouter(FluroRouter router){
    router.define(root, handler: Handler(handlerFunc: (_,__) => HomePage()));
    router.define(articleList, handler: Handler(handlerFunc: (_,__) => ArticleListPage()));
    router.define(videoList,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var type = params['type'][0];
          return VideoListPage(type: type);
        })
    );
  }
}