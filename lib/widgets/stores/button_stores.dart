import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsStores.dart';
import 'package:inventory_management_system/widgets/custombuttonpurchases.dart';

class ButtonStores extends GetView<AddStoresDetailsController> {
  const ButtonStores({super.key});

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
                controller.addStoresToDatabase();
              },
              name: "إضافة",
              icon: Icons.add_sharp,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonSystem(
              onPressed: () {
                controller.updateStores();
              },
              name: "تعديل",
              icon: Icons.update,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomButtonSystem(
              onPressed: () {
                controller.deleteStores();
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
