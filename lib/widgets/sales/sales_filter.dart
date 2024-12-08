import 'package:flutter/material.dart';

class CheckOutFilter extends StatelessWidget {
  final String title;
  final bool? value;
  final void Function(bool?)? onChanged;
  const CheckOutFilter(
      {super.key, required this.title, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
