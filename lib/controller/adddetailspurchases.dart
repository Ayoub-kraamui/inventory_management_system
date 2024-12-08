import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_system/database_services/database_helper.dart';
import 'package:inventory_management_system/model/purchases_model.dart';
import 'package:inventory_management_system/model/store_modle.dart';

class AddPurchasesDetailsController extends GetxController {
  TextEditingController nameproduct = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController unity = TextEditingController();
  TextEditingController purchasePrice = TextEditingController();
  TextEditingController salesPrice = TextEditingController();
  TextEditingController value = TextEditingController();
  late int purchasesId;
  late String dTCreated;
  List<Purchases> purchases = <Purchases>[];
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late bool isSelected;
  Purchases? selectedPurchase;
  List<Stores> productNames = <Stores>[];
  bool isDaily = false;
  bool isWeekly = false;
  bool isMonthly = false;

  void selectPurchase(Purchases purchase) {
    selectedPurchase = purchase;
  }

  void updatefetchDailyPurchases() {
    isDaily = !isDaily;
    getAllPurchases();
  }

  void updatefetchWeeklyPurchases() {
    isWeekly = !isWeekly;
    getAllPurchases();
  }

  void updatefetchMonthyPurchases() {
    isMonthly = !isMonthly;
    getAllPurchases();
  }

  selecteProductName(Stores stores) {
    nameproduct.text = stores.productName!;
    unity.text = stores.unity!;
    purchasePrice.text = stores.purchasePrice!;
    salesPrice.text = stores.salesPrice!;
  }

  void getAllPurchases() async {
    productNames = await DatabaseHelper.instance.getStoresList();

    if (isDaily == true && isWeekly == false && isMonthly == false) {
      purchases = await DatabaseHelper.instance.getDailyPurchases();
    } else if (isDaily == false && isWeekly == true && isMonthly == false) {
      purchases = await DatabaseHelper.instance.getWeeklyPurchases();
    } else if (isDaily == false && isWeekly == false && isMonthly == true) {
      purchases = await DatabaseHelper.instance.getMonthlyPurchases();
    } else {
      purchases = await DatabaseHelper.instance.getpurchasesList();
    }
    update();
  }

  void _updateValue() {
    // تحويل الكمية وسعر الشراء إلى double
    double qty = double.tryParse(quantity.text) ?? 0;
    double price = double.tryParse(purchasePrice.text) ?? 0;

    // حساب القيمة
    double calculatedValue = qty * price;

    // تحديث حقل القيمة
    value.text = calculatedValue.toString();
  }

  void fetchPurchaseDetails(Purchases purchase) {
    purchasesId = purchase.id!;
    nameproduct.text = purchase.productName!;
    quantity.text = purchase.quantity!;
    unity.text = purchase.unity!;
    purchasePrice.text = purchase.purchasePrice!;
    salesPrice.text = purchase.salesPrice!;
    _updateValue();
    dTCreated = purchase.dateTimeCreated!;
    selectPurchase(purchase);
    update();
  }

  void addPurchasesToDatabase() async {
    String ProductName = nameproduct.text;
    String Quantity = quantity.text;
    String Unity = unity.text;
    String PurchasePrice = purchasePrice.text;
    String SalesPrice = salesPrice.text;
    String values = value.text;
    if (formstate.currentState!.validate()) {
      Purchases purchases = Purchases(
        productName: ProductName,
        quantity: Quantity,
        unity: Unity,
        purchasePrice: PurchasePrice,
        salesPrice: SalesPrice,
        value: values,
        dateTimeCreated: DateFormat("MMM dd, yyyy").format(DateTime.now()),
      );

      Stores stores = Stores(
        productName: ProductName,
        quantity: Quantity,
        unity: Unity,
        purchasePrice: PurchasePrice,
        salesPrice: SalesPrice,
        value: values,
      );

      try {
        await DatabaseHelper.instance.addPurchases(purchases, stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        purchasePrice.clear();
        salesPrice.clear();
        value.clear();
        getAllPurchases();
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

  void deletePurchases() async {
    String ProductName = nameproduct.text;
    String Quantity = quantity.text;
    String values = value.text;

    if (formstate.currentState!.validate()) {
      Purchases purchases = Purchases(
        id: purchasesId,
      );

      Stores stores = Stores(
        productName: ProductName,
        quantity: Quantity,
        value: values,
      );
      try {
        await DatabaseHelper.instance.deletePurchases(purchases, stores);
        nameproduct.clear();
        quantity.clear();
        unity.clear();
        purchasePrice.clear();
        salesPrice.clear();
        value.clear();
        getAllPurchases();
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

  void updatePurchases() async {
    final productName = nameproduct.text;
    final Quantity = quantity.text;
    final Unity = unity.text;
    final PurchasePrice = purchasePrice.text;
    final SalesPrice = salesPrice.text;
    final values = value.text;

    Purchases purchases = Purchases(
      id: purchasesId,
      productName: productName,
      quantity: Quantity,
      unity: Unity,
      purchasePrice: PurchasePrice,
      salesPrice: SalesPrice,
      value: values,
      dateTimeCreated: dTCreated,
    );
    await DatabaseHelper.instance.updatePurchases(purchases);
    nameproduct.clear();
    quantity.clear();
    unity.clear();
    purchasePrice.clear();
    salesPrice.clear();
    value.clear();
    getAllPurchases();
  }

  @override
  void onInit() {
    super.onInit();
    getAllPurchases();
    quantity.addListener(_updateValue);
    purchasePrice.addListener(_updateValue);
  }

  @override
  void dispose() {
    nameproduct.dispose();
    quantity.dispose();
    unity.dispose();
    purchasePrice.dispose();
    salesPrice.dispose();
    value.dispose();
    super.dispose();
  }
}
