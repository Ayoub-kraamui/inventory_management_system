import 'package:flutter/material.dart';

class LogoHome extends StatelessWidget {
  final double height;
  final String name;
  const LogoHome({super.key, required this.height, required this.name});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      height: height,
    );
  }
}
