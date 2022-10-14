import 'package:fluro/fluro.dart';
import 'main.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'package:hscs_flutter_app/app.dart';

class MainRouter extends IRouter
{

  static const String init = '/init';
  static const String main = '/main';
  @override
  void initRouter(FluroRouter router){
    router.define(init, handler: Handler(handlerFunc: (_,__) => MainPage()));
    router.define(main,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
          var tabIndex =  params['tabIndex'][0];
          return MainPage(
            tabIndex: tabIndex,
          );
        })
    );
  }
}