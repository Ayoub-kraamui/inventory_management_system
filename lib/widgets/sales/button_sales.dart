import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsSales.dart';
import 'package:inventory_management_system/widgets/custombuttonpurchases.dart';

class ButtonSales extends GetView<AddSalesDetailsController> {
  const ButtonSales({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonSystem(
              onPressed: () {
                controller.addSalesToDatabase();
              },
              name: "إضافة",
              icon: Icons.add_sharp,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonSystem(
              onPressed: () {
                controller.deleteSales();
              },
              name: "حذف",
              icon: Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
