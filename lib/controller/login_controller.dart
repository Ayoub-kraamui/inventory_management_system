import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/approute.dart';

class LogInController extends GetxController {
  late TextEditingController username;
  late TextEditingController password;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isshowpassword = true;

  String? token;
  showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  login() async {
    if (username.text == "1234" && password.text == "1234") {
      Get.offNamed(AppRoute.homepage);
    } else if (username.text == "" || password.text == "") {
      Get.defaultDialog(
        title: "خطأ",
        middleText: "يرجى التأكد من إخال البيانات",
        textCancel: "الغاء",
        textConfirm: "موافق",
        onConfirm: () {
          Get.back();
        },
      );
    } else {
      Get.defaultDialog(
        title: "خطأ",
        middleText: "اسم المستخدم او كلمة المرور غير صحيحة",
        textCancel: "الغاء",
        textConfirm: "موافق",
        onConfirm: () {
          Get.back();
        },
      );
    }
    update();
  }

  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
