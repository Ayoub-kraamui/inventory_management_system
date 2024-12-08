import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailspurchases.dart';
import 'package:inventory_management_system/widgets/purchases/button_pruchases.dart';
import 'package:inventory_management_system/widgets/purchases/datatuble_pruchases.dart';
import 'package:inventory_management_system/widgets/purchases/input_purchases.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddPurchasesDetailsController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "شاشة المشتريات",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          body: ListView(
            children: const [
              Column(
                children: [
                  InputPurchases(),
                  SizedBox(height: 20),
                  ButtonPruchaese(),
                  Divider(),
                  DataTublePurchases()
                ],
              ),
            ],
          )),
    );
  }
}
