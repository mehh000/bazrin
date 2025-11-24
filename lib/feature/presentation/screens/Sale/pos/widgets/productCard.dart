import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/dottedBorderComponent.dart';
import 'package:flutter/material.dart';

class Productcard extends StatefulWidget {
  const Productcard({super.key});

  @override
  State<Productcard> createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  int currentQty = 0;
  final int maxQty = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min, // ✅ important
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/t-shirt.png',
                  height: 100, // reduced height to fit grid
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Computer',
                style: TextStyle(
                  color: Color(0xFF646B72),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Red T-Shirt',
                style: TextStyle(
                  color: Color(0xFF212B36),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const DottedBorderComponent(
                child: SizedBox(width: double.infinity),
                topBorder: true,
                fullBorder: false,
              ),
              const SizedBox(height: 5),
              const Text(
                '\$300',
                style: TextStyle(
                  color: Color(0xFF212B36),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentQty > 0) currentQty--;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.Colorprimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 60,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$currentQty',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentQty < maxQty) currentQty++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.Colorprimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Top-right qty badge
          Positioned(
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF22c55e),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Qty:$maxQty',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
