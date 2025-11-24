import 'package:flutter/material.dart';

class Iconevbutton extends StatelessWidget {
  final String title;
  final VoidCallback? buttonFunction;
  final Color colorData;
  final Color textColor;
  final bool isBorder;
  final Color borderColor;
  final IconData iconName;
  final Color iconColor;
  final double iconSize;
  final double height;

  const Iconevbutton({
    super.key,
    required this.title,
    this.buttonFunction,
    this.colorData = Colors.transparent,
    this.textColor = Colors.white,
    this.isBorder = false,
    this.borderColor = Colors.transparent,
    this.iconName = Icons.icecream_rounded,
    this.iconColor = Colors.white,
    this.iconSize = 22,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonFunction,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colorData),
        foregroundColor: WidgetStateProperty.all(textColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isBorder
                ? BorderSide(color: borderColor, width: 2)
                : BorderSide.none,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(0, height), // width 0 → auto, height controlled
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Row(
        spacing: 5,
        children: [
          Icon(iconName, color: iconColor, size: iconSize),
          Text(title, style: TextStyle(fontSize: 16, color: textColor)),
        ],
      ),
    );
  }
}
