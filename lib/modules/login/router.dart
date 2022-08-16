import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'login.dart';
import 'verify_code.dart';
import 'package:flutter/material.dart';

class LoginRouter extends IRouter {
  static const String login = '/login';
  static const String loginVerity = '/login/verity';

  @override
  void initRouter(FluroRouter router) {
    router.define(login, handler: Handler(handlerFunc: (_, __) => LoginPage()));
    router.define(loginVerity,
        handler: Handler(handlerFunc: (_, Map<String, dynamic> params) {
      var mobile = params['mobile'][0];
      return LoginVeriftyCodePage(
        mobile: mobile,
      );
    }));
  }
}
