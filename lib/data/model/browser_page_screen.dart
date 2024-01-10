import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowserPageScreen extends StatefulWidget {
  final String url;

  const BrowserPageScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _BrowserPageScreenState();
}

class _BrowserPageScreenState extends State<BrowserPageScreen> {
  bool _isLoading = true; // 网页是否正在加载中

  // 复制URL到剪切板
  void _copyUrlToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.url));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('链接已复制到剪贴板')));
  }

  // 跳转手机浏览器
  void _openBrowser() async {
    Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.leiMuBlue,
        title: const Text('Van ♂ Android'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: _copyUrlToClipboard,
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser, color: Colors.white),
            onPressed: _openBrowser,
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onLoadStart: (InAppWebViewController controller, Uri? url) {
              setState(() {
                _isLoading = true; // 页面开始加载，更新状态为 true
              });
            },
            // 页面停止加载时的回调
            onLoadStop: (InAppWebViewController controller, Uri? url) {
              setState(() {
                _isLoading = false; // 页面停止加载，更新状态为 false
              });
            },
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator()) // 如果正在加载，则显示圆形进度指示器
              : Container(), // 如果不是，则不显示任何内容
        ],
      ),
    );
  }
}
