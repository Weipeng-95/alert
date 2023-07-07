// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:cookie_jar/cookie_jar.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'OpenOlat Login',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('OpenOlat Login'),
//         ),
//         body: Center(
//           child: LoginForm(),
//         ),
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   // Future<String> getCsrfToken() async {
//   //   // 发送 GET 请求到登录页面
//   //   final response = await http.get(Uri.parse('https://your-login-url.com'));
//   //
//   //   // 解析返回的 HTML
//   //   final document = parse(response.body);
//   //
//   //   // 提取 CSRF token，这里假设它在一个名为 csrfmiddlewaretoken 的 input field 中
//   //   final hiddenInput = document.querySelector('input[name=csrfmiddlewaretoken]');
//   //
//   //   if (hiddenInput != null) {
//   //     return hiddenInput.attributes['value']!;
//   //   } else {
//   //     throw Exception('CSRF token not found');
//   //   }
//   // }
//
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   Dio dio = Dio();
//   @override
//   void initState() {
//     super.initState();
//     dio.interceptors.add(CookieManager(CookieJar()));
//   }
//
//   Future<int?> loginUser(String username, String password) async {
//     var response = await dio.post(
//       'https://olat.vcrp.de/remotelogin/',
//       data: {
//         'username': username,
//         'pwd': password,
//       },
//     );
//     print("object");
//     if (response.statusCode == 200) {
//       return response.statusCode;
//     } else {
//       throw Exception('Failed to login');
//     }
//   }
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = '';
//       });
//
//       try {
//         String username = _usernameController.text;
//         String password = _passwordController.text;
//
//         int? response = await loginUser(username, password);
//
//         // 处理响应
//         print('Response: $response');
//       } catch (e) {
//         setState(() {
//           _errorMessage = '登录失败';
//         });
//       }
//
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _launchForgotPasswordUrl() async {
//     const url =
//         'https://olat.vcrp.de/dmz/1%3A1%3Ao_olat_login_change_pwd%3A1%3A0%3Acid%3Amenu.pw/';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw '无法打开链接: $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Benutzername'),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return '请输入用户名';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Passwort'),
//               obscureText: true,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return '请输入密码';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _submitForm,
//               child: _isLoading ? CircularProgressIndicator() : Text('登录'),
//             ),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: _launchForgotPasswordUrl,
//                     child: Text('Passwort vergessen'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // 处理"Registrieren"链接
//                     },
//                     child: Text('Registrieren'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'login_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
