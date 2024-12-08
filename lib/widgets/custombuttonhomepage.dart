import 'package:flutter/material.dart';

class CustomButtonHomePage extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  final IconData? icon;
  const CustomButtonHomePage(
      {super.key, required this.onPressed, required this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      height: 60,
      width: 215,
      child: MaterialButton(
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(width: 5),
              Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
            ],
          )),
    );
  }
}
