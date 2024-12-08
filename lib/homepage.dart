import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/approute.dart';
import 'package:inventory_management_system/constant/imageassets.dart';
import 'package:inventory_management_system/widgets/custombuttonhomepage.dart';
import 'package:inventory_management_system/widgets/logohome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "نظام إدارة المخزون",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Row(
          children: [
            Container(
              color: Colors.blue.shade200,
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              width: 255,
              child: Column(
                children: [
                  CustomButtonHomePage(
                    onPressed: () {
                      Get.toNamed(AppRoute.sales);
                    },
                    name: "المبيعات",
                    icon: Icons.local_grocery_store_outlined,
                  ),
                  CustomButtonHomePage(
                      onPressed: () {
                        Get.toNamed(AppRoute.purchases);
                      },
                      name: "المشتريات",
                      icon: Icons.add_business_outlined),
                  CustomButtonHomePage(
                    onPressed: () {
                      Get.toNamed(AppRoute.stores);
                    },
                    name: "الأصناف والمخازن",
                    icon: Icons.store_mall_directory_outlined,
                  ),
                  const LogoHome(name: AppImageAssets.logoApp, height: 170),
                  // Text(
                  //   "جميع الحقوق محفوظة لدى المهندس أيوب كرامي 775453026",
                  //   style: TextStyle(color: Colors.white, fontSize: 15),
                  // )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 400),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoHome(name: AppImageAssets.logoAppTwo, height: 400),
                    Divider(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
