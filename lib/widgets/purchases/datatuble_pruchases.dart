import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailspurchases.dart';

class DataTublePurchases extends GetView<AddPurchasesDetailsController> {
  const DataTublePurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPurchasesDetailsController>(
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
              )),
              DataColumn(
                  label: Text(
                    "تاريخ الإضافة",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  numeric: true),
            ],
            rows: controller.purchases.map(
              (purchases) {
                controller.isSelected =
                    controller.selectedPurchase == purchases;

                return DataRow(
                  selected: controller.isSelected,
                  color: controller.isSelected
                      ? MaterialStateProperty.all(Colors.lightBlueAccent)
                      : null,
                  cells: [
                    DataCell(Text(purchases.productName!)),
                    DataCell(Text(purchases.quantity!)),
                    DataCell(Text(purchases.unity!)),
                    DataCell(Text(purchases.purchasePrice!)),
                    DataCell(Text(purchases.salesPrice!)),
                    DataCell(Text(purchases.value!)),
                    DataCell(Text(purchases.dateTimeCreated!)),
                  ],
                  onSelectChanged: (value) {
                    if (value != null) {
                      controller.fetchPurchaseDetails(purchases);
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
