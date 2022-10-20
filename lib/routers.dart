import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/home/router.dart';
import 'package:hscs_flutter_app/modules/main/router.dart';
import 'package:hscs_flutter_app/modules/login/router.dart';
import 'package:hscs_flutter_app/modules/mine/router.dart';
import 'package:hscs_flutter_app/modules/web/router.dart';
import 'package:hscs_flutter_app/modules/vip/router.dart';

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
    _routers.add(MainRouter());
    _routers.add(HomeRouter());
    _routers.add(LoginRouter());
    _routers.add(MineRouter());
    _routers.add(VipRouter());
    _routers.add(WebViewRouter());
    _routers.forEach((r) => r.initRouter(route));
  }

  static push(BuildContext _, path,
      {bool clearStack = false,
      Map<String, dynamic>? params,
      TransitionType transition = TransitionType.inFromRight,RouteSettings? settings}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    path = path + query;
    Routers.route
        .navigateTo(_, path, clearStack: clearStack, transition: transition,routeSettings: settings);
  }
}
