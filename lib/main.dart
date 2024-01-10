import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/data/model/login_success.dart';
import 'package:flutter_wanandroid/res/colors.dart';
import 'package:flutter_wanandroid/ui/drawer_screen.dart';
import 'package:flutter_wanandroid/ui/index_bottom_bar.dart';
import 'package:flutter_wanandroid/ui/index_container_screen.dart';
import 'package:flutter_wanandroid/util/sp_util.dart';
import 'package:provider/provider.dart';

import 'http/dio_client.dart';

void main() {
  // 确保Flutter框架初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  DioClient.init("https://www.wanandroid.com/");
  SharedPreferencesUtil.getInstance().then((value) {
    List<String>? cookies = value.getStringList("cookies");
    DioClient().setCookies(cookies);
  });
  runApp(ChangeNotifierProvider(create: (context) => LoginStatus(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Van ♂ Android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.leiMuBlue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white, // White color for AppBar title text.
            fontSize: 20,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Van ♂ Android'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
   late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // 组件销毁时要注销掉控制器
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    // 页面改变时更新下标状态
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    // 点击Tab时切页
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.leiMuBlue,
          title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              children: [
                ContentPageView(
                  pageController: _pageController,
                  onPageChanged: _onPageChanged,
                ),
                BottomBarWidget(
                  currentIndex: _currentIndex,
                  onItemSelected: _onItemTapped,
                )
              ],
            )),
        drawer: const DrawerScreen());
  }
}
