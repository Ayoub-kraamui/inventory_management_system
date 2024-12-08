import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsStores.dart';
import 'package:inventory_management_system/widgets/stores/button_stores.dart';
import 'package:inventory_management_system/widgets/stores/datatable_stores.dart';
import 'package:inventory_management_system/widgets/stores/input_stores.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddStoresDetailsController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "شاشة الأصناف المخازن",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: ListView(
          children: const [
            Column(
              children: [
                InputStores(),
                SizedBox(height: 20),
                ButtonStores(),
                Divider(),
                DataTubleStores()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
