import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsStores.dart';

class DataTubleStores extends GetView<AddStoresDetailsController> {
  const DataTubleStores({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStoresDetailsController>(
      builder: (controller) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Get.width,
          child: DataTable(
            sortColumnIndex: 0,
            sortAscending: true,
            showCheckboxColumn: false,
            showBottomBorder: true,
            columns: const [
              DataColumn(
                  label: Text(
                "أسم المنتج",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "الكمية",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "الوحدة",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "سعر الشراء",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "سعر البيع",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                    "إجمالي السعر",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  numeric: true),
            ],
            rows: controller.stores.map(
              (stores) {
                controller.isSelected = controller.selectedStores == stores;

                return DataRow(
                  selected: controller.isSelected,
                  color: controller.isSelected
                      ? MaterialStateProperty.all(Colors.lightBlueAccent)
                      : null,
                  cells: [
                    DataCell(Text(stores.productName!)),
                    DataCell(Text(stores.quantity!)),
                    DataCell(Text(stores.unity!)),
                    DataCell(Text(stores.purchasePrice!)),
                    DataCell(Text(stores.salesPrice!)),
                    DataCell(Text(stores.value!)),
                  ],
                  onSelectChanged: (value) {
                    if (value != null) {
                      controller.fetchStoresDetails(stores);
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
