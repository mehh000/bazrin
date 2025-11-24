import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/checkout/check_out.dart';
import 'package:flutter/material.dart';

class LastActionButtons extends StatelessWidget {
  const LastActionButtons({super.key});

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
                  'Clear All (2)',
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
                Navigator.of(context).push(
                  SlidePageRoute(
                    page: CheckOut(),
                    direction: SlideDirection.right,
                  ),
                );
              },
              child: Container(
                height: 60,
                color: AppColors.Colorprimary,
                child: Center(
                  child: Text(
                    'CheckOut',
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
