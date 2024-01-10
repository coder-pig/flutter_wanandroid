import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/data/model/wx_article_info.dart';

import '../data/model/index_article_info.dart';

class WxArticleItemWidget extends StatefulWidget {
  final WxArticle articleInfo;

  const WxArticleItemWidget({Key? key, required this.articleInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WxArticleItemWidgetState();
}

class _WxArticleItemWidgetState extends State<WxArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.topLeft,
              child: Text(
                widget.articleInfo.title,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              )),
          const SizedBox(height: 4.0),
          Row(
            children: [
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  widget.articleInfo.author,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Text(
                widget.articleInfo.superChapterName,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 12.0),
              Text(
                widget.articleInfo.niceDate,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 12.0),
            ],
          ),
          const SizedBox(height: 8.0),
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Container(color: Colors.white, alignment: Alignment.center, child: const Text('文章阅读页'));
        }));
      },
    );
  }
}
