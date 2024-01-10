
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/data/model/base_response.dart';
import 'package:flutter_wanandroid/data/model/integral.dart';
import 'package:flutter_wanandroid/data/model/login_success.dart';
import 'package:flutter_wanandroid/http/dio_client.dart';
import 'package:provider/provider.dart';
import '../util/toast_util.dart';
import 'login_screen.dart';

/// 侧滑页面
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Integral? _integral;

  @override
  void initState() {
    super.initState();
    Provider.of<LoginStatus>(context, listen: false).addListener(_requestCoin);
    _requestCoin();
  }

  void _requestCoin() {
    DioClient().get("lg/coin/userinfo/json").then((value) {
      setState(() {
        _integral = DataResponse<Integral>.fromJson(value.data, (json) => Integral.fromJson(json)).data;
      });
    }).catchError((e) {
      if (e is UnLoginException) {
        ToastUtil.show(msg: "未登录，请先登录！");
      } else if (e is OtherException) {
        ToastUtil.show(msg: e.message);
      } else {
        ToastUtil.show(msg: "请求失败：${e.toString()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF5A78EA),
            ),
            child: GestureDetector(
              child: Text(
                _integral != null ? _integral!.username : "去登录",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                // 为空时点击跳转到登录页
                if (_integral == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.score),
            title: Text('我的积分${(_integral != null ? _integral!.coinCount : "")}'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('系统设置'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('退出登录'),
          ),
        ],
      ),
    );
  }
}
