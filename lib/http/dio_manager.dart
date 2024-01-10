import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/util/toast_util.dart';
import '../util/global_util.dart';

class WanAndroid {
  // 网络请求过程可能需要使用当前的上下文信息，如打开一个新路由
  WanAndroid([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context; // 上下文
  late Options _options; // 附加选项
  static const bool enableProxy = true; // 是否设置代理方便调试阶段抓包

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'https://www.wanandroid.com/',
    connectTimeout: const Duration(seconds: 30), // 请求超时
    receiveTimeout: const Duration(seconds: 30), // 响应超时
    // 自定义请求头，ua不设置默认是：Dart/3.2 (dart:io)
    headers: {HttpHeaders.userAgentHeader: 'partner/7.8.0(Android;12;1080*2116;Scale=2.75;Xiaomi=Mi MIX 2S)'},
  ));

  static void init() {
    // 调试阶段开启抓包调试
    if (isDebug) {
      // 使用代理
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          return HttpClient()
            // 将请求代理到 本机IP:8888，是抓包电脑的IP！！！不要直接用localhost，会报错:
            // SocketException: Connection refused (OS Error: Connection refused, errno = 111), address = localhost, port = 47972
            ..findProxy = (uri) {
              return 'PROXY 192.168.102.125:8888';
            }
            // 抓包工具一般都会提供一个自签名的证书，会通不过证书校验，这里禁用下
            ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        },
      );
    }
    // 初始化拦截器
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (option, handler) async => handler.next(option),
        onResponse: (response, handler) async {
          var data = response.data;
          if (data is String) data = json.decode(data);
          if (data is Map) {
            if (data['errorCode'] == -1001) {
              int errorCode = data['errorCode'] ?? 0;
              String errorMsg = data['errorMsg'] ?? '请求失败[$errorCode]';
              switch (errorCode) {
                case 0:
                  return handler.next(response);
                case -1001:
                  // ToastUtil.show(msg: "未登录...");
                  // 跳转去登录
                  return handler.reject(DioException(requestOptions: response.requestOptions, error: errorMsg));
                default:
                  ToastUtil.show(msg: errorMsg);
                  return handler.reject(DioException(requestOptions: response.requestOptions, error: errorMsg));
              }
            }
          }
        },
        onError: (error, handler) async {
          String errStr = '未知错误';
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              errStr = '连接超时';
              break;
            case DioExceptionType.sendTimeout:
              errStr = '请求超时';
              break;
            case DioExceptionType.receiveTimeout:
              errStr = '响应超时';
              break;
            case DioExceptionType.cancel:
              errStr = '请求取消';
              break;
            case DioExceptionType.badResponse:
              errStr = '出现异常';
              break;
            case DioExceptionType.connectionError:
              errStr = error.error is SocketException ? "网络连接超时" : "连接错误";
              break;
            default:
              errStr = '未知错误';
              break;
          }
          ToastUtil.show(msg: errStr);
          return handler.reject(error);
        }));
  }

  /// 首页Banner
  Future<String> getBanner() async {
    var resp = await dio.get<String>('banner/json');
    return resp.data.toString();
  }

  /// 首页Banner
  Future<String> userScore() async {
    var resp = await dio.get<String>('lg/coin/userinfo/json');
    return resp.data.toString();
  }

}
