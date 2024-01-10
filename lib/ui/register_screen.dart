import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../res/colors.dart';

/// 注册页面
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  void _register() {
    // Perform register logic
    final username = _usernameController.text;
    final password = _passwordController.text;
    final rePassword = _rePasswordController.text;
    if (username.isNotEmpty && password.isNotEmpty && rePassword.isNotEmpty) {
      if (password == rePassword) {
        Fluttertoast.showToast(msg: "当前注册的用户名：$username → 密码：$password");
      } else {
        Fluttertoast.showToast(msg: "两次输入的密码不一致");
      }
    } else {
      Fluttertoast.showToast(msg: "用户名或密码不能为空");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册页', style: TextStyle(color: Colors.white)),
        backgroundColor: MyColors.leiMuBlue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _rePasswordController,
              decoration: const InputDecoration(
                labelText: '确认密码',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              onPressed: _register,
              color: MyColors.leiMuBlue,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Text('注册'),
            ),
          ],
        ),
      ),
    );
  }
}
