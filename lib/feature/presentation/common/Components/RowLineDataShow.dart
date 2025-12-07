import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:flutter/material.dart';

class Rowlinedatashow extends StatelessWidget {
  final String right;
  final String left;
  final Color leftTextColor;
  final Color rightTextColor;
  final IconData lefticonName;
  final IconData righticonName;
  final bool leftIcon;
  final bool rightIcon;
  final double fontSize;
  final FontWeight fontw;

  const Rowlinedatashow({
    super.key,
    required this.left,
    required this.right,
    this.leftTextColor = AppColors.colorBlack,
    this.lefticonName = Icons.phone,
    this.rightTextColor = AppColors.colorBlack,
    this.righticonName = Icons.call,
    this.leftIcon = false,
    this.rightIcon = false,
    this.fontSize = 12,
    this.fontw = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leftIcon)
                Icon(lefticonName, size: 15, color: AppColors.colorGray),
              if (leftIcon) const SizedBox(width: 4),
              Text(
                left,
                style: TextStyle(
                  color: leftTextColor,
                  fontSize: fontSize,
                  fontWeight: fontw,
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (rightIcon)
                    Icon(righticonName, size: 15, color: AppColors.colorGray),
                  if (rightIcon) const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      right,
                      textAlign: TextAlign.end,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: rightTextColor,
                        fontSize: fontSize,
                        fontWeight: fontw,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
