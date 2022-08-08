import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:uuid/uuid.dart';

class Device {
  static get isAndroid => Platform.isAndroid;

  static get isIOS => Platform.isIOS;

  static get version => '2.7.0';

  static get pl => isIOS ? 'iOS' : "ANDROID";

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (isAndroid) {
      var android = await deviceInfo.androidInfo;
      var uuid = const Uuid();
      deviceId = uuid.v5(Uuid.NAMESPACE_OID, android.androidId);
    } else {
      var iOS = await deviceInfo.iosInfo;
      deviceId = iOS.identifierForVendor;
    }
    return deviceId;
  }

  static Future<Map<String, dynamic>> getDeviveInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    if (isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    } else {
      androidInfo = await deviceInfo.androidInfo;
    }

    return <String, dynamic>{
      'APPVER': version,
      'PL': pl,
      'MODEL': isIOS ? iosInfo?.name : androidInfo?.device,
      'OS': isIOS ? iosInfo?.systemVersion : androidInfo?.version,
      'uuid': Uuid().toString(),
    };
  }
//
// static Map<String, dynamic> _readIOSDeviceInfo(IosDeviceInfo data) {
//   return <String, dynamic>{
//     'name': data.name,
//     'systemName': data.systemName,
//     'systemVersion': data.systemVersion,
//     'model': data.model,
//     'localizedModel': data.localizedModel,
//     'identifierForVendor': data.identifierForVendor,
//     'isPhysicalDevice': data.isPhysicalDevice,
//     'utsname.sysname:': data.utsname.sysname,
//     'utsname.nodename:': data.utsname.nodename,
//     'utsname.release:': data.utsname.release,
//     'utsname.version:': data.utsname.version,
//     'utsname.machine:': data.utsname.machine,
//   };
// }
//
// static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
//   return <String, dynamic>{
//     'version.securityPatch': build.version.securityPatch,
//     'version.sdkInt': build.version.sdkInt,
//     'version.release': build.version.release,
//     'version.previewSdkInt': build.version.previewSdkInt,
//     'version.incremental': build.version.incremental,
//     'version.codename': build.version.codename,
//     'version.baseOS': build.version.baseOS,
//     'board': build.board,
//     'bootloader': build.bootloader,
//     'brand': build.brand,
//     'device': build.device,
//     'display': build.display,
//     'fingerprint': build.fingerprint,
//     'hardware': build.hardware,
//     'host': build.host,
//     'id': build.id,
//     'manufacturer': build.manufacturer,
//     'model': build.model,
//     'product': build.product,
//     'supported32BitAbis': build.supported32BitAbis,
//     'supported64BitAbis': build.supported64BitAbis,
//     'supportedAbis': build.supportedAbis,
//     'tags': build.tags,
//     'type': build.type,
//     'isPhysicalDevice': build.isPhysicalDevice,
//     'androidId': build.androidId
//   };
// }
}
