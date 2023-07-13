/// mit GetX
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'user_controller.dart';
//
// class LoginForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final _userController = Get.put(UserController());
//
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             controller: _usernameController,
//             decoration: InputDecoration(labelText: 'Username'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter username';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _passwordController,
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter password';
//               }
//               return null;
//             },
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               if (_formKey.currentState?.validate() ?? false) {
//                 bool loginSuccessful = await _userController.login(
//                   _usernameController.text,
//                   _passwordController.text,
//                 );
//
//                 if (loginSuccessful) {
//                   print("yes");
//                   // Navigate to next screen
//                 } else {
//                   print("no");
//                   // Show error message
//                 }
//               }
//             },
//             child: Text('Login'),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// mit http

import 'dart:convert';
import 'package:alert/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Build the JSON payload
    final Map<String, dynamic> requestData = {
      'username': _usernameController.text,
      'pwd': _passwordController.text,
    };

    // Convert the payload to a JSON string
    final String requestBody = jsonEncode(requestData);

//    print('json Body: ${requestBody}');
    final client = http.Client();
    final request =
        http.Request('POST', Uri.parse('https://olat.vcrp.de/remotelogin/'));
    request.headers.addAll({'Content-Type': 'application/json'});
    request.body = requestBody;

    try {
      final response = await client.send(request);

      if (response.statusCode == 302) {
        final redirectUrl = response.headers['location'];
        final cookieValue = response.headers['set-cookie'];
        final cookieValue_1 = cookieValue?.split(';').first;
        print('Redirect to: $redirectUrl');
        print('Cookie to: $cookieValue_1');
        // Handle the redirect URL as needed
        final clientRD = http.Client();
        final requestRD = http.Request(
            'POST', Uri.parse('https://olat.vcrp.de/' + redirectUrl!));
        requestRD.headers.addAll({'Cookie': cookieValue_1!});
        try {
          final responseRD = await clientRD.send(requestRD);

          if (responseRD.statusCode == 200) {
            // Successfully followed the redirect URL
            final responseRDBody = await responseRD.stream.bytesToString();
            print('responseRD.statusCode is 200');
            await _getUserDetails(cookieValue_1);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StartScreen(responseBody: responseRDBody),
            ));
            // print('Response: $responseRDBody');
          } else {
            print(
                'Failed to follow the redirect URL. Status code: ${responseRD.statusCode}');
          }
        } catch (error) {
          print('Error: $error');
        } finally {
          clientRD.close();
          client.close();
        }
      } else if (response.statusCode == 200) {
        // Successful login
        print('Login successful!');
      } else {
        // Login failed
        print('Login failed. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      client.close();
    }
  }

  Future<void> _getUserDetails(String? cookie) async {
    // print('Cookie: $cookie');
    // // Extract only the JSESSIONID part of the cookie
    // final sessionId = cookie?.split(';').first;
    // print(
    //     'Session ID: $sessionId'); // Should print 'JSESSIONID=1CF0B081C111F1A08DAD1DEB4FA164B1'

    final client = http.Client();
    final request =
        http.Request('GET', Uri.parse('https://olat.vcrp.de/restapi/users/me'));
    request.headers.addAll({'Cookie': cookie!});

    try {
      final response = await client.send(request);

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final userData = jsonDecode(responseBody)[0];
        print('First name: ${userData['firstName']}');
        print('Email: ${userData['email']}');
      } else {
        print(
            'Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
