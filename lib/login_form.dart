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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
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

    try {
      // Send the POST request to the server
      final response = await http.post(
        Uri.parse('https://olat.vcrp.de/remotelogin/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Process the response
      if (response.statusCode == 200) {
        // Successful login
        print('Login successful!');
      } else {
        // Login failed
        print('Login failed. Please try again.');
      }
    } catch (error) {
      print('Error: $error');
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
            decoration: InputDecoration(
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
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
