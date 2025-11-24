import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:flutter/material.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 5,
        children: [
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/images/icons/barcode.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Expanded(
            child: TextField(
              showCursor: true,
              decoration: InputDecoration(
                hintText: 'Search by name/Barcode...',
                hintStyle: TextStyle(color: Colors.green),

                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
