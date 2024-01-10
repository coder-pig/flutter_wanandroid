/// 请求方法枚举
enum HttpMethod { GET, POST }

/// 请求基类
abstract class BaseRequest {
  // 是否使用https协议
  bool useHttps = true;

  // 路径参数
  String? pathParams;

  // 请求参数
  Map<String, dynamic> params = {};

  // 请求头
  Map<String, dynamic> header = {};

  // 域名
  String domain();

  // 路径
  String path();

  // 请求url
  String url() {
    String fullPath = '${path()}${pathParams == null ? "" : (path().endsWith("/") ? "\$" : "/")}';
    Uri uri = useHttps ? Uri.https(domain(), fullPath, params) : Uri.http(domain(), fullPath, params);
    return uri.toString();
  }

  // 请求方法
  HttpMethod httpMethod() => HttpMethod.POST;

  // 是否需要登录
  bool needLogin() => false;

  // 添加请求参数
  BaseRequest addParam(String key, Object value) {
    params[key] = value;
    return this;
  }

  // 添加请求头
  BaseRequest addHeader(String key, Object value) {
    header[key] = value;
    return this;
  }
}
