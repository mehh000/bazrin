import 'package:bazrin/feature/data/API/Helper/Product/deleteProductById.dart';
import 'package:bazrin/feature/data/API/Helper/Product/getProductList.dart';
import 'package:bazrin/feature/presentation/common/classes/SlidePageRoute.dart';
import 'package:bazrin/feature/presentation/common/classes/colors.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/classes/prettyPrint.dart';
import 'package:bazrin/feature/presentation/common/widgets/flowting_icon_button.dart';
import 'package:bazrin/feature/presentation/screens/home/Main/home_screen.dart';
import 'package:bazrin/feature/presentation/screens/products/Product/Add/add_products.dart';
import 'package:bazrin/feature/presentation/screens/products/subScreen/Filter/filter.dart';
import 'package:bazrin/feature/presentation/screens/products/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isExpanded = false;
  dynamic products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddProducts(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getProducts() async {
    final response = await Getproductlist.getProductList();
    setState(() {
      products = response;
    });
  }

  void delete(id) async {
    final response = await Deleteproductbyid.DeleteProduct(id);
    if (response == 'success') {
      TostMessage.showToast(
        context,
        message: "Product Deleted Successfull",
        isSuccess: true,
      );
    }
    print('id $id');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add User',
        ),
        appBar: AppBar(
          backgroundColor: AppColors.Colorprimary,
          leading: Row(
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    SlidePageRoute(
                      page: HomeScreen(),
                      direction: SlideDirection.left,
                    ),
                  );
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ],
          ),
          title: Text(
            'Product List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.Colorprimary,
        body: Stack(
          children: [
            // 1️⃣ Main content
            Column(
              children: [
                // ======Header=========
                Container(
                  color: AppColors.Colorprimary,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Row(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            suffixIcon: Icon(
                              Icons.search,
                              size: 25,
                              color: AppColors.Colorprimary,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 13,
                              horizontal: 11,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            SlidePageRoute(
                              page: Filter(),
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
                SizedBox(height: 20),
                // =======Body=======
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: products != null
                        ? RefreshIndicator(
                            onRefresh: getProducts,
                            child: ListView.separated(
                              separatorBuilder: (_, __) => SizedBox(height: 8),
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: products.length,

                              itemBuilder: (context, index) {
                                dynamic pro = products[index];
                                return Product(
                                  pro: pro,
                                  delete: (id) {
                                    delete(id);
                                  },
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              'No Product Found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),

            if (_isExpanded)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Container(color: Colors.transparent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
