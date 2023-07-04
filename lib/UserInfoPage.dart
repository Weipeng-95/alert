import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final int identityKey;

  UserInfoPage({
    required this.identityKey,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Identity Key: $identityKey'),
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}
