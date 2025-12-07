import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  final bool isBorder;
  final String hintText;
  final TextEditingController? controller;
  const SimpleInput({super.key, this.hintText = '', this.isBorder = true, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: false,
      controller: controller,
      decoration: InputDecoration(
        hint: Text(hintText, style: TextStyle(color: AppColors.colorGray)),
        contentPadding: const EdgeInsets.all(5),
        enabledBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              )
            : OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
        focusedBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              )
            : OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
      ),
    );
  }
}
