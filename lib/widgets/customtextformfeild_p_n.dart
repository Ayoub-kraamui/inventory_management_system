import 'package:flutter/material.dart';
import 'package:inventory_management_system/model/store_modle.dart';

class CustomTextFormFeildProductName extends StatelessWidget {
  final String hintText;
  final String lable;
  final IconData iconData;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final List<Stores> productNames;
  final void Function(Stores)? onSelected;

  const CustomTextFormFeildProductName({
    super.key,
    required this.hintText,
    required this.lable,
    required this.iconData,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
    this.onSelected,
    required this.productNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 240,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Stores>.empty();
                }
                return productNames.where((Stores option) {
                  return option.productName!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              displayStringForOption: (Stores option) {
                return option.productName!; // استخدام اسم المنتج لعرضه
              },
              onSelected: onSelected,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onEditingComplete) {
                return TextFormField(
                  focusNode: focusNode,
                  obscureText: obscureText == null || obscureText == false
                      ? false
                      : true,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 14),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      label: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text(lable)),
                      suffixIcon:
                          InkWell(onTap: onTapIcon, child: Icon(iconData)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  keyboardType: isNumber
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                );
              },
            ),
          ],
        ));
  }
}
