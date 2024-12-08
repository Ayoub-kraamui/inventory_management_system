import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/controller/login_controller.dart';
import 'package:inventory_management_system/function/validinput.dart';
import 'package:inventory_management_system/widgets/customtextformfeild.dart';
import 'package:inventory_management_system/widgets/login/custombuttomauth.dart';
import 'package:inventory_management_system/widgets/login/customcontant_textauth.dart';
import 'package:inventory_management_system/widgets/login/customtitletext.dart';
import 'package:inventory_management_system/widgets/login/logoauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LogInController controller = Get.put(LogInController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "تسجيل الدخول",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                const LogoAuth(),
                const CustomTitleTextAuth(
                  text: "اهلا بك",
                ),
                const SizedBox(height: 10),
                const CustomContantTextAuth(
                    text:
                        "يمكنك تسجيل الدخول من خلال اسم المستخدم وكلمة المرور"),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormFeildSystem(
                        valid: (val) {
                          return validInput(val!, 4, 100, "username");
                        },
                        mycontroller: controller.username,
                        hintText: "ادخل اسم المستخدم".tr,
                        lable: "اسم المستخدم".tr,
                        iconData: Icons.email_outlined,
                        isNumber: false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormFeildSystem(
                      valid: (val) {
                        return validInput(val!, 8, 30, "password");
                      },
                      mycontroller: controller.password,
                      hintText: "ادخل كلمة المرور".tr,
                      lable: "كلمة المرور".tr,
                      iconData: controller.isshowpassword
                          ? Icons.no_encryption_outlined
                          : Icons.lock_outline,
                      isNumber: false,
                      obscureText: controller.isshowpassword,
                      onTapIcon: () {
                        controller.showPassword();
                      },
                    ),
                  ],
                ),
                CustomButtomAuth(
                    text: "تسجيل الدخول".tr,
                    onPressed: () {
                      controller.login();
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
