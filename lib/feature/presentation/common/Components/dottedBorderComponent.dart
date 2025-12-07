import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class DottedBorderComponent extends StatelessWidget {
  final bool fullBorder;
  final bool topBorder;
  final bool bottomBorder;
  final Widget child;

  const DottedBorderComponent({
    super.key,
    this.fullBorder = true,
    this.topBorder = false,
    this.bottomBorder = false,
    required this.child,
  });

  /// Returns a function that builds the custom path based on the border type
  Path Function(Size) _buildCustomPath() {
    return (Size size) {
      final path = Path();

      if (fullBorder) {
        // top line
        path.moveTo(0, 0);
        path.relativeLineTo(size.width, 0);
        // bottom line
        path.moveTo(0, size.height);
        path.relativeLineTo(size.width, 0);
      } else if (topBorder) {
        path.moveTo(0, 0);
        path.relativeLineTo(size.width, 0);
      } else if (bottomBorder) {
        path.moveTo(0, size.height);
        path.relativeLineTo(size.width, 0);
      }

      return path;
    };
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        color: AppColors.colorTextGray,
        padding: const EdgeInsets.only(top: 15),
        strokeWidth: 1,
        dashPattern: const [8, 8],
        customPath: _buildCustomPath(),
      ),
      child: child,
    );
  }
}
