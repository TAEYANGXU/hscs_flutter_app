import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:hscs_flutter_app/routers.dart';

class HomeRouter extends IRouter
{
  static const String root = '/home';
  @override
  void initRouter(FluroRouter router){
    router.define(root, handler: Handler(handlerFunc: (_,__) => HomePage()));
  }
}