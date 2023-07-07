import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _userController = Get.put(UserController());

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                bool loginSuccessful = await _userController.login(
                  _usernameController.text,
                  _passwordController.text,
                );

                if (loginSuccessful) {
                  print("yes");
                  // Navigate to next screen
                } else {
                  print("no");
                  // Show error message
                }
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
