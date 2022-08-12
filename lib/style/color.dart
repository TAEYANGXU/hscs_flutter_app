
import 'package:flutter/material.dart';

class AppColors
{
    static const Color theme = Color(0xffE85E31);
    static const Color tabText = Color.fromRGBO(98, 102, 108, 1);
    static const Color tabTextSelect = Color.fromRGBO(89, 129, 229, 1);
    static const Color main = Color(0xff333333);
    static const Color text = Color.fromRGBO(44, 46, 58, 1);
    static const Color text2 = Color.fromRGBO(102, 102, 102, 1);
    static const Color orangeText = Color.fromRGBO(243, 157, 48, 1);
    static const Color gredText = Color.fromRGBO(151, 151, 151, 1);
    static const Color line = Color.fromRGBO(237, 237, 238, 1);
    static const Color space = Color.fromRGBO(249, 249, 249, 1);
}

class HexColor extends Color {
    static int _getColorFromHex(String hexColor) {
        hexColor = hexColor.toUpperCase().replaceAll("#", "");
        if (hexColor.length == 6) {
            hexColor = "FF" + hexColor;
        }
        return int.parse(hexColor, radix: 16);
    }
    HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}