import 'package:flutter/material.dart';

class CustomTextFormFeildSystem extends StatelessWidget {
  final String hintText;
  final String lable;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  const CustomTextFormFeildSystem(
      {super.key,
      required this.hintText,
      required this.lable,
      required this.iconData,
      this.mycontroller,
      required this.valid,
      required this.isNumber,
      this.obscureText,
      this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextFormField(
        validator: valid,
        obscureText: obscureText == null || obscureText == false ? false : true,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(lable)),
            suffixIcon: InkWell(onTap: onTapIcon, child: Icon(iconData)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
      ),
    );
  }
}
