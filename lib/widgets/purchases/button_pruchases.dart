import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailspurchases.dart';
import 'package:inventory_management_system/widgets/custombuttonpurchases.dart';

class ButtonPruchaese extends GetView<AddPurchasesDetailsController> {
  const ButtonPruchaese({super.key});

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
                controller.addPurchasesToDatabase();
              },
              name: "إضافة",
              icon: Icons.add_sharp,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonSystem(
              onPressed: () {
                controller.deletePurchases();
              },
              name: "حذف",
              icon: Icons.add_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
