import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailsSales.dart';

class DataTubleSales extends GetView<AddSalesDetailsController> {
  const DataTubleSales({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSalesDetailsController>(
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
            rows: controller.sales.map(
              (sales) {
                controller.isSelected = controller.selectedSales == sales;

                return DataRow(
                  selected: controller.isSelected,
                  color: controller.isSelected
                      ? MaterialStateProperty.all(Colors.lightBlueAccent)
                      : null,
                  cells: [
                    DataCell(Text(sales.productName!)),
                    DataCell(Text(sales.quantity!)),
                    DataCell(Text(sales.unity!)),
                    DataCell(Text(sales.salesPrice!)),
                    DataCell(Text(sales.value!)),
                    DataCell(Text(sales.dateTimeCreated!)),
                  ],
                  onSelectChanged: (value) {
                    if (value != null) {
                      controller.fetchSalesDetails(sales);
                      print(
                          "${controller.nameproduct} ....................................");
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
