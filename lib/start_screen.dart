import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final String responseBody;

  StartScreen({required this.responseBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Response body: $responseBody'),
      ),
    );
  }
}
