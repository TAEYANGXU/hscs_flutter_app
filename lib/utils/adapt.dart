import 'package:flutter/material.dart';
import '../global_config.dart';

class Adapt {
  static final int _designWidth = GlobalConfig.designWidth;
  static MediaQueryData mediaQuery = const MediaQueryData();
  static double _width = 0;
  static double _height = 0;
  static double _rpx = 0;
  static double _pixeRatio = 0;
  static late EdgeInsets _padding;

  static init(BuildContext _) {
    mediaQuery = MediaQuery.of(_);
    _width = mediaQuery.size.width;

    print("_width22：$_width");

    _height = mediaQuery.size.height;
    _pixeRatio = mediaQuery.devicePixelRatio;
    _padding = mediaQuery.padding;
    initRpx();
  }

  static initRpx() {
    _rpx = _width / _designWidth;
  }

  static double px(num size) {
    if (_rpx == null) {
      initRpx();

    }
    return size * _rpx;
  }

  static double onepx() {
    return 1 / _pixeRatio;
  }

  static double screenW() {
    return _width;
  }

  static double screenH() {
    return _height;
  }

  static EdgeInsets padding() {
    return _padding;
  }
}