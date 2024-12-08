import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/database_services/database_helper.dart';
import 'package:inventory_management_system/model/store_modle.dart';

class AddStoresDetailsController extends GetxController {
  TextEditingController nameproduct = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unity = TextEditingController();
  TextEditingController purchasePrice = TextEditingController();
  TextEditingController salesPrice = TextEditingController();
  TextEditingController value = TextEditingController();
  late int storesId;
  late String dTCreated;
  List<Stores> stores = <Stores>[];
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late bool isSelected;
  Stores? selectedStores;

  void selectStores(Stores stores) {
    selectedStores = stores;
  }

  void getAllStores() async {
    stores = await DatabaseHelper.instance.getStoresList();
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

  void fetchStoresDetails(Stores stores) {
    storesId = stores.id!;
    nameproduct.text = stores.productName!;
    quantity.text = stores.quantity!;
    unity.text = stores.unity!;
    purchasePrice.text = stores.purchasePrice!;
    salesPrice.text = stores.salesPrice!;
    _updateValue();
    selectStores(stores);
    update();
  }

  void addStoresToDatabase() async {
    String ProductName = nameproduct.text;
    String Quantity = quantity.text;
    String Unity = unity.text;
    String PurchasePrice = purchasePrice.text;
    String SalesPrice = salesPrice.text;
    String values = value.text;

    if (formstate.currentState!.validate()) {
      Stores stores = Stores(
        productName: ProductName,
        quantity: Quantity,
        unity: Unity,
        purchasePrice: PurchasePrice,
        salesPrice: SalesPrice,
        value: values,
      );

      try {
        await DatabaseHelper.instance.addStores(stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        purchasePrice.clear();
        salesPrice.clear();
        value.clear();
        getAllStores();
      } catch (e) {
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
      }
    }
  }

  void deleteStores() async {
    if (formstate.currentState!.validate()) {
      Stores stores = Stores(
        id: storesId,
      );
      try {
        await DatabaseHelper.instance.deleteStores(stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        purchasePrice.clear();
        salesPrice.clear();
        value.clear();
        getAllStores();
      } catch (e) {
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
      }
    }
  }

  // void deleteAllPurchases() async {
  //   await DatabaseHelper.instance.deleteAllPurchases();
  //   getAllPurchases();
  // }

  void updateStores() async {
    final productName = nameproduct.text;
    final Quantity = quantity.text;
    final Unity = unity.text;
    final PurchasePrice = purchasePrice.text;
    final SalesPrice = salesPrice.text;
    final values = value.text;

    if (formstate.currentState!.validate()) {
      Stores stores = Stores(
        id: storesId,
        productName: productName,
        quantity: Quantity,
        unity: Unity,
        purchasePrice: PurchasePrice,
        salesPrice: SalesPrice,
        value: values,
      );
      try {
        await DatabaseHelper.instance.updateStores(stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        purchasePrice.clear();
        salesPrice.clear();
        value.clear();
        getAllStores();
      } catch (e) {
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
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllStores();
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
