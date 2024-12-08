import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_system/database_services/database_helper.dart';
import 'package:inventory_management_system/model/sales_modle.dart';
import 'package:inventory_management_system/model/store_modle.dart';

class AddSalesDetailsController extends GetxController {
  TextEditingController nameproduct = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unity = TextEditingController();
  TextEditingController salesPrice = TextEditingController();
  TextEditingController value = TextEditingController();
  late int salesId;
  late String dTCreated;
  List<Sales> sales = <Sales>[];
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isSelected = false;
  Sales? selectedSales;
  List<Stores> productNames = <Stores>[];
  bool isDaily = false;
  bool isWeekly = false;
  bool isMonthly = false;

  void selectSales(Sales sales) {
    selectedSales = sales;
  }

  void updatefetchDailySales() {
    isDaily = !isDaily;
    getAllSales();
  }

  void updatefetchWeeklySales() {
    isWeekly = !isWeekly;
    getAllSales();
  }

  void updatefetchMonthySales() {
    isMonthly = !isMonthly;
    getAllSales();
  }

  void getAllSales() async {
    productNames = await DatabaseHelper.instance.getStoresList();
    if (isDaily == true && isWeekly == false && isMonthly == false) {
      sales = await DatabaseHelper.instance.getDailySales();
    } else if (isDaily == false && isWeekly == true && isMonthly == false) {
      sales = await DatabaseHelper.instance.getWeeklySales();
    } else if (isDaily == false && isWeekly == false && isMonthly == true) {
      sales = await DatabaseHelper.instance.getMonthlySales();
    } else {
      sales = await DatabaseHelper.instance.getSalesList();
    }
    update();
  }

  void _updateValue() {
    // تحويل الكمية وسعر الشراء إلى double
    double qty = double.tryParse(quantity.text) ?? 0;
    double price = double.tryParse(salesPrice.text) ?? 0;

    // حساب القيمة
    double calculatedValue = qty * price;

    // تحديث حقل القيمة
    value.text = calculatedValue.toString();
  }

  void fetchSalesDetails(Sales sales) {
    salesId = sales.id!;
    nameproduct.text = sales.productName!;
    quantity.text = sales.quantity!;
    unity.text = sales.unity!;
    salesPrice.text = sales.salesPrice!;
    _updateValue();
    dTCreated = sales.dateTimeCreated!;
    isSelected != isSelected;
    selectSales(sales);
    update();
  }

  selecteProductName(Stores stores) {
    nameproduct.text = stores.productName!;
    unity.text = stores.unity!;
    salesPrice.text = stores.salesPrice!;
  }

  void addSalesToDatabase() async {
    String ProductName = nameproduct.text;
    String Quantity = quantity.text;
    String Unity = unity.text;
    String SalesPrice = salesPrice.text;
    String values = value.text;
    if (formstate.currentState!.validate()) {
      Sales sales = Sales(
        productName: ProductName,
        quantity: Quantity,
        unity: Unity,
        salesPrice: SalesPrice,
        value: values,
        dateTimeCreated: DateFormat("MMM dd, yyyy").format(DateTime.now()),
      );

      Stores stores = Stores(
        productName: ProductName,
        quantity: Quantity,
        unity: Unity,
        salesPrice: SalesPrice,
        value: values,
      );

      try {
        await DatabaseHelper.instance.addSales(sales, stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        salesPrice.clear();
        value.clear();
        productNames.clear();
        getAllSales();
      } catch (e) {
        Get.defaultDialog(
            title: "خطأ",
            middleText: e.toString(),
            textCancel: "الغاء",
            textConfirm: "موافق",
            onConfirm: () {
              Get.back();
            },
            titleStyle: TextStyle(color: Colors.red),
            confirmTextColor: Colors.white,
            middleTextStyle:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
      }
    }
  }

  void deleteSales() async {
    String ProductName = nameproduct.text;
    String Quantity = quantity.text;
    String values = value.text;
    if (formstate.currentState!.validate()) {
      Sales sales = Sales(
        id: salesId,
      );
      Stores stores = Stores(
        productName: ProductName,
        quantity: Quantity,
        value: values,
      );
      try {
        await DatabaseHelper.instance.deleteSales(sales, stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        salesPrice.clear();
        value.clear();
        getAllSales();
      } catch (e) {
        print("خطأ: $e");
        print("محاولة عرض الحوار");
        Get.defaultDialog(
            title: "خطأ",
            middleText: "$e",
            textCancel: "الغاء",
            textConfirm: "موافق",
            onConfirm: () {
              Get.back();
            },
            titleStyle: TextStyle(color: Colors.red),
            confirmTextColor: Colors.white,
            middleTextStyle:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
        print("تم عرض الحوار");
      }
    }
  }

  // void deleteAllPurchases() async {
  //   await DatabaseHelper.instance.deleteAllPurchases();
  //   getAllPurchases();
  // }

  void updateSales() async {
    final productName = nameproduct.text;
    final Quantity = quantity.text;
    final Unity = unity.text;
    final SalesPrice = salesPrice.text;
    final values = value.text;

    Sales sales = Sales(
      id: salesId,
      productName: productName,
      quantity: Quantity,
      unity: Unity,
      salesPrice: SalesPrice,
      value: values,
      dateTimeCreated: dTCreated,
    );
    await DatabaseHelper.instance.updateSales(sales);
    nameproduct.clear();
    quantity.clear();
    unity.clear();
    salesPrice.clear();
    value.clear();
    getAllSales();
    Get.back();
  }

  @override
  void onInit() {
    nameproduct = TextEditingController();
    quantity = TextEditingController();
    unity = TextEditingController();
    salesPrice = TextEditingController();
    value = TextEditingController();
    super.onInit();
    getAllSales();
    quantity.addListener(_updateValue);
    salesPrice.addListener(_updateValue);
  }

  @override
  void dispose() {
    nameproduct.dispose();
    quantity.dispose();
    unity.dispose();
    salesPrice.dispose();
    value.dispose();
    super.dispose();
  }
}
