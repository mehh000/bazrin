import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Sale/Presentation/checkout/check_out.dart';
import 'package:flutter/material.dart';

class LastActionButtons extends StatelessWidget {
  final dynamic selectedItems;
  final VoidCallback cleanAll;
  final VoidCallback addToCheakOut;
  const LastActionButtons({
    super.key,
    required this.selectedItems,
    required this.cleanAll,
    required this.addToCheakOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                cleanAll();
              },
              child: Container(
                height: 60,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Clear All (${selectedItems.length})',
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                addToCheakOut();
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
