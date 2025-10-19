import 'package:flutter/material.dart';

class ButtonEv extends StatelessWidget {
  final String title;
  final VoidCallback? buttonFunction;
  final Color colorData;
  final Color textColor;

  const ButtonEv({
    super.key,
    required this.title,
    this.buttonFunction,
    this.colorData = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorData,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),

      onPressed: buttonFunction,
      child: Text("$title", style: TextStyle(fontSize: 16, color: textColor)),
    );
  }
}
