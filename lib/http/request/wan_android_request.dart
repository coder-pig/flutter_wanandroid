import 'package:flutter_wanandroid/http/request/base_request.dart';

// 玩Android基类Request
abstract class WanAndroidRequest extends BaseRequest {
  @override
  String domain() => "www.wanandroid.com";
}

class BannerRequest extends WanAndroidRequest {
  @override
  String path() => "banner/json";
}

