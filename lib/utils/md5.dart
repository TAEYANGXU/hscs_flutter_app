import 'dart:convert';
import 'package:crypto/crypto.dart';

// md5 加密
String stringToMd5(String data) {
  var content = const Utf8Encoder().convert(data);
  return md5.convert(content).toString();
}

///日期转时间戳
int dateToTimestamp(String date, {isMicroseconds = false}) {
  DateTime dateTime = DateTime.parse(date);
  int timestamp = dateTime.millisecondsSinceEpoch;
  if (isMicroseconds) {
    timestamp = dateTime.microsecondsSinceEpoch;
  }
  return timestamp;
}
