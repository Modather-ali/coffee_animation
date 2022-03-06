import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final String titleText;
  const AuthScreen({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
    );
  }
}
