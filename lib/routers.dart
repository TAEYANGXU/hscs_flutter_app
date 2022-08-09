import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/home/router.dart';

abstract class IRouter {
  void initRouter(FluroRouter router);
}

class Routers {
  static FluroRouter route = FluroRouter();
  static List<IRouter> _routers = [];

  static void initRouter() {
    route.notFoundHandler = Handler(
        type: HandlerType.function,
        handlerFunc: (_, params) {
          ///没有找到路由
          return;
        });
    _routers.add(HomeRouter());

    _routers.forEach((r) => r.initRouter(route));
  }

  static push(BuildContext _, path,
      {bool clearStack = false,
      TransitionType transition = TransitionType.inFromRight}) {
    Routers.route
        .navigateTo(_, path, clearStack: clearStack, transition: transition);
  }
}
