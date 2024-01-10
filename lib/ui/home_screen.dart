import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/data/model/index_article_info.dart';
import 'package:flutter_wanandroid/data/model/index_banner_info.dart';
import 'package:flutter_wanandroid/ui/auto_scroll_banner.dart';

import '../data/model/base_response.dart';
import '../http/dio_client.dart';
import '../util/toast_util.dart';
import 'article_item_widget.dart';
import 'loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  int _currentPage = 0; // 当前页数
  List<IndexBannerInfo> _bannerItems = []; // banner列表
  IndexArticleInfo? _indexData; // 文章列表项目
  List<ArticleInfo> _artcileItems = []; // 文章列表
  final ScrollController _scrollController = ScrollController(); // 滑动监听器

  @override
  void initState() {
    super.initState();
    _requestBanner();
    _requestArticleList(isRefresh: true); // 首次加载默认拉取一次
    _scrollController.addListener(() {
      // 滚动到底部时自动加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _requestArticleList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // 请求Banner接口
  Future<void> _requestBanner() async {
    DioClient().get("banner/json").then((value) {
      setState(() {
        _bannerItems =
            ListResponse<IndexBannerInfo>.fromJson(value.data, (json) => IndexBannerInfo.fromJson(json)).data ?? [];
      });
    }).catchError((e) {
      ToastUtil.show(msg: "请求失败：${e.toString()}");
    });
  }

  // 请求文章列表接口
  Future<void> _requestArticleList({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 0;
      _artcileItems.clear();
    } else {
      ++_currentPage;
      showLoadingDialog(context, canPop: false);
    }
    DioClient().get("article/list/$_currentPage/json").then((value) {
      if (!isRefresh) Navigator.pop(context);
      setState(() {
        _indexData =
            DataResponse<IndexArticleInfo>.fromJson(value.data, (json) => IndexArticleInfo.fromJson(json)).data;
        _artcileItems.addAll(_indexData!.datas);
      });
    }).catchError((e) {
      ToastUtil.show(msg: "请求失败：${e.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: () => _requestArticleList(isRefresh: true),
        child: ListView.builder(
          itemCount: _artcileItems.length,
          itemBuilder: (context, index) {
            // 两个接口都拉取成功，才加载页面
            if (_bannerItems.isNotEmpty && _artcileItems.isNotEmpty) {
              if (index == 0) {
                return AutoScrollBannerWidget(
                  imageUrls: _bannerItems.map((e) => e.imagePath).toList(),
                  onTap: (pos) => ToastUtil.show(msg: "点击了第${pos + 1}个banner"),
                );
              }
              int itemIndex = index - 1;
              return ArticleItemWidget(articleInfo: _artcileItems[itemIndex]);
            }
            return null;
          },
          controller: _scrollController,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
