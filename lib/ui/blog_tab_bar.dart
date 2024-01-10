import 'package:flutter/material.dart';

import '../data/model/base_response.dart';
import '../data/model/wx_article_chapter.dart';
import '../http/dio_client.dart';
import '../util/toast_util.dart';

class BlogTabBarWidget extends StatefulWidget {
  final TabController tabController;
  final List<WxArticleChapter> chapterList;

  const BlogTabBarWidget({Key? key, required this.tabController, required this.chapterList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlogTabBarWidgetState();
}

class _BlogTabBarWidgetState extends State<BlogTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      isScrollable: true,
      tabs: widget.chapterList.map((chapter) => Tab(text: chapter.name)).toList(),
    );
  }
}
