import 'package:dio/dio.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/global_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

///请求拦截器
class RequestInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // options.contentType = "application/json";
    var time = (DateTime.now().millisecondsSinceEpoch / 1000).round();
    options.headers['TIMESTAMP'] = time;
    options.headers['CurTime'] = time;
    bool isSelf = options.uri.toString().contains(options.baseUrl);
    String pl = Device.pl;
    String version = Device.version;

    if (isSelf) {
      options.headers['Accept-Encoding'] = 'gzip';
      options.headers['APPVER'] = version;
      options.headers.addAll(await Device.getDeviveInfo());
      options.headers['User-Agent'] = 'Mozilla/5.0';
      options.headers['DEVICE'] = await Device.getDeviceId();
      options.headers['SIGN'] = _sign(pl: pl, version: version, time: time);
      options.headers['PROJECT'] = GlobalConfig.appProject;
      options.headers['CHANNEL'] = "jius0001";
      options.headers['DEVICETOKEN'] = await Device.getDeviceId();
      options.headers['buildCode'] = "10";
    }

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConfig.kToken).toString().trim();
    if(token.isNotEmpty){
      options.headers['token'] = token;
    }
    var  headers =  options.headers;
    print("headers = $headers");
    return super.onRequest(options, handler);
  }

  String _sign({String version = "", String pl = "", int time = 0}) {
    List<String> list = [];
    list.add('APPVER=$version');
    list.add('PL=$pl');
    list.add("TIMESTAMP=$time");
    String text =  list.join("&") + GlobalConfig.versionSecret;
    return stringToMd5(text);
  }
}