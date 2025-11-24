import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/iconEvButton.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/widgets/item_card.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/widgets/last_action_buttons.dart';
import 'package:flutter/material.dart';

class Paayment extends StatefulWidget {
  const Paayment({super.key});

  @override
  State<Paayment> createState() => _PaaymentState();
}

class _PaaymentState extends State<Paayment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.containerColor,

        // ✅ Yellow container always fixed at bottom
        bottomNavigationBar: LastActionButtons(),

        body: Column(
          children: [
            // ✅ Header stays fixed
            Container(
              height: 80,
              color: AppColors.Colorprimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.keyboard_arrow_left, color: Colors.white),

                  // Search bar
                  Expanded(
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Walking Customer',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Icon(Icons.cancel_outlined, color: Colors.white),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Iconevbutton(
                    title: '',
                    colorData: Colors.white,
                    iconName: Icons.person_add_alt_1,
                    iconColor: AppColors.Colorprimary,
                    iconSize: 22,
                    height: 40,
                  ),
                ],
              ),
            ),

            // ✅ Scrollable content below header
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Headercomponent(title: "Item List"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Column(
                                spacing: 12,
                                children: const [
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                  PosSellItem(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ), // prevent cutoff before bottom bar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
