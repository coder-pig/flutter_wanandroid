import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/ui/wx_article_list.dart';

import '../data/model/base_response.dart';
import '../data/model/wx_article_chapter.dart';
import '../http/dio_client.dart';
import '../util/toast_util.dart';
import 'blog_tab_bar.dart';

class WxArticleScreen extends StatefulWidget {
  const WxArticleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WxArticleScreenState();
}

class _WxArticleScreenState extends State<WxArticleScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late List<WxArticleChapter> _chapterList = [];

  // 请求公众号列表
  Future<void> _wxArticleChapters() async {
    DioClient().get("wxarticle/chapters/json").then((value) {
      if(mounted) {
        setState(() {
          _chapterList =
              ListResponse<WxArticleChapter>.fromJson(value.data, (json) => WxArticleChapter.fromJson(json)).data ?? [];
          _tabController = TabController(length: _chapterList.length, vsync: this);
        });
      }
    }).catchError((e) {
      ToastUtil.show(msg: "请求失败：${e.toString()}");
    });
  }

  @override
  void initState() {
    super.initState();
    _wxArticleChapters();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(_chapterList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          BlogTabBarWidget(tabController: _tabController, chapterList: _chapterList),
          // 高度填满剩余空间
          Expanded(
            child: TabBarView(
              // 同样使用TabBarView
                controller: _tabController, // 关联同一个TabController
                children: _chapterList.map((chapter) => WxArticleListWidget(chapterId: chapter.id)).toList()),
          ),
        ],
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
