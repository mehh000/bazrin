import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  final bool isIcon;
  final String hintitle;
  final double spcae;
  final String label;
  final bool islabel;
  final bool preicon;
  final bool required;
  final IconData iconName;
  final bool read;
  final TextEditingController? controller;
  const InputComponent({
    super.key,
    this.islabel = false,
    this.isIcon = false,
    required this.hintitle,
    this.spcae = 0,
    this.required = false,
    this.label = '',
    this.preicon = false,
    this.iconName = Icons.keyboard_arrow_down,
    this.controller,
    this.read = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spcae,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        islabel
            ? Row(
                children: [
                  Text(
                    '$label',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.colorBlack,
                    ),
                  ),
                  Visibility(
                    visible: required,
                    child: Text(
                      '*',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ],
              )
            : SizedBox(),
        TextField(
          readOnly: read,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            filled: true,
            fillColor: read ? Colors.grey.withOpacity(0.2) : Colors.white,
            hint: Text(
              '$hintitle',
              style: TextStyle(color: AppColors.colorTextGray),
            ),
            suffixIcon: isIcon ? Icon(iconName) : null,
            prefixIcon: preicon
                ? Icon(Icons.search_rounded, color: Colors.black, size: 20)
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1, color: AppColors.colorTextGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.colorTextGray),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
