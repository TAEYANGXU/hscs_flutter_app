import 'dart:convert';
import 'package:crypto/crypto.dart';

// md5 加密
String stringToMd5(String data) {
  var content = const Utf8Encoder().convert(data);
  return md5.convert(content).toString();
}
