import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';


class TextSize {
  static const double moreTiny = 10;
  static const double tiny = 11;
  static const double small = 12;
  static const double minor = 13;
  static const double main = 14;
  static const double main1 = 15;
  static const double big = 16;
  static const double s17 = 17;
  static const double larger = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s26 = 26;
  static const double s36 = 36;
}

class AppTextStyle {
  static TextStyle moreTiny = baseStyle(fontSize: TextSize.moreTiny);
  static TextStyle moreTinyWhite = baseStyle(fontSize: TextSize.moreTiny, color: Colors.white);
  static TextStyle moreTinyWhiteBold = baseStyle(fontSize: TextSize.moreTiny, color: Colors.white, bold: true);
  static TextStyle moreTinyTheme = baseStyle(fontSize: TextSize.moreTiny, color: AppColors.theme);
  static TextStyle moreTinyThemeBold = baseStyle(fontSize: TextSize.moreTiny, color: AppColors.theme, bold: true);

  static TextStyle baseStyle(
      {double fontSize = TextSize.main,
        Color color = AppColors.main,
        bool bold = false,
        FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: Adapt.px(fontSize),
      color: color,
      fontWeight: fontWeight != FontWeight.normal
          ? fontWeight
          : bold
          ? FontWeight.bold
          : FontWeight.normal,
      decoration: TextDecoration.none,
    );
  }
}