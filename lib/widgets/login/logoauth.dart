import 'package:flutter/material.dart';
import 'package:inventory_management_system/constant/imageassets.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImageAssets.logoAuth,
      height: 200,
    );
  }
}
