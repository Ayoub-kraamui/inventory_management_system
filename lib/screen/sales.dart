import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsSales.dart';
import 'package:inventory_management_system/widgets/sales/button_sales.dart';
import 'package:inventory_management_system/widgets/sales/datatable_sales.dart';
import 'package:inventory_management_system/widgets/sales/input_sales.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSalesDetailsController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "شاشة المبيعات",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: ListView(
          children: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputSales(),
                SizedBox(height: 20),
                ButtonSales(),
                Divider(),
                DataTubleSales()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
