import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getPosProductList.dart';
import 'package:bazrin/feature/data/API/Helper/Pos/Sale/getPosSale.dart';
import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/screens/Sale/pos/widgets/productCard.dart';
import 'package:bazrin/feature/presentation/screens/Sale/sub_screens/payemnt/paayment.dart';
import 'package:bazrin/feature/presentation/screens/Sale/widgets/product_search.dart';
import 'package:bazrin/feature/presentation/screens/supplier/sub_screens/Advance/filter-advance/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Pos extends StatefulWidget {
  const Pos({super.key});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  dynamic posItems;
  bool isloading = false;
  dynamic selectedItems = [];

  @override
  void initState() {
    super.initState();
    getposItems();
  }

  Future<void> getposItems() async {
    setState(() => isloading = true);

    final response = await Getposproductlist.getPosProductList();
    setState(() {
      posItems = response;
      isloading = false;
    });
  }

  void addItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index == -1) {
      selectedItems.add(item);
    } else {
      selectedItems.removeAt(index);
    }
    setState(() {});
  }

  void incrementAddedItemToCart(item) {
    final id = item['id'];

    final index = selectedItems.indexWhere((e) => e['id'] == id);

    if (index != -1) {
      selectedItems[index] = item;
    }
    setState(() {});
  }

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
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Color(0xFFF5F5F7),
                child: isloading
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => getposItems(),
                        child: AlignedGridView.count(
                          physics: AlwaysScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemCount: posItems.length,
                          itemBuilder: (context, index) {
                            return Productcard(
                              posItems: posItems[index],
                              addfuntion: (e) {
                                addItemToCart(e);
                              },
                              addremovefuntion: (e) {
                                incrementAddedItemToCart(e);
                              },
                            );
                          },
                        ),
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
                          '${selectedItems.length}',
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
                            page: Paayment(selectedItems : selectedItems),
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
