import 'package:bazrin/feature/data/API/Helper/Expense/delExpenseProduct.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseProductsList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/flowting_icon_button.dart';
import 'package:bazrin/feature/presentation/screens/expense/Components/expense_product_card.dart';
import 'package:bazrin/feature/presentation/screens/products/Product/Add/add_products.dart';
import 'package:flutter/material.dart';

class ExpenseProductList extends StatefulWidget {
  const ExpenseProductList({super.key});

  @override
  State<ExpenseProductList> createState() => _ExpenseProductListState();
}

class _ExpenseProductListState extends State<ExpenseProductList> {
  bool _isExpanded = false;

  List<Map<String, dynamic>> productsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(
          page: AddExpenseProduct(),
          direction: SlideDirection.right,
        ),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  Future<void> getProducts() async {
    try {
      final response = await Getexpenseproductslist.getExpenseProductsList();

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        productsList = parsedList;
      });

      // print('products data : $parsedList');
    } catch (e) {
      // print('Error loading categories: $e');
    }
  }

  void delete(id) async {
    await Delexpenseproduct.DeleteExpenseProduct(id);
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Product',
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
            'Expense Product',
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
            Column(
              children: [
                SizedBox(height: 20),

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
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 5,
                        children: productsList
                            .map(
                              (pro) => ExpenseProductCard(
                                pro: pro,
                                delete: (id) {
                                  delete(id);
                                },
                              ),
                            )
                            .toList(),
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
