import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/screens/Sale/pos/widgets/productCard.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/paayment.dart';
import 'package:bazrin/feature/presentation/screens/Sale/widgets/product_search.dart';
import 'package:bazrin/feature/presentation/screens/supplier/sub_screens/Advance/filter-advance/filter.dart';
import 'package:flutter/material.dart';

class Pos extends StatefulWidget {
  const Pos({super.key});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Colorprimary,
        body: Column(
          children: [
            const SizedBox(height: 20),

            // 🔹 Top Bar
            Container(
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 20, // ✅ works in latest Flutter
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/3bar.svg',
                    width: 30,
                    height: 30,
                  ),

                  // Search bar expanded to fit space
                  const Expanded(child: ProductSearch()),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        SlidePageRoute(
                          page: const FilterAdvance(),
                          direction: SlideDirection.right,
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/images/icons/filter.svg',
                      height: 28,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Main Body
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, // max width per card
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7, // optional, can adjust or remove
                  ),
                  shrinkWrap: true, // lets the grid grow naturally
                  physics:
                      const BouncingScrollPhysics(), // optional scrolling effect
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const Productcard();
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              height: 65,
              color: Colors.white,
              child: Row(
                spacing: 35,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.Colorprimary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.Colorprimary,
                          size: 20,
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Colorprimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ButtonEv(
                      title: "Add to cart",
                      colorData: AppColors.Colorprimary,
                      buttonFunction: () {
                        Navigator.of(context).push(
                          SlidePageRoute(
                            page: Paayment(),
                            direction: SlideDirection.right,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
