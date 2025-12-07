import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class Headercomponent extends StatelessWidget {
  final String title;
  final FontWeight textWight;
  const Headercomponent({
    super.key,
    required this.title,
    this.textWight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.Colorprimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

      child: Text(
        '$title',
        style: TextStyle(
          fontSize: 16,
          fontWeight: textWight,
          color: Colors.white,
        ),
      ),
    );
  }
}
