import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';

/// 全局配置
class GlobalConfig {
  /// 主题色
  static Color theme = AppColors.theme;

  /// 应用名称
  static String appName = '金花生';

  /// 设计稿宽度
  static int designWidth = 375;

  /// APP版本
  static String appVersion = '1.0.1';

  /// 版本密钥
  static String versionSecret = 'f9d39537-a9fc-4099-ac88-b2c3105cc81d';

  /// 项目id
  static String appProject = '82';

  /// api 环境  true:正式  false: 测试
  static bool  API_ENVIRONMENT = true;

  /// api 地址
  static String baseUrl = API_ENVIRONMENT ? 'https://api.jinoufe.com' : "";
  static String baseUrl2 = API_ENVIRONMENT ? 'https://socapi.jinoufe.com' : "";
}