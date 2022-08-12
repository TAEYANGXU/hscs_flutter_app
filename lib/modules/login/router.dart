import 'package:fluro/fluro.dart';
import 'package:hscs_flutter_app/routers.dart';
import 'login.dart';

class LoginRouter extends IRouter
{
  static const String login = '/login';
  @override
  void initRouter(FluroRouter router){
    router.define(login, handler: Handler(handlerFunc: (_,__) => LoginPage()));
  }
}