import 'package:dio/dio.dart';
import 'dart:io';
import '../exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

///错误拦截器
class ErrorInterceptor extends Interceptor {
  // 是否有网
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> onError(
      DioError err, ErrorInterceptorHandler errIHandler) async {
    if (err.error is SocketException) {
      err.error = MyDioSocketException(
        err.message,
        osError: err.error?.osError,
        address: err.error?.address,
        port: err.error?.port,
      );
    }
    if(err.error == DioErrorType.other){
      bool isConnectNetWork = await isConnected();
      if(!isConnectNetWork && err.error is MyDioSocketException){
        err.error.message = "当前网络不可用，请检查您的网络";
      }
    }
    //统一处理
    AppException appException = AppException.create(err);
    print('DioError===: ${appException.toString()}');
    err.error = appException;
    return super.onError(err, errIHandler);
  }
}