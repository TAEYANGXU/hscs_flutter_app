import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'entity.dart';
import 'interceptor/index.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

const bool PROXY_ENABLE = true;

class DioUserManager {
  static DioUserManager? _instance;

  factory DioUserManager() => _instance ??= DioUserManager._init();

  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();

  DioUserManager._init() {
    final Options options = Options();
    dio = Dio();
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(NetCacheInterceptor());
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  void init({
    String? baseUrl,
    int connectTimeout = 15000,
    int receiveTimeout = 15000,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 添加认证
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers;
    // String token = "WXC/ata4C1zbg+/ASsIUIuxqs/ZF+Z+37HYP/BX4AIU=";
    String token = "";
    if (token.isNotEmpty) {
      headers = {
        'token': token,
      };
    }
    return headers;
  }

  Future get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    Response response;
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    print("path = $path");
    print("response.data = $response.data");
    return response;
  }

  Future post(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(
      path,
      data: params != null ? FormData.fromMap(params) : params,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    print("params = $params");
    print("path = $path");
    print("response.data = $response");
    return response;
  }

  Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    print("params = $params");
    print("path = $path");
    print("response.data = $response.data");
    return response;
  }
  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }
}

class DioManagerUserUtils {
  static void init({
    required String baseUrl,
    int connectTimeout = 15000,
    int receiveTimeout = 15000,
    List<Interceptor>? interceptors,
  }) {
    DioUserManager().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
    );
  }

  static void cancelRequests({required CancelToken token}) {
    DioUserManager().cancelRequests(token: token);
  }

  static Future<BaseEntity> get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    var response = await DioUserManager().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
    var data = response.toString();
    final bool isCompute = data.length > 10 * 1024;
    final Map<String, dynamic> map =
    isCompute ? await compute(parseData, data) : parseData(data);
    var model = BaseEntity.fromJson(map);
    return model;
  }

  static Future<BaseEntity<T>> getT<T>(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    var response = await DioUserManager().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
    var data = response.toString();
    final bool isCompute = data.length > 10 * 1024;
    final Map<String, dynamic> map =
    isCompute ? await compute(parseData, data) : parseData(data);
    var model = BaseEntity<T>.fromJson(map);
    return model;
  }

  static Future<BaseEntity> post(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    var response = await DioUserManager().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var responseData = response.toString();
    final bool isCompute = responseData.length > 10 * 1024;
    final Map<String, dynamic> map = isCompute
        ? await compute(parseData, responseData)
        : parseData(responseData);
    var model = BaseEntity.fromJson(map);
    return model;
  }

  static Future<BaseEntity<T>> postT<T>(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    var response = await DioUserManager().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var responseData = response.toString();
    final bool isCompute = responseData.length > 10 * 1024;
    final Map<String, dynamic> map = isCompute
        ? await compute(parseData, responseData)
        : parseData(responseData);
    var model = BaseEntity<T>.fromJson(map);
    return model;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}
