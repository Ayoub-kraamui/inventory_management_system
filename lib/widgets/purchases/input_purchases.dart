import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/adddetailspurchases.dart';
import 'package:inventory_management_system/function/validinput.dart';
import 'package:inventory_management_system/widgets/customtextformfeild.dart';
import 'package:inventory_management_system/widgets/customtextformfeild_p_n.dart';
import 'package:inventory_management_system/widgets/sales/sales_filter.dart';

class InputPurchases extends GetView<AddPurchasesDetailsController> {
  const InputPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formstate,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: GetBuilder<AddPurchasesDetailsController>(
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormFeildProductName(
                      hintText: "إختر بيانات المنتج تلقائيا",
                      lable: "بحث",
                      iconData: Icons.search_outlined,
                      isNumber: false,
                      productNames: controller.productNames,
                      onSelected: (selecte) {
                        controller.selecteProductName(selecte);
                      },
                    ),
                    CheckOutFilter(
                      value: controller.isDaily,
                      onChanged: (Value) {
                        controller.updatefetchDailyPurchases();
                      },
                      title: "المشتريات اليومية",
                    ),
                    CheckOutFilter(
                        value: controller.isWeekly,
                        onChanged: (Value) {
                          controller.updatefetchWeeklyPurchases();
                        },
                        title: "المشتريات الأسبوعية"),
                    CheckOutFilter(
                      value: controller.isMonthly,
                      onChanged: (Value) {
                        controller.updatefetchMonthyPurchases();
                      },
                      title: "المشتريات الشهرية",
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFormFeildSystem(
                  hintText: "ادخل اسم المنتج",
                  lable: "اسم المنتج",
                  iconData: Icons.production_quantity_limits,
                  mycontroller: controller.nameproduct,
                  valid: (val) {
                    return validInput(val!, 2, 50, "product name");
                  },
                  isNumber: false,
                ),
                CustomTextFormFeildSystem(
                    hintText: "ادخل الكمية",
                    lable: "الكمية",
                    iconData: Icons.format_list_numbered,
                    mycontroller: controller.quantity,
                    valid: (val) {
                      return validInput(val!, 1, 50, "quantity");
                    },
                    isNumber: true),
                CustomTextFormFeildSystem(
                    hintText: "ادخل نوع الوحدة",
                    lable: "الوحدة",
                    iconData: Icons.ad_units_rounded,
                    mycontroller: controller.unity,
                    valid: (val) {
                      return validInput(val!, 2, 50, "unity");
                    },
                    isNumber: false),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormFeildSystem(
                      hintText: "ادخل سعر الشراء للوحدة الواحدة",
                      lable: "سعر الشراء",
                      iconData: Icons.money_outlined,
                      mycontroller: controller.purchasePrice,
                      valid: (val) {
                        return validInput(val!, 3, 50, "purchase Price");
                      },
                      isNumber: true),
                  CustomTextFormFeildSystem(
                      hintText: "ادخل سعر البيع للوحدة الواحدة",
                      lable: "سعر البيع",
                      iconData: Icons.money_outlined,
                      mycontroller: controller.salesPrice,
                      valid: (val) {
                        return validInput(val!, 1, 50, "sales Price");
                      },
                      isNumber: true),
                  CustomTextFormFeildSystem(
                      hintText: "ادخل اجمالي السعر",
                      lable: "إجمالي السعر",
                      iconData: Icons.money_outlined,
                      mycontroller: controller.value,
                      valid: (val) {
                        return validInput(val!, 1, 50, "value");
                      },
                      isNumber: true),
                ]),
          )
        ],
      ),
    );
  }
}
