import 'package:fluro/fluro.dart';
import 'home.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'video_list.dart';
import 'article_list.dart';
import 'master_detail.dart';

class HomeRouter extends IRouter
{
  static const String root = '/home';
  static const String videoList = '/video_list';
  static const String articleList = '/article_list';
  static const String masterDetail = '/master_detail';

  @override
  void initRouter(FluroRouter router){
    router.define(root, handler: Handler(handlerFunc: (_,__) => HomePage()));
    router.define(articleList, handler: Handler(handlerFunc: (_,__) => ArticleListPage()));
    router.define(masterDetail,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var teacherId = params['teacherId'][0];
          return MasterDetailPage(teacherId: int.parse(teacherId));
        })
    );
    router.define(videoList,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var type = params['type'][0];
          return VideoListPage(type: type);
        })
    );
  }
}