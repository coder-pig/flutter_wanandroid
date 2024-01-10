import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/ui/wx_article_screen.dart';

import 'home_screen.dart';

/// 首页视图
class ContentPageView extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  const ContentPageView({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  State<StatefulWidget> createState() => _ContentPageViewState();
}

class _ContentPageViewState extends State<ContentPageView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: widget.pageController,
        onPageChanged: widget.onPageChanged,
        children: const <Widget>[
          HomeScreen(),
          WxArticleScreen(),
          Center(child: Text('其它')),
        ],
      ),
    );
  }
}
