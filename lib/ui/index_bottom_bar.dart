import 'package:flutter/material.dart';

import '../res/colors.dart';

class BottomBarWidget extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const BottomBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: widget.onItemSelected,
      selectedItemColor: MyColors.leiMuBlue,
      // 选中时的颜色
      unselectedItemColor: Colors.grey,
      // 未选中时的颜色
      showSelectedLabels: true,
      // 选中的label是否展示
      showUnselectedLabels: true,
      // 未选中的label是否展示
      currentIndex: widget.currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: '公众号'),
        BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: '其它'),
      ],
    );
  }
}
