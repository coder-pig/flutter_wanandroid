import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/colors.dart';

/// 展示一个加载对话框，[context] 上下文，[canPop] 是否允许关闭对话框
void showLoadingDialog(BuildContext context, {bool canPop = true}) {
  showDialog(
    context: context,
    barrierDismissible: false, // 点击外部不关闭对话宽
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => canPop, // 根据canPop参数决定是否允许关闭对话框
          child: const Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // 指定一个固定不变的颜色
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.leiMuBlue)),
                  ],
                ),
              ),
            ),
          ));
    },
  );
}
