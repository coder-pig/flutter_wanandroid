import 'dart:io';

import 'package:dio/dio.dart';
import '../data/model/base_response.dart';

class DioClient {
  late final Dio _dio;
  static DioClient? _instance;

  // 定义一个命名构造函数
  DioClient._internal(this._dio);

  // 单例初始化方法，需要在实例化前调用
  static void init(String baseUrl) {
    _instance ??= DioClient._internal(Dio(BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
        headers: {'user-agent': 'partner/7.8.0(Android;12;1080*2116;Scale=2.75;Xiaomi=Mi MIX 2S)'}))
      //添加请求日志拦截器，控制台可以看到请求日志
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true)));
  }

  // 定义一个工厂(私有)构造函数，确保一个类只有一个实例，并提供一个全局访问点来访问该示例
  factory DioClient() {
    if (_instance == null) {
      throw Exception('DioClient is not initialized, call init() first');
    }
    return _instance!;
  }

  // 封装请求
  Future<Response> _performRequest(Future<Response> Function() dioCall) async {
    try {
      Response response = await dioCall();
      var resp = DataResponse<Object?>.fromJson(response.data, (json) => json);
      switch (resp.errorCode) {
        case 0:
          return response;
        case -1001:
          throw UnLoginException(resp.errorMsg);
        default:
          throw OtherException(resp.errorMsg);
      }
    } on DioException catch (e) {
      print("${e.message}");
      rethrow;
    }
  }

  // 封装GET请求
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return _performRequest(() => _dio.get(endpoint, queryParameters: params));
  }

  // 封装POST请求
  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? params}) async {
    return _performRequest(() => _dio.post(endpoint, data: data, queryParameters: params));
  }

  // 设置Cookie的方法
  setCookies(List<String>? cookies) {
    _dio.options.headers[HttpHeaders.cookieHeader] = cookies;
  }

  // 移除Cookie的方法
  clearCookies() {
    _dio.options.headers.remove("Cookie");
  }
}

// 未登录异常
class UnLoginException implements Exception {
  final String message;

  UnLoginException(this.message);
}

// 其它异常
class OtherException implements Exception {
  final String message;

  OtherException(this.message);
}
