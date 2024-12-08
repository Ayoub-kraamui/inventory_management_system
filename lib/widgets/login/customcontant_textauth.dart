import 'package:flutter/material.dart';

class CustomContantTextAuth extends StatelessWidget {
  final String text;
  const CustomContantTextAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
