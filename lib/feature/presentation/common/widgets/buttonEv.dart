import 'package:flutter/material.dart';

class ButtonEv extends StatelessWidget {
  final String title;
  final VoidCallback? buttonFunction;
  final Color colorData;
  final Color textColor;
  final bool isBorder;
  final Color borderColor;
  final bool isloading;

  const ButtonEv({
    super.key,
    required this.title,
    this.buttonFunction,
    this.colorData = Colors.transparent,
    this.textColor = Colors.white,
    this.isBorder = false,
    this.borderColor = Colors.transparent,
    this.isloading = false,
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
          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: isloading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(title, style: TextStyle(fontSize: 16, color: textColor)),
    );
  }
}
