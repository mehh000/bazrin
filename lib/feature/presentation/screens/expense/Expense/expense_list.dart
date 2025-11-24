import 'package:bazrin/feature/data/API/Helper/Expense/deleteExpenseById.dart';
import 'package:bazrin/feature/data/API/Helper/Expense/getExpenseList.dart';
import 'package:bazrin/feature/presentation/common/classes/imports.dart';
import 'package:bazrin/feature/presentation/common/widgets/flowting_icon_button.dart';
import 'package:bazrin/feature/presentation/screens/expense/Components/expense.dart';
import 'package:bazrin/feature/presentation/screens/products/Product/Add/add_products.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  bool _isExpanded = false;
  List<dynamic> expense_data_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExpenseList();
  }

  Future<void> getExpenseList() async {
    try {
      final response = await GetexpenseList.getExpenseList();
      // print('expense list : $response');
      setState(() {
        expense_data_list = response;
      });
    } catch (e) {
      // print(e);
    }
  }

  void _toggleExpand() {
    if (_isExpanded) {
      Navigator.of(context).push(
        SlidePageRoute(page: AddExpense(), direction: SlideDirection.right),
      );
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  void deleteExpense(id) async {
    // print('id : $id');
    try {
      await Deleteexpensebyid.DeleteExpense(id);
      getExpenseList();
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FlowtingIconButton(
          isExpanded: _isExpanded,
          toggleExpand: _toggleExpand,
          title: 'Add Expense',
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
            'Expense List',
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
                            hint: Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.Colorprimary,
                              ),
                            ),
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
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 13,
                              horizontal: 11,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 14, // match your design
                          ),
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
                      onRefresh: getExpenseList,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          spacing: 5,
                          children: expense_data_list
                              .map(
                                (ex) => Expense(
                                  expenseData: ex,
                                  delete: (e) {
                                    deleteExpense(e);
                                  },
                                ),
                              ) // returns a Widget
                              .toList(),
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
