import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/checkout/check_out.dart';
import 'package:flutter/material.dart';

class Checkoutactionbutton extends StatelessWidget {
  final VoidCallback generateBill;
  const Checkoutactionbutton({super.key, required this.generateBill});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              color: Colors.red,
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                generateBill();
              },
              child: Container(
                height: 60,
                color: AppColors.Colorprimary,
                child: Center(
                  child: Text(
                    'Generate Bill',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
