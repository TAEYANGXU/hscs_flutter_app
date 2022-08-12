import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:hscs_flutter_app/style/color.dart';
import '../global_config.dart';
import 'adapt.dart';

Image loadLocalImage(String name, {String ext = '.png', Color color = AppColors.theme, double width = 0.0, double height = 0.0}) {
  return Image.asset(
    'lib/assets/image/$name$ext',
    width: width,
    height: height,
    excludeFromSemantics: true,
    gaplessPlayback: true,
    // color: color,
  );
}

Image localImage(String name, {String ext = '.png', Color color = AppColors.theme, double width = 0.0, double height = 0.0,BoxFit fit = BoxFit.contain}) {
  return Image.asset(
    'lib/assets/image/$name$ext',
    width: width,
    height: height,
    excludeFromSemantics: true,
    gaplessPlayback: true,
    fit: fit,
    // color: color,
  );
}