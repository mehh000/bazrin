import 'package:bazrin/feature/data/API/Helper/Expense/delExpenseProduct.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseProductsList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/Components/flowting_icon_button.dart';
import 'package:bazrin/feature/presentation/screens/expense/Components/expense_product_card.dart';
import 'package:bazrin/feature/presentation/screens/products/Presentation/Product/Add/add_products.dart';
import 'package:flutter/material.dart';

class ExpenseProductList extends StatefulWidget {
  const ExpenseProductList({super.key});

  @override
  State<ExpenseProductList> createState() => _ExpenseProductListState();
}

class _ExpenseProductListState extends State<ExpenseProductList> {
  bool _isExpanded = false;
 
  List<Map<String, dynamic>> productsList = [];
  final ScrollController _scrollController = ScrollController();
  int page = 0;
  bool isLoadingMore = false;
  bool noMoreData = false;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
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
    page = 0;
    noMoreData = false;
    try {
      final response = await Getexpenseproductslist.getExpenseProductsList(
        page,
      );

      // Safely cast and convert
      final List<Map<String, dynamic>> parsedList = (response['data'] as List)
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

  Future<void> loadMore() async {
    if (isLoadingMore || noMoreData) return;

    isLoadingMore = true;
    page++;

    final response = await Getexpenseproductslist.getExpenseProductsList(page);

    int totalPage = response["totalPage"];
    List<dynamic> newData = response["data"];

    if (newData.isEmpty || page >= totalPage) {
      noMoreData = true;
    }

    // Convert safely
    final List<Map<String, dynamic>> parsedNew =
        List<Map<String, dynamic>>.from(newData);

    setState(() {
      productsList.addAll(parsedNew);
    });

    isLoadingMore = false;
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
                    child: RefreshIndicator(
                      onRefresh: getProducts, 
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller:
                            _scrollController, 
                        itemCount:
                            productsList.length +
                            1,
                        separatorBuilder: (_, __) => const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                        
                          if (index == productsList.length) {
                            return isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }

                          final pro = productsList[index];
                          return ExpenseProductCard(
                            pro: pro,
                            delete: (id) {
                              delete(id);
                            },
                          );
                        },
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
