import 'package:flutter/material.dart';

class CustomButtonSystem extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  final IconData? icon;
  const CustomButtonSystem(
      {super.key, required this.onPressed, required this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      height: 60,
      width: 150,
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
              SizedBox(width: 20),
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
