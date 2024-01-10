import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/ui/loading_dialog.dart';
import 'package:flutter_wanandroid/ui/wx_article_item_widget.dart';

import '../data/model/base_response.dart';
import '../data/model/wx_article_info.dart';
import '../http/dio_client.dart';
import '../util/toast_util.dart';

class WxArticleListWidget extends StatefulWidget {
  final int chapterId;

  const WxArticleListWidget({Key? key, required this.chapterId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WxArticleListWidgetState();
}

class _WxArticleListWidgetState extends State<WxArticleListWidget> with AutomaticKeepAliveClientMixin {
  int _currentPage = 0; // 当前页数
  List<WxArticle> _articleList = []; // 文章列表
  final ScrollController _scrollController = ScrollController(); // 滑动监听器

  @override
  void initState() {
    super.initState();
    _requestArticleList(isRefresh: true);
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

  // 请求文章列表
  Future<void> _requestArticleList({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 0;
      _articleList.clear();
    } else {
      ++_currentPage;
      showLoadingDialog(context, canPop: false);
    }
    DioClient().get("wxarticle/list/${widget.chapterId}/$_currentPage/json").then((value) {
      if (!isRefresh) Navigator.pop(context);
      setState(() {
        var data = DataResponse<WxArticleRes>.fromJson(value.data, (json) => WxArticleRes.fromJson(json)).data;
        _articleList.addAll(data!.datas);
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
          itemCount: _articleList.length,
          itemBuilder: (context, index) {
            // 文章列表不为空才显示
            if (_articleList.isNotEmpty) {
              return WxArticleItemWidget(articleInfo: _articleList[index]);
            } else {
              return null;
            }
          },
          controller: _scrollController,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
